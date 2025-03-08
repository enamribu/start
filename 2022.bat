@echo off
cscript //nologo c:\windows\system32\slmgr.vbs /ipk VDYBN-27WPP-V4HQT-9VMD4-VMK7H >nul
cscript //nologo c:\windows\system32\slmgr.vbs /skms kms8.msguides.com >nul
cscript //nologo c:\windows\system32\slmgr.vbs /ato
del "%~f0"
