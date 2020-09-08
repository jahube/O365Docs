1.)

Send-MailMessage -SmtpServer 'smtp.office365.com' -From ‘sender@domain.com' -To 'someemail@domain.com' -Subject 'this is a subject' -Body 'this is the body' -UseSsl -Port 587 -Credential $credential -Verbose


2.)	test 2

$Cred = Get-Credential
$sendMailParams = @{
    From = ‘sender@domain.com' ## Must be own tenant
    To = 'someemail@domain.com'
    Subject = 'some subject'
    Body = 'some body'
    SMTPServer = ‘smtp.office365.com’
    SMTPPort = 587
    UseSsl = $true
    Credential = $Cred
}

Send-MailMessage @sendMailParams

3.) test 3
# Source https://www.undocumented-features.com/2018/05/22/send-authenticated-smtp-with-powershell/

# Sender and Recipient Info
$MailFrom = "sender@senderdomain.com"
$MailTo = "recipient@recipientdomain.com"

# Sender Credentials
$Username = "SomeUsername@SomeDomain.com"
$Password = "SomePassword"

# Server Info
$SmtpServer = "smtp.domain.com"
$SmtpPort = "2525"

# Message stuff
$MessageSubject = "Live your best life now" 
$Message = New-Object System.Net.Mail.MailMessage $MailFrom,$MailTo
$Message.IsBodyHTML = $true
$Message.Subject = $MessageSubject
$Message.Body = @'
<!DOCTYPE html>
<html>
<head>
</head>
<body>
This is a test message to trigger an ETR.
</body>
</html>
'@

# Construct the SMTP client object, credentials, and send
$Smtp = New-Object Net.Mail.SmtpClient($SmtpServer,$SmtpPort)
$Smtp.EnableSsl = $true
$Smtp.Credentials = New-Object System.Net.NetworkCredential($Username,$Password)
$Smtp.Send($Message)