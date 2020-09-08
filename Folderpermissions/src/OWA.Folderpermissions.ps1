# Folder permissions in OWA
#-------------------------

$access = 'Reviewer'

$MBX = "mailbox@to.share" # please modify

$user = "user@gets.access" # please modify

$inbox = "\Posteingang"

$customfolder = "customfolder"

# Add Root Permission - REQUIRED
Try { Add-MailboxFolderPermission -identity $MBX -User $user -Accessrights Reviewer -EA stop } catch { write-host $Error[0].Exception.message -F yellow }

# Add Inbox Permission
Try { Add-MailboxFolderPermission -identity $($MBX+':\'+$inbox) -User $user -Accessrights Reviewer -EA stop } catch { write-host $Error[0].Exception.message -F yellow }

# Add customfolder Permission
Try { Add-MailboxFolderPermission -identity $($MBX+':\'+$customfolder) -User $user -Accessrights Reviewer -EA stop } catch { write-host $Error[0].Exception.message -F yellow }




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

foreach($F in $FLD){ $FN = $MBX + ':' + $F.FolderPath.Replace('/','\');
Try { Add-MailboxFolderPermission $FN -User $user -AccessRights $access -EA stop } catch { write-host $Error[0].Exception.message -F yellow }
}

$types = "Inbox","Outbox","SentItems","Drafts","JunkEmail","Archive","Contacts","Calendar","Notes","QuickContacts","RecipientCache","User Created"
$SRC = Get-MailboxFolderStatistics $MBX ;





foreach($F in $FLD){ Try { Add-MailboxFolderPermission "$($MBX):$($F.FolderPath.Replace('/','\'))" -User $user -AccessRights $access -EA stop 
} catch { write-host "$($Error.Exception.message)" -F yellow }}


Try { Add-MailboxFolderPermission $FN -User $user -AccessRights $access -EA stop } catch { write-host "$($Error.Exception.message)" -F yellow }

}


$RS1.FolderPath

$RS2.count
$Srch.count
$Srch.FolderPath
$Srch.Name
$rs1[13].Name

$MBX


$types = "Inbox","Outbox","SentItems","Drafts","JunkEmail","Archive","Contacts","Calendar","Notes","QuickContacts","RecipientCache","User Created"

$SRC = (Get-MailboxFolderStatistics $MBX | ? {$_.foldertype.tostring() -in ($types)})


$access = 'Reviewer'

$MBX = "mailbox@to.share" # please modify

$user = "user@gets.access" # please modify

$types = "Inbox","Outbox","SentItems","Drafts","JunkEmail","Archive","Contacts","Calendar","Notes","QuickContacts","RecipientCache","User Created"

foreach($F in (Get-MailboxFolderStatistics $MBX | ? {$_.foldertype.tostring() -in ($types)})){ $FN = $MBX + ':' + $F.FolderPath.Replace('/','\');
Try { Add-MailboxFolderPermission $FN -User $user -AccessRights $access -EA stop } catch { write-host $Error[0].Exception.message -F yellow }}