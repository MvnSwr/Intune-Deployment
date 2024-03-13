#Fonts are downloaded from this Repo
#Set Parameters
$FileURL = 'https://github.com/MvnSwr/Intune-Deployment/archive/refs/heads/main.zip'
$LocalFolderPath = 'C:\temp'
$LocalFolderFonts = 'C:\temp\font'

Try {
    #Ensure the destination local folder exists! 
    if (!(Test-Path -path $LocalFolderPath))
    {    
         #If it doesn't exists, Create
         New-Item $LocalFolderPath -type directory 
    }
	New-Item $LocalFolderFonts -type directory
 
	#download fonts
	Invoke-WebRequest -Uri $FileURL -OutFile 'C:\temp\main.zip'
 
    Write-host -f Green 'File downloaded Successfully!'
	
	#unzip files
	
	Expand-Archive -LiteralPath 'C:\temp\main.zip' -DestinationPath 'C:\temp' -Force

	Write-host -f Green 'Github-files unziped Successfully!'

	Expand-Archive -LiteralPath 'C:\temp\Intune-Deployment-main\Fonts\Fonts\Roboto.zip' -DestinationPath 'C:\temp\font' -Force
	
	Write-host -f Green 'Font-files unziped Successfully!'


	#install fonts
	
	$FontList = Get-Item -Path 'C:\temp\font\*' -Include ('*.fon','*.otf','*.ttc','*.ttf') -Force

	foreach ($Font in $FontList) {
			Write-Host 'Installing font -' $Font.BaseName
			Copy-Item $Font 'C:\Windows\Fonts' -Force
			New-ItemProperty -Name $Font.BaseName -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts' -PropertyType string -Value $Font.name -Force
	}
	
	#delete data from temp
	
	Remove-Item -LiteralPath 'C:\temp\Intune-Deployment-main' -Force -Recurse
	Remove-Item -LiteralPath 'C:\temp\font' -Force -Recurse
	Remove-Item -LiteralPath 'C:\temp\main.zip' -Force -Recurse
	
	Write-host -f Green 'Files deleted Successfully!'
	
}Catch {
	Write-host -f Red 'Error:' $_.Exception.Message
}
