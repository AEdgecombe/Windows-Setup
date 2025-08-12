Got it — here’s a **`README.md`** you can drop into your repo or keep for personal use.
It contains **Windows Terminal / PowerShell commands** to:

* Debloat Windows (remove preinstalled apps)
* Enable auto-hide taskbar
* Center taskbar icons
* Create `C:\Dev`
* Install Firefox, Discord, and VS Code

---

````markdown
# Windows Setup & Debloat Script

This guide contains **PowerShell commands** to set up a clean, minimal Windows environment with essential dev tools installed.

> ⚠️ **Run PowerShell as Administrator** before executing these commands.

---

## 1. Remove Preinstalled Bloatware

```powershell
# Uninstall common bloatware apps
Get-AppxPackage *3dbuilder* | Remove-AppxPackage
Get-AppxPackage *xboxapp* | Remove-AppxPackage
Get-AppxPackage *officehub* | Remove-AppxPackage
Get-AppxPackage *skypeapp* | Remove-AppxPackage
Get-AppxPackage *getstarted* | Remove-AppxPackage
Get-AppxPackage *zunemusic* | Remove-AppxPackage
Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage
Get-AppxPackage *solitairecollection* | Remove-AppxPackage
Get-AppxPackage *bingweather* | Remove-AppxPackage
Get-AppxPackage *bingsports* | Remove-AppxPackage
Get-AppxPackage *bingnews* | Remove-AppxPackage
Get-AppxPackage *bingfinance* | Remove-AppxPackage
Get-AppxPackage *people* | Remove-AppxPackage
Get-AppxPackage *maps* | Remove-AppxPackage
Get-AppxPackage *soundrecorder* | Remove-AppxPackage
Get-AppxPackage *3dviewer* | Remove-AppxPackage
Get-AppxPackage *windowsfeedbackhub* | Remove-AppxPackage
````

---

## 2. Taskbar Settings

### Auto-hide Taskbar

```powershell
# Enable auto-hide for taskbar
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3 -Name Settings -Value (
    ($s = (Get-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3 -Name Settings).Settings) -replace ([char]8), [char]9
)
Stop-Process -f -ProcessName explorer
```

### Centre Taskbar Icons (Windows 11)

```powershell
# Set taskbar alignment to center
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarAl -Value 1
Stop-Process -f -ProcessName explorer
```

---

## 3. Create Dev Directory

```powershell
# Make a development folder
New-Item -ItemType Directory -Path "C:\Dev" -Force
```

---

## 4. Install Essential Apps (Firefox, Discord, VS Code)

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

---

✅ After running these commands, Windows will be **debloated, clean, and ready for dev work**.



