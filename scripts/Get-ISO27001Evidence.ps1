#Requires -Version 5.1

<#
.SYNOPSIS
    Collects ISO 27001:2022 Annex A control evidence from Microsoft 365 and Azure environments.

.DESCRIPTION
    Get-ISO27001Evidence is a modular evidence collection script for ISO 27001:2022 Annex A controls.
    It connects to Microsoft Graph and Exchange Online, collects configuration and log data, and
    exports artefacts named according to the repository evidence naming convention:

        YYYY-MM-DD_CONTROL-ID_SYSTEM_EVIDENCE-TYPE_OWNER_VERSION.ext

    Each function targets a specific Annex A control and can be invoked individually or via the
    -ControlID or -All parameters.

.PARAMETER ControlID
    The Annex A control ID to collect evidence for. Accepted values: A.8.5, A.5.15, A.8.15,
    A.5.16, A.8.7, A.5.18, A.8.1, A.8.12, A.8.16.

.PARAMETER All
    Run all evidence collection functions.

.PARAMETER ReportOnly
    Display results to the console without writing output files. All evidence functions are
    read-only against the tenant in every mode; this switch only suppresses local file output.
    The functions added for A.5.18, A.8.1, A.8.12, and A.8.16 default to report-only: they
    write files only when -OutputPath is supplied explicitly or -ReportOnly is absent and
    -OutputPath is given.

.PARAMETER OutputPath
    Directory path for output files. Defaults to the current working directory.

.PARAMETER Owner
    Evidence owner identifier used in the output filename. Defaults to "ITSecurity".

.EXAMPLE
    .\Get-ISO27001Evidence.ps1 -ControlID A.8.15

    Collects and exports audit log status evidence for control A.8.15.

.EXAMPLE
    .\Get-ISO27001Evidence.ps1 -All -OutputPath "C:\EvidencePack\2026-05"

    Runs all evidence collection functions and writes output to the specified directory.

.EXAMPLE
    .\Get-ISO27001Evidence.ps1 -ControlID A.8.5 -ReportOnly

    Displays MFA registration data in the console without writing any files.

.NOTES
    Prerequisites:
    - Microsoft.Graph PowerShell module (Install-Module Microsoft.Graph)
    - ExchangeOnlineManagement module (Install-Module ExchangeOnlineManagement)
    - Appropriate permissions: Reports.Read.All, Policy.Read.All, RoleManagement.Read.Directory,
      Directory.Read.All, DeviceManagementConfiguration.Read.All, AccessReview.Read.All,
      DeviceManagementManagedDevices.Read.All, IdentityRiskEvent.Read.All, plus Security and
      Compliance PowerShell access for the A.8.12 DLP policy export.
      See docs/permissions-matrix.md for the minimum scopes per function.

    All evidence functions are read-only: they call Microsoft Graph GET endpoints or read-only
    Get-* cmdlets and never change tenant configuration.

    Version : 1.1.0
    Author  : ISO 27001 Controls to Reality
    Licence : MIT
#>

