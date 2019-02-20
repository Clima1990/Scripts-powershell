#Scheduler JOBs

$Diario = New-JobTrigger -Daily -At 11:50pm
$umavez = New-JobTrigger -Once -at (Get-Date).Add(2)
$semanal = New-JobTrigger -Weekly -DaysOfWeek Monday -At 6pm

Register-ScheduledJob -Name Copy -Trigger $Diario -ScriptBlock {
Remove-Item -Path C:\templog -Recurse -Force
}


Get-ScheduledJob