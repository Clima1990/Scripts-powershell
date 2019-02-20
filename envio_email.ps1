#Virtual CLone


$EtlVar =  @{ERRO ="ERRO";FINALIZADO ="Fixed Income ETL process finished"}

$A = Get-ChildItem C:\Temp| Sort-Object -Property CreationTime | Select-Object -Last 1 | Select-String "finished"
$e = Get-ChildItem C:\Temp| Sort-Object -Property CreationTime | Select-Object -Last 1 | Select-String "Erro"


$PSEmailServer = "smtp.office365.com"
$SMTPPort = 587
$SMTPUsername = "Email"
$EncryptedPasswordFile = "C:\Temp\SSS.txt"
$SecureStringPassword = Get-Content -Path $EncryptedPasswordFile | ConvertTo-SecureString
$EmailCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $SMTPUsername,$SecureStringPassword
$MailTo = "Email"
$MailFrom = "Email"
$MailSubject = "Processo ETL"
$MailBodyErro = "Copia ETL com ERRO, `n `n `n $e"
$MailBodySucesso = "Copia ETL finalizada com sucesso" ,"`n`n$A"

#Salvando senha em arquivo	
#Read-Host -AsSecureString | ConvertFrom-SecureString | Out-File -FilePath .\SSS.txt



if($e -match $Etlvar.ERRO) {
    Send-MailMessage -From $MailFrom -To $MailTo -Subject $MailSubject -Body $MailBodyErro -Port $SMTPPort -Credential $EmailCredential -UseSsl
    }
elseif ($A -match $EtlVar.FINALIZADO) {
    Send-MailMessage -From $MailFrom -To $MailTo -Subject $MailSubject -Body $MailBodySucesso -Port $SMTPPort -Credential $EmailCredential -UseSsl
    }
else {Write-Host "Verificar arquivo de log ETL"}
