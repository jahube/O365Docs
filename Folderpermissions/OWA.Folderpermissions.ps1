# Folder permissions in OWA
#-------------------------

$access = 'Reviewer'

$MBX = "mailbox@to.share" # please modify

$user = "user@gets.access" # please modify

$inbox = "Inbox"

$customfolder = "Posteingang"


# (1) Add Root Permission - REQUIRED
Try { Add-MailboxFolderPermission -identity $MBX -User $user -Accessrights Reviewer -EA stop } catch { write-host $Error[0].Exception.message -F yellow }


# (2) Add Inbox Permission
Try { Add-MailboxFolderPermission -identity $($MBX+':\'+$inbox) -User $user -Accessrights Reviewer -EA stop } catch { write-host $Error[0].Exception.message -F yellow }


# (3) Add customfolder Permission
Try { Add-MailboxFolderPermission -identity $($MBX+':\'+$customfolder) -User $user -Accessrights Reviewer -EA stop } catch { write-host $Error[0].Exception.message -F yellow }


# (4) Permission to all Folders which match below types
$types = "Inbox","Outbox","SentItems","Drafts","JunkEmail","Archive","Contacts","Calendar","Notes","QuickContacts","RecipientCache","User Created"

foreach($F in (Get-MailboxFolderStatistics $MBX | ? {$_.foldertype.tostring() -in ($types)})){ $FN = $MBX + ':' + $F.FolderPath.Replace('/','\');
Try { Add-MailboxFolderPermission $FN -User $user -AccessRights $access -EA stop } catch { write-host $Error[0].Exception.message -F yellow }}