[CmdletBinding(DefaultParameterSetName = 'ByControlID')]
param (
    [Parameter(ParameterSetName = 'ByControlID', Mandatory = $true)]
    [ValidateSet('A.8.5', 'A.5.15', 'A.8.15', 'A.5.16', 'A.8.7', 'A.5.18', 'A.8.1', 'A.8.12', 'A.8.16')]
    [string]$ControlID,

    [Parameter(ParameterSetName = 'All', Mandatory = $true)]
    [switch]$All,

    [switch]$ReportOnly,

    [string]$OutputPath = (Get-Location).Path,

    [string]$Owner = 'ITSecurity'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

#region Helpers

function Get-EvidenceFileName {
    <#
    .SYNOPSIS
        Generates a filename following the repository evidence naming convention.
    .PARAMETER ControlID
        Annex A control ID (e.g. A.8.15).
    .PARAMETER System
        Short system or service identifier (e.g. M365-UAL, EntraID).
    .PARAMETER EvidenceType
        Short descriptor of the evidence type (e.g. ConfigExport, RoleAssignments).
    .PARAMETER Extension
        File extension without leading dot (e.g. csv, json).
    .PARAMETER Owner
        Evidence owner identifier.
    #>
    param (
        [string]$ControlID,
        [string]$System,
        [string]$EvidenceType,
        [string]$Extension,
        [string]$Owner
    )
    $date = Get-Date -Format 'yyyy-MM-dd'
    $safeControl = $ControlID -replace '\.', '-'
    return "${date}_${safeControl}_${System}_${EvidenceType}_${Owner}_v1.${Extension}"
}

function Assert-GraphConnected {
    <#
    .SYNOPSIS
        Checks for an existing Microsoft Graph session and connects if one is not present.
    .PARAMETER Scopes
        Array of Microsoft Graph permission scopes required by the caller.
    #>
    param ([string[]]$Scopes)
    try {
        $context = Get-MgContext -ErrorAction SilentlyContinue
        if (-not $context) {
            Write-Host "[AUTH] No existing Graph session detected. Connecting..." -ForegroundColor Yellow
            Connect-MgGraph -Scopes $Scopes -NoWelcome
        } else {
            $missing = $Scopes | Where-Object { $_ -notin $context.Scopes }
            if ($missing) {
                Write-Host "[AUTH] Reconnecting to add missing scopes: $($missing -join ', ')" -ForegroundColor Yellow
                Connect-MgGraph -Scopes $Scopes -NoWelcome
            } else {
                Write-Host "[AUTH] Using existing Graph session as $($context.Account)" -ForegroundColor Green
            }
        }
    } catch {
        Write-Error "Failed to connect to Microsoft Graph: $_"
        throw
    }
}

function Assert-ExchangeConnected {
    <#
    .SYNOPSIS
        Checks for an existing Exchange Online session and connects if one is not present.
    #>
    try {
        $session = Get-PSSession | Where-Object { $_.ComputerName -like '*outlook*' -and $_.State -eq 'Opened' }
        if (-not $session) {
            Write-Host "[AUTH] No existing Exchange Online session detected. Connecting..." -ForegroundColor Yellow
            Connect-ExchangeOnline -ShowBanner:$false
        } else {
            Write-Host "[AUTH] Using existing Exchange Online session." -ForegroundColor Green
        }
    } catch {
        Write-Error "Failed to connect to Exchange Online: $_"
        throw
    }
}

function Assert-ComplianceConnected {
    <#
    .SYNOPSIS
        Checks for an existing Security and Compliance PowerShell session and connects if one is not present.
    .DESCRIPTION
        Security and Compliance cmdlets (e.g. Get-DlpCompliancePolicy) are only available after
        Connect-IPPSSession. The session is used for read-only Get-* cmdlets only.
    #>
    try {
        if (-not (Get-Command Get-DlpCompliancePolicy -ErrorAction SilentlyContinue)) {
            Write-Host "[AUTH] No Security and Compliance session detected. Connecting..." -ForegroundColor Yellow
            Connect-IPPSSession -ShowBanner:$false
        } else {
            Write-Host "[AUTH] Using existing Security and Compliance session." -ForegroundColor Green
        }
    } catch {
        Write-Error "Failed to connect to Security and Compliance PowerShell: $_"
        throw
    }
}

function Write-EvidenceFile {
    <#
    .SYNOPSIS
        Writes collected data to a CSV file in the output directory.
    .PARAMETER Data
        The data objects to export.
    .PARAMETER FileName
        The target filename (basename only; OutputPath is prepended).
    .PARAMETER OutputPath
        Directory to write the file to.
    #>
    param (
        [object[]]$Data,
        [string]$FileName,
        [string]$OutputPath
    )
    $fullPath = Join-Path -Path $OutputPath -ChildPath $FileName
    $Data | Export-Csv -Path $fullPath -NoTypeInformation -Encoding UTF8
    Write-Host "[OUTPUT] Evidence written to: $fullPath" -ForegroundColor Cyan
}

#endregion Helpers

#region Evidence Functions

function Get-MFAStatus {
    <#
    .SYNOPSIS
        Collects the MFA registration report for all users. Maps to A.8.5 (Secure Authentication).
    .DESCRIPTION
        Queries the Microsoft Graph Authentication Methods registration details report and returns
        per-user MFA registration status, default MFA method, and passwordless capability.
        Requires Reports.Read.All scope.
    .PARAMETER ReportOnly
        If set, outputs results to the console instead of writing a file.
    .PARAMETER OutputPath
        Directory for the output CSV.
    .PARAMETER Owner
        Evidence owner identifier for the filename.
    #>
    [CmdletBinding()]
    param (
        [switch]$ReportOnly,
        [string]$OutputPath,
        [string]$Owner
    )

    Write-Host "`n[A.8.5] Collecting MFA registration status..." -ForegroundColor Magenta

    Assert-GraphConnected -Scopes @('Reports.Read.All', 'UserAuthenticationMethod.Read.All')

    try {
        $report = Get-MgReportAuthenticationMethodUserRegistrationDetail -All |
            Select-Object UserPrincipalName, IsMfaRegistered, IsMfaCapable,
                          IsPasswordlessCapable, IsSsprRegistered, DefaultMfaMethod,
                          @{N='MethodsRegistered'; E={ $_.MethodsRegistered -join '; ' }}

        $total    = ($report | Measure-Object).Count
        $mfaDone  = ($report | Where-Object { $_.IsMfaRegistered }).Count
        $coverage = if ($total -gt 0) { [math]::Round(($mfaDone / $total) * 100, 1) } else { 0 }

        Write-Host "[A.8.5] Users: $total | MFA Registered: $mfaDone | Coverage: $coverage%" -ForegroundColor White

        if ($ReportOnly) {
            $report | Format-Table -AutoSize
        } else {
            $fileName = Get-EvidenceFileName -ControlID 'A.8.5' -System 'EntraID' `
                            -EvidenceType 'MFA-RegistrationReport' -Extension 'csv' -Owner $Owner
            Write-EvidenceFile -Data $report -FileName $fileName -OutputPath $OutputPath
        }
    } catch {
        Write-Warning "[A.8.5] Failed to collect MFA status: $_"
    }
}

function Get-ConditionalAccess {
    <#
    .SYNOPSIS
        Exports all Conditional Access policies and their state. Maps to A.5.15 (Access Control).
    .DESCRIPTION
        Retrieves all Conditional Access policies from Microsoft Entra ID, including display name,
        state (Enabled/Disabled/enabledForReportingButNotEnforced), and a summary of conditions
        and grant controls. Requires Policy.Read.All scope.
    .PARAMETER ReportOnly
        If set, outputs results to the console instead of writing a file.
    .PARAMETER OutputPath
        Directory for the output CSV.
    .PARAMETER Owner
        Evidence owner identifier for the filename.
    #>
    [CmdletBinding()]
    param (
        [switch]$ReportOnly,
        [string]$OutputPath,
        [string]$Owner
    )

    Write-Host "`n[A.5.15] Collecting Conditional Access policies..." -ForegroundColor Magenta

    Assert-GraphConnected -Scopes @('Policy.Read.All')

    try {
        $policies = Get-MgIdentityConditionalAccessPolicy -All |
            Select-Object DisplayName, State,
                @{N='IncludeUsers';     E={ $_.Conditions.Users.IncludeUsers -join '; ' }},
                @{N='ExcludeUsers';     E={ $_.Conditions.Users.ExcludeUsers -join '; ' }},
                @{N='IncludeGroups';    E={ $_.Conditions.Users.IncludeGroups -join '; ' }},
                @{N='ClientAppTypes';   E={ $_.Conditions.ClientAppTypes -join '; ' }},
                @{N='GrantControls';    E={ $_.GrantControls.BuiltInControls -join '; ' }},
                @{N='SessionControls';  E={ $_.SessionControls.AdditionalProperties | ConvertTo-Json -Compress }},
                CreatedDateTime, ModifiedDateTime, Id

        $enabled          = ($policies | Where-Object { $_.State -eq 'enabled' }).Count
        $reportOnly_count = ($policies | Where-Object { $_.State -eq 'enabledForReportingButNotEnforced' }).Count
        $disabled         = ($policies | Where-Object { $_.State -eq 'disabled' }).Count

        Write-Host "[A.5.15] Policies: Enabled=$enabled | Report-Only=$reportOnly_count | Disabled=$disabled" -ForegroundColor White

        if ($ReportOnly) {
            $policies | Format-Table DisplayName, State, GrantControls -AutoSize
        } else {
            $fileName = Get-EvidenceFileName -ControlID 'A.5.15' -System 'EntraID' `
                            -EvidenceType 'CAPolicy-Export' -Extension 'csv' -Owner $Owner
            Write-EvidenceFile -Data $policies -FileName $fileName -OutputPath $OutputPath
        }
    } catch {
        Write-Warning "[A.5.15] Failed to collect Conditional Access policies: $_"
    }
}

function Get-AuditLogStatus {
    <#
    .SYNOPSIS
        Confirms whether the Unified Audit Log is enabled for the Microsoft 365 tenant. Maps to A.8.15 (Logging).
    .DESCRIPTION
        Connects to Exchange Online and retrieves the admin audit log configuration. Reports whether
        Unified Audit Log ingestion is enabled and the current mailbox audit disabled state.
        Requires Exchange Online connectivity.
    .PARAMETER ReportOnly
        If set, outputs results to the console instead of writing a file.
    .PARAMETER OutputPath
        Directory for the output CSV.
    .PARAMETER Owner
        Evidence owner identifier for the filename.
    #>
    [CmdletBinding()]
    param (
        [switch]$ReportOnly,
        [string]$OutputPath,
        [string]$Owner
    )

    Write-Host "`n[A.8.15] Collecting Unified Audit Log status..." -ForegroundColor Magenta

    Assert-ExchangeConnected

    try {
        $auditConfig = Get-AdminAuditLogConfig | Select-Object UnifiedAuditLogIngestionEnabled,
                            AdminAuditLogEnabled, AdminAuditLogCmdlets, AdminAuditLogParameters,
                            AdminAuditLogExcludedCmdlets

        $orgConfig = Get-OrganizationConfig | Select-Object AuditDisabled, Name

        $result = [PSCustomObject]@{
            TenantName                      = $orgConfig.Name
            UnifiedAuditLogIngestionEnabled = $auditConfig.UnifiedAuditLogIngestionEnabled
            MailboxAuditDisabled            = $orgConfig.AuditDisabled
            AdminAuditLogEnabled            = $auditConfig.AdminAuditLogEnabled
            CollectedAt                     = (Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
        }

        $ualStatus = if ($result.UnifiedAuditLogIngestionEnabled) { 'ENABLED' } else { 'DISABLED - ACTION REQUIRED' }
        Write-Host "[A.8.15] Unified Audit Log: $ualStatus" -ForegroundColor $(if ($result.UnifiedAuditLogIngestionEnabled) { 'Green' } else { 'Red' })

        if ($ReportOnly) {
            $result | Format-List
        } else {
            $fileName = Get-EvidenceFileName -ControlID 'A.8.15' -System 'M365-UAL' `
                            -EvidenceType 'AuditLogConfig' -Extension 'csv' -Owner $Owner
            Write-EvidenceFile -Data @($result) -FileName $fileName -OutputPath $OutputPath
        }
    } catch {
        Write-Warning "[A.8.15] Failed to collect audit log status: $_"
    }
}

function Get-PrivilegedRoles {
    <#
    .SYNOPSIS
        Exports all Entra ID privileged role assignments (active and eligible via PIM). Maps to A.5.16 (Identity Management).
    .DESCRIPTION
        Retrieves all active and PIM-eligible role assignments from Microsoft Entra ID.
        Returns the principal display name, UPN, role name, assignment type, and scope.
        Requires RoleManagement.Read.Directory and Directory.Read.All scopes.
    .PARAMETER ReportOnly
        If set, outputs results to the console instead of writing a file.
    .PARAMETER OutputPath
        Directory for the output CSV.
    .PARAMETER Owner
        Evidence owner identifier for the filename.
    #>
    [CmdletBinding()]
    param (
        [switch]$ReportOnly,
        [string]$OutputPath,
        [string]$Owner
    )

    Write-Host "`n[A.5.16] Collecting privileged role assignments..." -ForegroundColor Magenta

    Assert-GraphConnected -Scopes @('RoleManagement.Read.Directory', 'Directory.Read.All')

    try {
        # Active (permanent) role assignments
        $activeAssignments = Get-MgRoleManagementDirectoryRoleAssignment -All -ExpandProperty Principal |
            Select-Object @{N='AssignmentType'; E={'Active'}},
                          @{N='PrincipalDisplayName'; E={ $_.Principal.AdditionalProperties['displayName'] }},
                          @{N='PrincipalUPN';          E={ $_.Principal.AdditionalProperties['userPrincipalName'] }},
                          RoleDefinitionId, DirectoryScopeId, Id

        $results = $activeAssignments

        # PIM eligible assignments (requires additional scope — skip gracefully if unavailable)
        try {
            $eligibleAssignments = Get-MgRoleManagementDirectoryRoleEligibilitySchedule -All -ExpandProperty Principal |
                Select-Object @{N='AssignmentType'; E={'Eligible-PIM'}},
                              @{N='PrincipalDisplayName'; E={ $_.Principal.AdditionalProperties['displayName'] }},
                              @{N='PrincipalUPN';          E={ $_.Principal.AdditionalProperties['userPrincipalName'] }},
                              RoleDefinitionId, DirectoryScopeId, Id
            $results = $results + $eligibleAssignments
        } catch {
            Write-Warning "[A.5.16] PIM eligible assignments not available (may require additional licence or scope): $_"
        }

        Write-Host "[A.5.16] Total role assignments found: $($results.Count)" -ForegroundColor White

        if ($ReportOnly) {
            $results | Format-Table AssignmentType, PrincipalDisplayName, PrincipalUPN, RoleDefinitionId -AutoSize
        } else {
            $fileName = Get-EvidenceFileName -ControlID 'A.5.16' -System 'EntraID' `
                            -EvidenceType 'PrivilegedRoles' -Extension 'csv' -Owner $Owner
            Write-EvidenceFile -Data $results -FileName $fileName -OutputPath $OutputPath
        }
    } catch {
        Write-Warning "[A.5.16] Failed to collect privileged role assignments: $_"
    }
}

function Get-AntiMalwareConfig {
    <#
    .SYNOPSIS
        Exports Defender for Endpoint and Exchange Online anti-malware policy configuration. Maps to A.8.7 (Protection Against Malware).
    .DESCRIPTION
        Retrieves anti-malware policies from Exchange Online Protection and Intune device configuration
        profiles matching Defender-related names. Provides a summary of policy scope and action settings.
        Requires DeviceManagementConfiguration.Read.All and Exchange Online connectivity.
    .PARAMETER ReportOnly
        If set, outputs results to the console instead of writing a file.
    .PARAMETER OutputPath
        Directory for the output CSV.
    .PARAMETER Owner
        Evidence owner identifier for the filename.
    #>
    [CmdletBinding()]
    param (
        [switch]$ReportOnly,
        [string]$OutputPath,
        [string]$Owner
    )

    Write-Host "`n[A.8.7] Collecting anti-malware configuration..." -ForegroundColor Magenta

    # Exchange Online anti-malware policies
    Assert-ExchangeConnected

    try {
        $malwarePolicies = Get-MalwareFilterPolicy | Select-Object Name, Action, EnableFileFilter,
                               FileTypes, EnableInternalSenderAdminNotifications,
                               InternalSenderAdminAddress, ZapEnabled,
                               @{N='CollectedAt'; E={ Get-Date -Format 'yyyy-MM-dd HH:mm:ss' }}

        Write-Host "[A.8.7] EOP malware filter policies found: $($malwarePolicies.Count)" -ForegroundColor White

        # Intune Defender configuration profiles (if Graph is available)
        $intuneProfiles = $null
        try {
            Assert-GraphConnected -Scopes @('DeviceManagementConfiguration.Read.All')
            $intuneProfiles = Get-MgDeviceManagementDeviceConfiguration -All |
                Where-Object { $_.DisplayName -match 'Defender|Antivirus|Malware|AV' } |
                Select-Object DisplayName, Id,
                    @{N='OdataType';   E={ $_.AdditionalProperties['@odata.type'] }},
                    @{N='CollectedAt'; E={ Get-Date -Format 'yyyy-MM-dd HH:mm:ss' }}
            Write-Host "[A.8.7] Intune Defender-related profiles found: $($intuneProfiles.Count)" -ForegroundColor White
        } catch {
            Write-Warning "[A.8.7] Could not retrieve Intune profiles (check DeviceManagement scope): $_"
        }

        if ($ReportOnly) {
            Write-Host "`nEOP Anti-Malware Policies:" -ForegroundColor Yellow
            $malwarePolicies | Format-Table -AutoSize
            if ($intuneProfiles) {
                Write-Host "`nIntune Defender Profiles:" -ForegroundColor Yellow
                $intuneProfiles | Format-Table -AutoSize
            }
        } else {
            $fileName = Get-EvidenceFileName -ControlID 'A.8.7' -System 'M365-EOP' `
                            -EvidenceType 'AntiMalwarePolicy' -Extension 'csv' -Owner $Owner
            Write-EvidenceFile -Data $malwarePolicies -FileName $fileName -OutputPath $OutputPath

            if ($intuneProfiles) {
                $intuneFileName = Get-EvidenceFileName -ControlID 'A.8.7' -System 'Intune' `
                                    -EvidenceType 'DefenderProfiles' -Extension 'csv' -Owner $Owner
                Write-EvidenceFile -Data $intuneProfiles -FileName $intuneFileName -OutputPath $OutputPath
            }
        }
    } catch {
        Write-Warning "[A.8.7] Failed to collect anti-malware configuration: $_"
    }
}

function Get-AccessReviewStatus {
    <#
    .SYNOPSIS
        READ-ONLY. Exports Entra ID access review definitions and their status. Maps to A.5.18 (Access Rights).
    .DESCRIPTION
        Queries Microsoft Graph identityGovernance/accessReviews/definitions and returns each
        access review series with its status, scope, and recurrence so the operator can evidence
        that periodic access reviews are defined and running. Requires the AccessReview.Read.All
        scope and an Entra ID P2 (or Entra ID Governance) licence. This function only issues
        Graph GET requests and never changes tenant configuration.
    .PARAMETER ReportOnly
        If set, outputs results to the console instead of writing a file.
    .PARAMETER OutputPath
        Directory for the output CSV.
    .PARAMETER Owner
        Evidence owner identifier for the filename.
    #>
    [CmdletBinding()]
    param (
        [switch]$ReportOnly,
        [string]$OutputPath,
        [string]$Owner
    )

    Write-Host "`n[A.5.18] Collecting access review definitions (read-only)..." -ForegroundColor Magenta

    Assert-GraphConnected -Scopes @('AccessReview.Read.All')

    try {
        $reviews = Get-MgIdentityGovernanceAccessReviewDefinition -All |
            Select-Object DisplayName, Status, CreatedDateTime, LastModifiedDateTime, Id,
                @{N='Recurrence';   E={ $_.Settings.Recurrence.Pattern.Type }},
                @{N='ScopeQuery';   E={ $_.Scope.AdditionalProperties['query'] }},
                @{N='CollectedAt';  E={ Get-Date -Format 'yyyy-MM-dd HH:mm:ss' }}

        $total = ($reviews | Measure-Object).Count
        Write-Host "[A.5.18] Access review definitions found: $total" -ForegroundColor White
        if ($total -eq 0) {
            Write-Warning "[A.5.18] No access review definitions exist. Access reviews may not be configured, which is an audit gap for A.5.18."
        }

        if ($ReportOnly) {
            $reviews | Format-Table DisplayName, Status, Recurrence, LastModifiedDateTime -AutoSize
        } else {
            $fileName = Get-EvidenceFileName -ControlID 'A.5.18' -System 'EntraID' `
                            -EvidenceType 'AccessReviewDefinitions' -Extension 'csv' -Owner $Owner
            Write-EvidenceFile -Data $reviews -FileName $fileName -OutputPath $OutputPath
        }
    } catch {
        Write-Warning "[A.5.18] Failed to collect access review definitions: $_"
    }
}

function Get-DeviceComplianceStatus {
    <#
    .SYNOPSIS
        READ-ONLY. Exports Intune managed device compliance state. Maps to A.8.1 (User Endpoint Devices).
    .DESCRIPTION
        Queries Microsoft Graph deviceManagement/managedDevices and returns per-device compliance
        state, encryption status, operating system version, and last sync time so the operator can
        evidence that the endpoint baseline is monitored. Requires the
        DeviceManagementManagedDevices.Read.All scope. This function only issues Graph GET
        requests and never changes device or tenant configuration.
    .PARAMETER ReportOnly
        If set, outputs results to the console instead of writing a file.
    .PARAMETER OutputPath
        Directory for the output CSV.
    .PARAMETER Owner
        Evidence owner identifier for the filename.
    #>
    [CmdletBinding()]
    param (
        [switch]$ReportOnly,
        [string]$OutputPath,
        [string]$Owner
    )

    Write-Host "`n[A.8.1] Collecting managed device compliance status (read-only)..." -ForegroundColor Magenta

    Assert-GraphConnected -Scopes @('DeviceManagementManagedDevices.Read.All')

    try {
        $devices = Get-MgDeviceManagementManagedDevice -All |
            Select-Object DeviceName, UserPrincipalName, OperatingSystem, OSVersion,
                          ComplianceState, IsEncrypted, ManagedDeviceOwnerType,
                          EnrolledDateTime, LastSyncDateTime,
                @{N='CollectedAt'; E={ Get-Date -Format 'yyyy-MM-dd HH:mm:ss' }}

        $total        = ($devices | Measure-Object).Count
        $compliant    = ($devices | Where-Object { $_.ComplianceState -eq 'compliant' }).Count
        $notEncrypted = ($devices | Where-Object { -not $_.IsEncrypted }).Count

        Write-Host "[A.8.1] Devices: $total | Compliant: $compliant | Not encrypted: $notEncrypted" -ForegroundColor White

        if ($ReportOnly) {
            $devices | Format-Table DeviceName, OperatingSystem, ComplianceState, IsEncrypted, LastSyncDateTime -AutoSize
        } else {
            $fileName = Get-EvidenceFileName -ControlID 'A.8.1' -System 'Intune' `
                            -EvidenceType 'DeviceCompliance' -Extension 'csv' -Owner $Owner
            Write-EvidenceFile -Data $devices -FileName $fileName -OutputPath $OutputPath
        }
    } catch {
        Write-Warning "[A.8.1] Failed to collect device compliance status: $_"
    }
}

function Get-DlpPolicyConfig {
    <#
    .SYNOPSIS
        READ-ONLY. Exports Microsoft Purview DLP policy configuration. Maps to A.8.12 (Data Leakage Prevention).
    .DESCRIPTION
        Uses the read-only Get-DlpCompliancePolicy cmdlet from Security and Compliance PowerShell
        to return each DLP policy with its mode and workload locations so the operator can
        evidence that DLP policies exist and are enforced (not in test mode). Requires
        Connect-IPPSSession access with a compliance reader role or above. This function only
        calls read-only Get-* cmdlets and never changes policy configuration.
    .PARAMETER ReportOnly
        If set, outputs results to the console instead of writing a file.
    .PARAMETER OutputPath
        Directory for the output CSV.
    .PARAMETER Owner
        Evidence owner identifier for the filename.
    #>
    [CmdletBinding()]
    param (
        [switch]$ReportOnly,
        [string]$OutputPath,
        [string]$Owner
    )

    Write-Host "`n[A.8.12] Collecting Purview DLP policy configuration (read-only)..." -ForegroundColor Magenta

    Assert-ComplianceConnected

    try {
        $dlpPolicies = Get-DlpCompliancePolicy |
            Select-Object Name, Mode, Enabled, Priority, WhenChanged,
                @{N='ExchangeLocation';   E={ ($_.ExchangeLocation   | ForEach-Object { "$_" }) -join '; ' }},
                @{N='SharePointLocation'; E={ ($_.SharePointLocation | ForEach-Object { "$_" }) -join '; ' }},
                @{N='OneDriveLocation';   E={ ($_.OneDriveLocation   | ForEach-Object { "$_" }) -join '; ' }},
                @{N='TeamsLocation';      E={ ($_.TeamsLocation      | ForEach-Object { "$_" }) -join '; ' }},
                @{N='CollectedAt';        E={ Get-Date -Format 'yyyy-MM-dd HH:mm:ss' }}

        $total    = ($dlpPolicies | Measure-Object).Count
        $testMode = ($dlpPolicies | Where-Object { $_.Mode -like 'Test*' }).Count
        Write-Host "[A.8.12] DLP policies: $total | In test mode: $testMode" -ForegroundColor White
        if ($testMode -gt 0) {
            Write-Warning "[A.8.12] $testMode DLP policies are in test mode and are not enforcing. Auditors treat this as a gap for in-scope data."
        }

        if ($ReportOnly) {
            $dlpPolicies | Format-Table Name, Mode, Enabled, WhenChanged -AutoSize
        } else {
            $fileName = Get-EvidenceFileName -ControlID 'A.8.12' -System 'Purview' `
                            -EvidenceType 'DLPPolicy-Export' -Extension 'csv' -Owner $Owner
            Write-EvidenceFile -Data $dlpPolicies -FileName $fileName -OutputPath $OutputPath
        }
    } catch {
        Write-Warning "[A.8.12] Failed to collect DLP policy configuration: $_"
    }
}

function Get-RiskDetections {
    <#
    .SYNOPSIS
        READ-ONLY. Exports recent Entra ID Identity Protection risk detections. Maps to A.8.16 (Monitoring Activities).
    .DESCRIPTION
        Queries Microsoft Graph identityProtection/riskDetections and returns a sample of recent
        risk detections with type, level, state, and detection time so the operator can evidence
        that anomalous activity is detected and triaged. Requires the IdentityRiskEvent.Read.All
        scope and an Entra ID P2 licence. This function only issues Graph GET requests and never
        changes tenant configuration.
    .PARAMETER ReportOnly
        If set, outputs results to the console instead of writing a file.
    .PARAMETER OutputPath
        Directory for the output CSV.
    .PARAMETER Owner
        Evidence owner identifier for the filename.
    .PARAMETER Limit
        Maximum number of risk detections to return. Defaults to 500.
    #>
    [CmdletBinding()]
    param (
        [switch]$ReportOnly,
        [string]$OutputPath,
        [string]$Owner,
        [int]$Limit = 500
    )

    Write-Host "`n[A.8.16] Collecting Identity Protection risk detections (read-only)..." -ForegroundColor Magenta

    Assert-GraphConnected -Scopes @('IdentityRiskEvent.Read.All')

    try {
        $detections = Get-MgRiskDetection -Top $Limit |
            Select-Object DetectedDateTime, RiskEventType, RiskLevel, RiskState, RiskDetail,
                          UserPrincipalName, Activity, Source,
                @{N='CollectedAt'; E={ Get-Date -Format 'yyyy-MM-dd HH:mm:ss' }}

        $total     = ($detections | Measure-Object).Count
        $openHigh  = ($detections | Where-Object { $_.RiskLevel -eq 'high' -and $_.RiskState -eq 'atRisk' }).Count
        Write-Host "[A.8.16] Risk detections sampled: $total | Open high-risk: $openHigh" -ForegroundColor White

        if ($ReportOnly) {
            $detections | Format-Table DetectedDateTime, RiskEventType, RiskLevel, RiskState, UserPrincipalName -AutoSize
        } else {
            $fileName = Get-EvidenceFileName -ControlID 'A.8.16' -System 'EntraID' `
                            -EvidenceType 'RiskDetections' -Extension 'csv' -Owner $Owner
            Write-EvidenceFile -Data $detections -FileName $fileName -OutputPath $OutputPath
        }
    } catch {
        Write-Warning "[A.8.16] Failed to collect risk detections: $_"
    }
}

#endregion Evidence Functions

#region Main Execution

if (-not (Test-Path -Path $OutputPath -PathType Container)) {
    Write-Host "[INIT] Creating output directory: $OutputPath" -ForegroundColor Yellow
    New-Item -Path $OutputPath -ItemType Directory -Force | Out-Null
}

$commonParams = @{
    ReportOnly = $ReportOnly
    OutputPath = $OutputPath
    Owner      = $Owner
}

# Functions added in v1.1.0 default to report-only: they write files only when the operator
# supplies -OutputPath explicitly. Existing functions keep their original behaviour.
$newFunctionReportOnly = $ReportOnly -or (-not $PSBoundParameters.ContainsKey('OutputPath'))
$newFunctionParams = @{
    ReportOnly = $newFunctionReportOnly
    OutputPath = $OutputPath
    Owner      = $Owner
}
if ($newFunctionReportOnly -and -not $ReportOnly) {
    Write-Host "[SAFE-DEFAULT] A.5.18 / A.8.1 / A.8.12 / A.8.16 run in report-only mode unless -OutputPath is supplied explicitly." -ForegroundColor Yellow
}

Write-Host "==================================================" -ForegroundColor DarkCyan
Write-Host " ISO 27001:2022 Evidence Collection Script" -ForegroundColor Cyan
Write-Host " Date    : $(Get-Date -Format 'yyyy-MM-dd HH:mm')" -ForegroundColor Cyan
Write-Host " Mode    : $(if ($ReportOnly) { 'Report Only (no files written)' } else { "File Output -> $OutputPath" })" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor DarkCyan

if ($PSCmdlet.ParameterSetName -eq 'All') {
    Get-MFAStatus              @commonParams
    Get-ConditionalAccess      @commonParams
    Get-AuditLogStatus         @commonParams
    Get-PrivilegedRoles        @commonParams
    Get-AntiMalwareConfig      @commonParams
    Get-AccessReviewStatus     @newFunctionParams
    Get-DeviceComplianceStatus @newFunctionParams
    Get-DlpPolicyConfig        @newFunctionParams
    Get-RiskDetections         @newFunctionParams
} else {
    switch ($ControlID) {
        'A.8.5'  { Get-MFAStatus              @commonParams }
        'A.5.15' { Get-ConditionalAccess      @commonParams }
        'A.8.15' { Get-AuditLogStatus         @commonParams }
        'A.5.16' { Get-PrivilegedRoles        @commonParams }
        'A.8.7'  { Get-AntiMalwareConfig      @commonParams }
        'A.5.18' { Get-AccessReviewStatus     @newFunctionParams }
        'A.8.1'  { Get-DeviceComplianceStatus @newFunctionParams }
        'A.8.12' { Get-DlpPolicyConfig        @newFunctionParams }
        'A.8.16' { Get-RiskDetections         @newFunctionParams }
    }
}

Write-Host "`n[DONE] Evidence collection complete." -ForegroundColor Green

#endregion Main Execution
