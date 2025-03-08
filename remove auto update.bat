   @echo off
   echo Menonaktifkan Windows Update secara permanen...

   :: Hentikan layanan Windows Update
   net stop wuauserv
   net stop cryptSvc
   net stop bits
   net stop msiserver

   :: Nonaktifkan layanan Windows Update
   sc config wuauserv start= disabled
   sc config cryptSvc start= disabled
   sc config bits start= disabled
   sc config msiserver start= disabled

   :: Hapus folder SoftwareDistribution
   echo Menghapus folder SoftwareDistribution...
   rd /s /q C:\Windows\SoftwareDistribution

   :: Mengubah pengaturan di Registry untuk menonaktifkan pembaruan otomatis
   echo Mengubah pengaturan Registry...
   reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f

   echo Windows Update telah dinonaktifkan secara permanen.
   pause
