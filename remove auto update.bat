@echo off
:: Script untuk menonaktifkan Windows Update secara permanen dan menghapus dirinya sendiri setelah selesai
:: Berfungsi untuk Windows 10, 11, Server 2012/2016/2019/2022
:: Harus dijalankan sebagai Administrator

:: Periksa hak administrator
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Script ini harus dijalankan sebagai Administrator!
    pause
    exit /b
)

:: Simpan path script saat ini untuk penghapusan nanti
set SCRIPT_PATH=%0

echo [1/8] Menghentikan layanan Windows Update...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
net stop dosvc >nul 2>&1
sc config wuauserv start= disabled >nul 2>&1
sc config bits start= disabled >nul 2>&1
sc config dosvc start= disabled >nul 2>&1

echo [2/8] Menonaktifkan Task Scheduler terkait Update...
schtasks /Change /TN "\Microsoft\Windows\WindowsUpdate\Scheduled Start" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /DISABLE >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Reboot" /DISABLE >nul 2>&1

echo [3/8] Mengubah kebijakan Update melalui Registry...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DisableWindowsUpdateAccess /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Services\Default" /v DefaultService /t REG_SZ /d "" /f >nul 2>&1

echo [4/8] Memblokir koneksi ke server Windows Update...
echo 127.0.0.1 fe2.update.microsoft.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 fe3.update.microsoft.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 fe4.update.microsoft.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 fe1.update.microsoft.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 fe5.update.microsoft.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 fe6.update.microsoft.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 fe7.update.microsoft.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 fe8.update.microsoft.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 fe9.update.microsoft.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 fe10.update.microsoft.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 fe11.update.microsoft.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 fe12.update.microsoft.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 update.microsoft.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 download.microsoft.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 windowsupdate.microsoft.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 windowsupdate.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 www.windowsupdate.com >> %SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 ftp.microsoft.com >> %SystemRoot%\System32\drivers\etc\hosts

echo [5/8] Menonaktifkan Windows Update melalui Group Policy...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DisableOSUpgrade /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v SetDisableUXWUAccess /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdates /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdates /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v PauseFeatureUpdates /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v PauseQualityUpdates /t REG_DWORD /d 1 /f >nul 2>&1

echo [6/8] Menghapus cache Windows Update...
rd /s /q "%SystemRoot%\SoftwareDistribution" >nul 2>&1
mkdir "%SystemRoot%\SoftwareDistribution" >nul 2>&1
attrib +r +h "%SystemRoot%\SoftwareDistribution" >nul 2>&1

echo [7/8] Menonaktifkan Windows Update Medic Service (Windows 10/11)...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc config WaaSMedicSvc start= disabled >nul 2>&1

echo [8/8] Menonaktifkan Microsoft Store Auto Update...
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v AutoDownload /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v AutoDownload /t REG_DWORD /d 2 /f >nul 2>&1

echo.
echo Proses selesai! Windows Update telah dinonaktifkan secara permanen.
echo Restart komputer untuk menerapkan semua perubahan.
echo Script ini akan menghapus dirinya sendiri setelah Anda menekan tombol...
del "%~f0"
exit