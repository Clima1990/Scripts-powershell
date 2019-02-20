#Virtual CLone

$EtlVar =  @{ERRO ="Erro";FINALIZADO ="Fixed Income ETL process finished!"}

#$A = Get-ChildItem C:\Temp| Sort-Object -Property CreationTime | Select-Object -Last 1 | Get-Content -Filter  "finished"
#$e = Get-ChildItem C:\Temp| Sort-Object -Property CreationTime | Select-Object -Last 1 | Get-Content -Filter  "Erro" 


$A = Get-ChildItem C:\Temp| Sort-Object -Property CreationTime | Select-Object -Last 1 | Select-String -Pattern "Fixed Income ETL process finished!"
$e = Get-ChildItem C:\Temp| Sort-Object -Property CreationTime | Select-Object -Last 1 | Select-String -Pattern "Erro"



$e
$A


$PSEmailServer = "smtp.office365.com"
$SMTPPort = 587
$SMTPUsername = "cleber.lima@"
$EncryptedPasswordFile = "C:\Temp\SSS.txt"
$SecureStringPassword = Get-Content -Path $EncryptedPasswordFile | ConvertTo-SecureString
$EmailCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $SMTPUsername,$SecureStringPassword
$MailTo = "cleber.lima@"
$MailFrom = "cleber.lima@"
$MailSubject = "Processo Virtual CLONE ETL "
$MailBodyErro = "Copia ETL com ERRO. `n `n `n $e"
$MailBodySucesso = "Copia ETL finalizada com sucesso. `n `n $A"
$MailBodyProcesso = "Copia ETL em processamento, Verificar arquivo de log."

#Salvando senha em arquivo	
#Read-Host -AsSecureString | ConvertFrom-SecureString | Out-File -FilePath .\SSS.txt

if($e -match $Etlvar.ERRO) {
    Send-MailMessage -From $MailFrom -To $MailTo -Subject $MailSubject -Body $MailBodyErro -Port $SMTPPort -Credential $EmailCredential -UseSsl
    }
elseif($A -match $EtlVar.FINALIZADO) {
    Send-MailMessage -From $MailFrom -To $MailTo -Subject $MailSubject -Body $MailBodySucesso -Port $SMTPPort -Credential $EmailCredential -UseSsl
    }
else {Send-MailMessage -From $MailFrom -To $MailTo -Subject $MailSubject -Body $MailBodyProcesso -Port $SMTPPort -Credential $EmailCredential -UseSsl}



