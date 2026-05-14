<#
.SYNOPSIS
    Export read-only Microsoft 365 and Entra evidence mapped to ISO 27001:2022 Annex A controls.

.DESCRIPTION
    Collects audit-ready evidence using Microsoft Graph PowerShell and writes JSON/CSV exports plus an evidence index. The script does not change tenant configuration.

.REQUIRED GRAPH PERMISSIONS
    AuditLog.Read.All, Directory.Read.All, Policy.Read.All, Reports.Read.All, RoleManagement.Read.Directory

.EXAMPLE
    ./Export-M365Iso27001Evidence.ps1 -TenantId "contoso.onmicrosoft.com" -OutputRoot ./evidence
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$TenantId,

    [Parameter(Mandatory = $false)]
    [string]$OutputRoot = "./evidence/m365",

    [Parameter(Mandatory = $false)]
    [switch]$SkipConnect,

    [Parameter(Mandatory = $false)]
    [int]$RecentSignInLimit = 1000,

    [Parameter(Mandatory = $false)]
    [int]$RecentAuditLimit = 1000
)

$ErrorActionPreference = "Stop"

$RequiredScopes = @(
    "AuditLog.Read.All",
    "Directory.Read.All",
    "Policy.Read.All",
    "Reports.Read.All",
    "RoleManagement.Read.Directory"
)

function Assert-GraphModule {
    if (-not (Get-Module -ListAvailable -Name Microsoft.Graph.Authentication)) {
        throw "Microsoft.Graph is required. Install it with: Install-Module Microsoft.Graph -Scope CurrentUser"
    }
    Import-Module Microsoft.Graph.Authentication -ErrorAction Stop
}

function Connect-GraphReadOnly {
    param([string]$Tenant)

    if ($SkipConnect) {
        Write-Verbose "Skipping Connect-MgGraph because -SkipConnect was provided."
        return
    }

    if ([string]::IsNullOrWhiteSpace($Tenant)) {
        Connect-MgGraph -Scopes $RequiredScopes -NoWelcome
    }
    else {
        Connect-MgGraph -TenantId $Tenant -Scopes $RequiredScopes -NoWelcome
    }
}

function New-EvidenceFolder {
    param([string]$Root)

    $dateStamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHHmmssZ")
    $path = Join-Path -Path $Root -ChildPath $dateStamp
    New-Item -ItemType Directory -Path $path -Force | Out-Null
    return (Resolve-Path $path).Path
}

function Invoke-GraphPagedRequest {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Uri,

        [Parameter(Mandatory = $false)]
        [int]$Limit = 0
    )

    $items = New-Object System.Collections.Generic.List[object]
    $nextUri = $Uri

    while ($nextUri) {
        $response = Invoke-MgGraphRequest -Method GET -Uri $nextUri -OutputType PSObject
        if ($null -ne $response.value) {
            foreach ($item in $response.value) {
                $items.Add($item)
                if ($Limit -gt 0 -and $items.Count -ge $Limit) {
                    return $items.ToArray()
                }
            }
        }
        elseif ($null -ne $response) {
            $items.Add($response)
            return $items.ToArray()
        }

        $next = $response.'@odata.nextLink'
        if ([string]::IsNullOrWhiteSpace($next)) {
            $nextUri = $null
        }
        else {
            $nextUri = $next
        }
    }

    return $items.ToArray()
}

function Save-JsonEvidence {
    param([object]$Data, [string]$Path)
    $Data | ConvertTo-Json -Depth 30 | Out-File -FilePath $Path -Encoding utf8
}

function Save-CsvEvidence {
    param([object[]]$Data, [string]$Path)
    if ($Data.Count -eq 0) {
        @() | Export-Csv -Path $Path -NoTypeInformation -Encoding utf8
        return
    }
    $Data | Export-Csv -Path $Path -NoTypeInformation -Encoding utf8
}

