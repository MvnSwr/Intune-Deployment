#fonts are hand over with this script
$LocalFolderPath = 'C:\temp\Roboto'
 
Try {
    #ensure the local folder exists! 
    if (!(Test-Path -path $LocalFolderPath))
    {    
         #if not, create one
         New-Item $LocalFolderPath -type directory 
    }
 
	#unzip files
	
	Expand-Archive -LiteralPath '.\Roboto.zip' -DestinationPath $LocalFolderPath -Force
	
	Write-host -f Green 'Files unziped Successfully!'

	#install fonts
	
	$FontList = Get-Item -Path 'C:\temp\Roboto\*' -Include ('*.fon','*.otf','*.ttc','*.ttf') -Force

	foreach ($Font in $FontList) {
			Write-Host 'Installing font -' $Font.BaseName
			Copy-Item $Font 'C:\Windows\Fonts' -Force
			New-ItemProperty -Name $Font.BaseName -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts' -PropertyType string -Value $Font.name -Force
	}
	
	#delete data from temp
	
	Remove-Item -LiteralPath 'C:\temp\Roboto' -Force -Recurse
	
	Write-host -f Green 'Files deleted Successfully!'
	
}
Catch {
Write-host -f Red 'Error:' $_.Exception.Message
}
