$computername = @("glchbs-ss320003.eu.novartis.net")
$applicationpath = "application"
$backupdestination = "backup"
$buildpath = "output"
$nwa = "IIS_application-"


foreach ($com in $ComputerName)
{
##Stop IIS website
##Stop-Website -Name "IIS_application"
##Stop-WebAppPool -Name "IIS_application"

##Backup the current application build
$backupcurrentbuild = "\\" + $com + "\$applicationpath\"
$BackupFolder = "\\" + $com + "\$backupdestination\"
$BackupFolderName = $BackupFolder + $nwa
$createbackupfolder = mkdir $BackupFolderName$(get-date -f MM-dd-yyyy-HH_mm_ss)
$FullBackupPath = $CreateBackupFolder.FullName + "\"
Copy-Item -Path $backupcurrentbuild -Destination $FullBackupPath -Recurse -Force

##Delete the current application build binaries
$deletecurrentbuild = "\\" + $com + "\$applicationpath\*"
Remove-Item -Path $deletecurrentbuild -Recurse -Force

##Deploy the latest build
cp D:\jenkins\workspace\IIS_project\Index.html D:\jenkins\output
$deploylatsetbuildFrom = "\\" + $com + "\$buildpath\*"
$deploylatsetbuildTo = "\\" + $com + "\$applicationpath\"
Copy-Item -Path $deploylatsetbuildFrom -Destination $deploylatsetbuildTo -Recurse -Force

##Stop IIS website
##Start-Website -Name "IIS_application"
##Stop-WebAppPool -Name "IIS_application"
}