function Add-EvidenceIndexRow {
    param(
        [System.Collections.Generic.List[object]]$Index,
        [string]$ControlId,
        [string]$EvidenceName,
        [string]$FileName,
        [string]$Source,
        [string]$Description
    )

    $Index.Add([pscustomobject]@{
        ControlId = $ControlId
        EvidenceName = $EvidenceName
        FileName = $FileName
        Source = $Source
        CollectionDateUtc = (Get-Date).ToUniversalTime().ToString("o")
        Description = $Description
    })
}

Assert-GraphModule
Connect-GraphReadOnly -Tenant $TenantId

$outputPath = New-EvidenceFolder -Root $OutputRoot
$evidenceIndex = New-Object System.Collections.Generic.List[object]

Write-Host "Exporting Microsoft 365 ISO 27001 evidence to: $outputPath"

# A.8.5 Secure authentication - MFA registration status.
$mfaRegistration = Invoke-GraphPagedRequest -Uri "/v1.0/reports/authenticationMethods/userRegistrationDetails"
Save-JsonEvidence -Data $mfaRegistration -Path (Join-Path $outputPath "A.8.5_MFARegistrationDetails.json")
$mfaFlat = foreach ($user in $mfaRegistration) {
    [pscustomobject]@{
        UserPrincipalName = $user.userPrincipalName
        UserDisplayName = $user.userDisplayName
        IsMfaRegistered = $user.isMfaRegistered
        IsMfaCapable = $user.isMfaCapable
        IsPasswordlessCapable = $user.isPasswordlessCapable
        DefaultMfaMethod = $user.defaultMfaMethod
        MethodsRegistered = (($user.methodsRegistered | ForEach-Object { $_ }) -join ";")
        IsAdmin = $user.isAdmin
    }
}
Save-CsvEvidence -Data @($mfaFlat) -Path (Join-Path $outputPath "A.8.5_MFARegistrationDetails.csv")
Add-EvidenceIndexRow -Index $evidenceIndex -ControlId "A.8.5" -EvidenceName "MFA registration details" -FileName "A.8.5_MFARegistrationDetails.csv" -Source "Microsoft Graph reports/authenticationMethods/userRegistrationDetails" -Description "Shows MFA capability and registration posture for users."

# A.8.5 and A.5.15 - Conditional Access policies.
$caPolicies = Invoke-GraphPagedRequest -Uri "/v1.0/identity/conditionalAccess/policies"
Save-JsonEvidence -Data $caPolicies -Path (Join-Path $outputPath "A.8.5_ConditionalAccessPolicies.json")
Add-EvidenceIndexRow -Index $evidenceIndex -ControlId "A.8.5" -EvidenceName "Conditional Access policies" -FileName "A.8.5_ConditionalAccessPolicies.json" -Source "Microsoft Graph identity/conditionalAccess/policies" -Description "Exports Conditional Access policy configuration for authentication evidence."
Add-EvidenceIndexRow -Index $evidenceIndex -ControlId "A.5.15" -EvidenceName "Conditional Access policies" -FileName "A.8.5_ConditionalAccessPolicies.json" -Source "Microsoft Graph identity/conditionalAccess/policies" -Description "Supports access control evidence for policy-based access restrictions."

# A.8.2 Privileged access rights - directory role assignments.
$roleAssignments = Invoke-GraphPagedRequest -Uri "/v1.0/roleManagement/directory/roleAssignments?`$expand=principal,roleDefinition"
Save-JsonEvidence -Data $roleAssignments -Path (Join-Path $outputPath "A.8.2_PrivilegedRoleAssignments.json")
$roleFlat = foreach ($assignment in $roleAssignments) {
    [pscustomobject]@{
        AssignmentId = $assignment.id
        PrincipalId = $assignment.principalId
        PrincipalName = $assignment.principal.displayName
        RoleDefinitionId = $assignment.roleDefinitionId
        RoleDisplayName = $assignment.roleDefinition.displayName
        DirectoryScopeId = $assignment.directoryScopeId
        AppScopeId = $assignment.appScopeId
    }
}
Save-CsvEvidence -Data @($roleFlat) -Path (Join-Path $outputPath "A.8.2_PrivilegedRoleAssignments.csv")
Add-EvidenceIndexRow -Index $evidenceIndex -ControlId "A.8.2" -EvidenceName "Privileged role assignments" -FileName "A.8.2_PrivilegedRoleAssignments.csv" -Source "Microsoft Graph roleManagement/directory/roleAssignments" -Description "Shows directory role assignments for privileged access review."

