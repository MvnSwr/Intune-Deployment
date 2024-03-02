#Set Parameters
$FileURL = 'https://github.com/MvnSwr/Fonts/archive/refs/heads/main.zip'
$LocalFolderPath = 'C:\temp'
 
Try {
    #Ensure the destination local folder exists! 
    if (!(Test-Path -path $LocalFolderPath))
    {    
         #If it doesn't exists, Create
         New-Item $LocalFolderPath -type directory 
    }
 
	#download fonts
	Invoke-WebRequest -Uri $FileURL -OutFile 'C:\temp\main.zip'
 
    Write-host -f Green 'File downloaded Successfully!'
	
	#unzip files
	
	Expand-Archive -LiteralPath 'C:\temp\main.zip' -DestinationPath 'C:\temp' -Force
	
	Write-host -f Green 'Files unziped Successfully!'

	#install fonts
	
	$FontList = Get-Item -Path 'C:\temp\Fonts-main\*' -Include ('*.fon','*.otf','*.ttc','*.ttf') -Force

	foreach ($Font in $FontList) {
			Write-Host 'Installing font -' $Font.BaseName
			Copy-Item $Font 'C:\Windows\Fonts' -Force
			New-ItemProperty -Name $Font.BaseName -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts' -PropertyType string -Value $Font.name -Force
	}
	
	#delete data from temp
	
	Remove-Item -LiteralPath 'C:\temp\Fonts-main' -Force -Recurse
	Remove-Item -LiteralPath 'C:\temp\main.zip' -Force -Recurse
	
	Write-host -f Green 'Files deleted Successfully!'
	
}
Catch {
Write-host -f Red 'Error:' $_.Exception.Message
}