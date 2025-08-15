# Windows Setup & Debloat Script

This guide contains **PowerShell commands** to set up a clean, minimal Windows environment with essential dev tools installed. The debloat.ps1 file contains the entire script in one go for everything below. Configure as required. WIP

> ⚠️ **Run PowerShell as Administrator** before executing these commands.

---

## 1. Remove Preinstalled Bloatware

```powershell
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

````

---

## 2. Taskbar Settings (Optional)

### Centre Taskbar Icons (Windows 11) (Optional)

```powershell
# Set taskbar alignment to center
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarAl -Value 1
Stop-Process -f -ProcessName explorer
```

---

## 3. Create Dev Directory (Optional)

```powershell
# Make a development folder
New-Item -ItemType Directory -Path "C:\Dev" -Force
```

---

## 4. Install Essential Apps (Firefox, Discord, VS Code) (Optional)

We’ll use **winget** (Windows Package Manager).

```powershell
# Install Firefox
winget install --id Mozilla.Firefox -e

# Install Discord
winget install --id Discord.Discord -e

# Install Visual Studio Code
winget install --id Microsoft.VisualStudioCode -e
```

---

## 5. Optional — Install Google Chrome

```powershell
winget install --id Google.Chrome -e
```

---

## 6. Restart Explorer (to apply UI changes)

```powershell
Stop-Process -f -ProcessName explorer
```





