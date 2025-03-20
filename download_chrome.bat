@echo off
setlocal

:: Tentukan URL unduhan Google Chrome terbaru
set "URL=https://dl.google.com/chrome/install/latest/chrome_installer.exe"
set "INSTALLER=%TEMP%\chrome_installer.exe"

:: Unduh Google Chrome
echo Mengunduh Google Chrome...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%URL%', '%INSTALLER%')"

:: Periksa apakah unduhan berhasil
if not exist "%INSTALLER%" (
    echo Gagal mengunduh Google Chrome.
    exit /b 1
)

:: Instal Google Chrome secara otomatis
echo Menginstal Google Chrome...
start /wait "" "%INSTALLER%" /silent /install

:: Hapus installer setelah selesai
del "%INSTALLER%"

:: Hapus diri sendiri setelah selesai
echo exit | timeout /t 3 >nul & del "%~f0"

