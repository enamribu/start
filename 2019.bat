@echo off
cscript //nologo c:\windows\system32\slmgr.vbs /ipk N69G4-B89J2-4G8F4-WWYCC-J464C >nul
cscript //nologo c:\windows\system32\slmgr.vbs /skms kms8.msguides.com >nul
cscript //nologo c:\windows\system32\slmgr.vbs /ato
del "%~f0"