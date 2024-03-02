#$url = "https://fonts.google.com/download/list?family=Roboto"
#$dest = "C:\temp"

#if(!(Test-Path $dest)){
#		New-Item -Path "C:\" -Name "temp" -ItemType Directory -Force
#	}


#Start-BitsTransfer  -Source $url -Destination $dest -Asynchronous -Priority normal

#Wird wahrscheinlich nichts so
#API-Key
#AIzaSyArTktx5K3LiB4hhrmf0erdFmsmS9SfhbM

# Ersetze 'Open+Sans' durch den Namen der gewünschten Google Font
$fontName = 'Roboto'

# Google Fonts API-URL, um die Informationen zur neuesten Version zu erhalten
$apiUrl = "https://www.googleapis.com/webfonts/v1/webfonts?key=AIzaSyArTktx5K3LiB4hhrmf0erdFmsmS9SfhbM&family=$fontName"

# JSON-Daten von der API abrufen
$response = Invoke-RestMethod -Uri $apiUrl -Method Get

# Die neueste Version der Schriftart abrufen
$latestVersion = $response.items[0].version

# URL zum Herunterladen der Schriftart erstellen
$fontUrl = "https://fonts.googleapis.com/css?family=${fontName}:${latestVersion}"

# Die Schriftart herunterladen und in einem Verzeichnis speichern
Invoke-WebRequest -Uri $fontUrl -OutFile "$env:temp\$fontName.css"

# Die CSS-Dateiinhalt extrahieren, um die Schriftart-Dateien zu identifizieren
$cssContent = Get-Content "$env:temp\$fontName.css"
$fontFiles = $cssContent -match "url\('(https://.+\..+?)'\)"

# Überprüfen, ob es Übereinstimmungen gibt, bevor die Schleife ausgeführt wird
if ($matches -ne $null -and $matches.Count -ge 2) {
    # Schriftart-Dateien herunterladen und in einem Verzeichnis speichern
    foreach ($fontFile in $matches[1]) {
        $fileName = [System.IO.Path]::GetFileName($fontFile)
        Invoke-WebRequest -Uri $fontFile -OutFile "$env:temp\$fileName"
    }

    # Schriftart-Dateien in das Windows-Schriftartenverzeichnis kopieren
    Copy-Item "$env:temp\*.ttf" -Destination "$env:SystemRoot\Fonts" -Force
}