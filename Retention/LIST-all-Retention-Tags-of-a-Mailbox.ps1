
# LIST all Retention Tags of a Mailbox
$user = "test@user.com"
foreach ($tag in ((Get-RetentionPolicy (get-mailbox $user).RetentionPolicy).RetentionPolicyTagLinks)) {
Get-RetentionPolicyTag $tag | select name,Type,RetentionEnabled,AgelimitforRetention
}

# List ALL Tags
Get-RetentionPolicyTag | select name,Type,RetentionEnabled,AgelimitforRetention
Get-RetentionPolicyTag "Recoverable Items 14 days move to archive" | fl name,Type,RetentionEnabled,AgelimitforRetention
Get-RetentionPolicyTag "Junk Email" | fl name,Type,RetentionEnabled,AgelimitforRetention
Get-RetentionPolicyTag "Deleted Items" | fl name,Type,RetentionEnabled,AgelimitforRetention
Get-RetentionPolicyTag "Default 2 year move to archive" | fl name,Type,RetentionEnabled,AgelimitforRetention

# GET Default Policy
Get-RetentionPolicy | where {$_.IsDefault -eq "True" } | fl name,Id,Guid,RetentionPolicyTagLinks

# GET PolicyTags for Default Policy
(Get-RetentionPolicy | where {$_.IsDefault -eq "True" }).RetentionPolicyTagLinks | % { Get-RetentionPolicyTag $_ | select name,Type,RetentionEnabled,AgelimitforRetention }

# read Variables from existing Tags
$default = Get-RetentionPolicy | where {$_.IsDefault -eq "True" }
$Personal = Get-RetentionPolicyTag | where {$_.Type -match "Personal" }
$all = Get-RetentionPolicyTag | where {$_.Type -match "All" }
$Junk = Get-RetentionPolicyTag | where {$_.Type -match "JunkEmail" }
$Deleted = Get-RetentionPolicyTag | where {$_.Type -match "DeletedItems" }
$Recoverable = Get-RetentionPolicyTag | where {$_.Type -match "RecoverableItems" }
$all | fl
# View list
$NewTags = $Personal.Id + $all.Id + $Junk.Id + $Deleted.Id + $Recoverable.Id

#doublecheck list
foreach ($tag in $NewTags) { Get-RetentionPolicyTag $tag | select name,Type,RetentionEnabled,AgelimitforRetention }

# Set Default Policy Values 
Set-RetentionPolicy $default.id -RetentionPolicyTagLinks $NewTags

# check results
(Get-RetentionPolicy | where {$_.IsDefault -eq "True" }).RetentionPolicyTagLinks | % { Get-RetentionPolicyTag $_ | select name,Type,RetentionEnabled,AgelimitforRetention }

#view policy for a mailbox
$user = "test@user.com"
$userpolicy = (get-mailbox $user).RetentionPolicy ; $userpolicy

# ASSIGN policy to mailbox
$default = Get-RetentionPolicy | where {$_.IsDefault -eq "True" }
Set-Mailbox $user -RetentionPolicy $default.Id
Get-Mailbox $user | FL name,RetentionPolicy

# LIST all Retention Tags of a Mailbox
$user = "test@user.com"
foreach ($tag in ((Get-RetentionPolicy (get-mailbox $user).RetentionPolicy).RetentionPolicyTagLinks)) {
Get-RetentionPolicyTag $tag | select name,Type,RetentionEnabled,AgelimitforRetention
}


# Change Timeframe for default tags

$all = Get-RetentionPolicyTag | where {$_.Type -match "All" } 
$all | Set-RetentionPolicytag -AgeLimitForRetention "365" -RetentionAction "MoveToArchive"

$Junk = Get-RetentionPolicyTag | where {$_.Type -match "JunkEmail" } 
$Junk | Set-RetentionPolicytag -AgeLimitForRetention "30" -RetentionAction "DeleteAndAllowRecovery" # PermanentlyDelete

$Deleted = Get-RetentionPolicyTag | where {$_.Type -match "DeletedItems" }
$Deleted | Set-RetentionPolicytag -AgeLimitForRetention "30" -RetentionAction "DeleteAndAllowRecovery"

$Recoverable = Get-RetentionPolicyTag | where {$_.Type -match "RecoverableItems" }
$Recoverable | Set-RetentionPolicytag -AgeLimitForRetention "30" -RetentionAction "MoveToArchive"

# GET PolicyTags for Default Policy
(Get-RetentionPolicy | where {$_.IsDefault -eq "True" }).RetentionPolicyTagLinks | % { Get-RetentionPolicyTag $_ | select name,Type,RetentionEnabled,AgelimitforRetention }

$user = "test@user.com"
Start-ManagedFolderAssistant -Identity $user 

