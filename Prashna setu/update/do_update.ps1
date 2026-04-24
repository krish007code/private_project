param(
  [string]$AppExePath,
  [string]$NewExePath,
  [int]$PidToWait,
  [string]$Args = ""
)

try { Wait-Process -Id $PidToWait -ErrorAction SilentlyContinue } catch {}
$root = Split-Path -Parent $AppExePath
$backup = Join-Path $root 'PrashnaSetu_OLD.exe'
if (Test-Path $backup) { Remove-Item -Force $backup -ErrorAction SilentlyContinue }
Rename-Item -Path $AppExePath -NewName $backup -Force
Move-Item -Path $NewExePath -Destination $AppExePath -Force
Start-Process -FilePath $AppExePath -ArgumentList $Args
Start-Sleep -Seconds 1
Remove-Item -Force $backup -ErrorAction SilentlyContinue
