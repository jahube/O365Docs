# Folder permissions in OWA
#-------------------------

$access = 'Reviewer'

$MBX = "mailbox@to.share" # please modify

$user = "user@gets.access" # please modify
$MBX = "adelev@edu.dnsabr.com" # please modify

$user = "admin@edu.dnsabr.com" # please modify

$inbox = "\inbox"


Add-MailboxFolderPermission -identity $MBX -User $user -Accessrights Reviewer


Add-MailboxFolderPermission -identity "$MBX":"$inbox" -User $user -Accessrights Reviewer


Add-MailboxFolderPermission -identity $MBX:\customfolder -User $user -Accessrights Reviewer


$SRC = Get-MailboxFolderStatistics $MBX
$Fld = $Srch | ? { $_.foldertype -ne "ConversationActions" -and $_.foldertype -notlike "Recoverable*" -and $_.FolderPath -notlike "/Sync*" -and $_.FolderPath -ne "/Top of Information Store" -and $_.FolderPath -ne "/Calendar Logging" }

foreach($F in $Fld){$FN = :” + $item.FolderPath.Replace(“/”,”\”);
Try { Add-MailboxFolderPermission $fname -User <ReadUser> -AccessRights Reviewer}
}
$Srch.foldertype
$Srch.FolderPath
$Srch.Name
$Fld.Name
$SRC | ? { $_.ContainerClass -eq "IPF.Note"} -or $_.ContainerClass -eq "IPF.Contact" -or $_.ContainerClass -eq "IPF.Appointment"} 
$SRC.FolderPath

$RS1 = $Srch | where {$_.foldertype.tostring() -in ("Inbox","Outbox","SentItems","Drafts","JunkEmail","Archive","Contacts","Calendar","Notes","QuickContacts","RecipientCache","User Created")}



$types = "Inbox","Outbox","SentItems","Drafts","JunkEmail","Archive","Contacts","Calendar","Notes","QuickContacts","RecipientCache","User Created"

$SRC = Get-MailboxFolderStatistics $MBX

$FLD = $SRC | ? {$_.foldertype.tostring() -in ($types)}

# $FLD = $SRC | ? { $_.foldertype -ne "ConversationActions" -and $_.foldertype -notlike "Recoverable*" -and $_.FolderPath -notlike "/Sync*" -and $_.FolderPath -ne "/Top of Information Store" -and $_.FolderPath -ne "/Calendar Logging" }

foreach($F in $FLD){$FN = $F + ':' + $item.FolderPath.Replace('/','\');

Try { Add-MailboxFolderPermission $FN -User $user -AccessRights $access -EA stop } catch { write-host "$($Error.Exception.message)" -F yellow }

}


$RS1.FolderPath

$RS2.count
$Srch.count
$Srch.FolderPath
$Srch.Name
$rs1[13].Name