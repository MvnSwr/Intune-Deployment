$name = @("Roboto-Black","Roboto-BlackItalic","Roboto-Bold","Roboto-BoldItalic","Roboto-Italic","Roboto-Light","Roboto-LightItalic",
"Roboto-Medium","Roboto-MediumItalic","Roboto-Regular","Roboto-Thin","Roboto-ThinItalic")
$folderpath = "C:\Windows\Fonts\"
$end = ".ttf"

for($var = 0; $var -le 11; $var++){
    Try{
        $path = ($folderpath + $name[$var] + $end)
        Write-Host "uninstalling $($name[$var])"
        Remove-Item -Path $path -Force
        Remove-ItemProperty -Path "HKLM:\Software\Microsoft\WindowsNT\CurrentVersion\Fonts" -Name $name[$var] -Force
        $path = $null
    }catch{
        Write-Host -f Red 'Error:' $_.Exception.Message
    }
}