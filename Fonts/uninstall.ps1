$name = {"Roboto-Black","Roboto-BlackItalic","Roboto-Bold","Roboto-BoldItalic","Roboto-Italic","Roboto-Light","Roboto-LigthItalic",
"Roboto-Medium","Roboto-MediumItalic","Roboto-Regular","Roboto-Thin","Roboto-ThinItalic"}
$path = "C:\Windows\Fonts\"
$end = ".ttf"

for($var = 0; $var -le 11; $var++){
    Try{
        Remove-Item -Path $path$name[$var]$end -Force
        Remove-ItemProperty -Path "HKLM:\Software\Microsoft\WindowsNT\CurrentVersion\Fonts\" -Name $name[$var] -Force
    }catch{}
}