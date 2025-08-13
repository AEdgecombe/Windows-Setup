# Removing bloat apps and disabling features in Windows 11

$apps = @(
    "*3dbuilder*",
    "*xboxapp*",
    "*officehub*",
    "*skypeapp*",
    "*getstarted*",
    "*zunemusic*",
    "*windowscommunicationsapps*",
    "*solitairecollection*",
    "*bingweather*",
    "*bingsports*",
    "*bingnews*",
    "*bingfinance*",
    "*people*",
    "*maps*",
    "*soundrecorder*",
    "*3dviewer*",
    "*windowsfeedbackhub*",
    "*mixedreality*",
    "*YourPhone*",
    "*clipchamp*",
    "*candycrush*",
    "*Spotify*",
    "*devhome*",
    "*Teams*",
    "*Cortana*"
)

foreach ($app in $apps) {
    Get-AppxPackage -AllUsers $app | Remove-AppxPackage -ErrorAction SilentlyContinue
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $app | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
}

# --- Disable all startup apps for current user ---
Get-CimInstance Win32_StartupCommand | ForEach-Object {
    $name = $_.Name
    Write-Host "Disabling startup item: $name"
    try {
        # Remove from registry
        Remove-ItemProperty -Path $_.Location -Name $name -ErrorAction SilentlyContinue
    } catch {}
}

# --- Optional: Disable consumer experience & ads ---
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableConsumerFeatures" -Value 1 -Type DWord -Force
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Value 0 -Type DWord -Force

# Enable auto-hide for taskbar
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3 -Name Settings -Value (
    ($s = (Get-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3 -Name Settings).Settings) -replace ([char]8), [char]9
)
Stop-Process -f -ProcessName explorer

# Set taskbar alignment to center
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarAl -Value 1
Stop-Process -f -ProcessName explorer

# Make a development folder
New-Item -ItemType Directory -Path "C:\Dev" -Force

# Install Firefox
winget install --id Mozilla.Firefox -e

# Install Discord
winget install --id Discord.Discord -e

# Install Visual Studio Code
winget install --id Microsoft.VisualStudioCode -e

Stop-Process -f -ProcessName explorer