# A.8.15 and A.8.16 - recent sign-ins and directory audit events.
$signIns = Invoke-GraphPagedRequest -Uri "/v1.0/auditLogs/signIns?`$top=100" -Limit $RecentSignInLimit
Save-JsonEvidence -Data $signIns -Path (Join-Path $outputPath "A.8.15_RecentSignIns.json")
$signInFlat = foreach ($signIn in $signIns) {
    [pscustomobject]@{
        CreatedDateTime = $signIn.createdDateTime
        UserPrincipalName = $signIn.userPrincipalName
        AppDisplayName = $signIn.appDisplayName
        ClientAppUsed = $signIn.clientAppUsed
        IpAddress = $signIn.ipAddress
        ConditionalAccess = $signIn.conditionalAccessStatus
        RiskDetail = $signIn.riskDetail
        StatusErrorCode = $signIn.status.errorCode
        StatusFailureReason = $signIn.status.failureReason
    }
}
Save-CsvEvidence -Data @($signInFlat) -Path (Join-Path $outputPath "A.8.15_RecentSignIns.csv")
Add-EvidenceIndexRow -Index $evidenceIndex -ControlId "A.8.15" -EvidenceName "Recent sign-ins" -FileName "A.8.15_RecentSignIns.csv" -Source "Microsoft Graph auditLogs/signIns" -Description "Recent sign-in event sample for logging evidence."
Add-EvidenceIndexRow -Index $evidenceIndex -ControlId "A.8.16" -EvidenceName "Recent sign-ins" -FileName "A.8.15_RecentSignIns.csv" -Source "Microsoft Graph auditLogs/signIns" -Description "Recent sign-in event sample for monitoring and triage evidence."

$directoryAudits = Invoke-GraphPagedRequest -Uri "/v1.0/auditLogs/directoryAudits?`$top=100" -Limit $RecentAuditLimit
Save-JsonEvidence -Data $directoryAudits -Path (Join-Path $outputPath "A.8.15_DirectoryAuditEvents.json")
Add-EvidenceIndexRow -Index $evidenceIndex -ControlId "A.8.15" -EvidenceName "Directory audit events" -FileName "A.8.15_DirectoryAuditEvents.json" -Source "Microsoft Graph auditLogs/directoryAudits" -Description "Recent directory audit event sample for logging evidence."
Add-EvidenceIndexRow -Index $evidenceIndex -ControlId "A.8.16" -EvidenceName "Directory audit events" -FileName "A.8.15_DirectoryAuditEvents.json" -Source "Microsoft Graph auditLogs/directoryAudits" -Description "Recent directory audit event sample for monitoring evidence."

$metadata = [pscustomobject]@{
    TenantIdSupplied = $TenantId
    OutputPath = $outputPath
    CollectionDateUtc = (Get-Date).ToUniversalTime().ToString("o")
    ScriptName = "Export-M365Iso27001Evidence.ps1"
    ScriptMode = "ReadOnly"
    RequiredScopes = $RequiredScopes
    EvidenceClassification = "Contains tenant configuration and user/security metadata. Store securely and redact before sharing externally."
}

Save-JsonEvidence -Data $metadata -Path (Join-Path $outputPath "collection-metadata.json")
Save-CsvEvidence -Data @($evidenceIndex.ToArray()) -Path (Join-Path $outputPath "M365_Evidence_Index.csv")
Save-JsonEvidence -Data $evidenceIndex.ToArray() -Path (Join-Path $outputPath "M365_Evidence_Index.json")

Write-Host "Evidence export complete."
Write-Host "Evidence index: $(Join-Path $outputPath 'M365_Evidence_Index.csv')"
