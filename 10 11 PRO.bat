@echo off
cscript //nologo c:\windows\system32\slmgr.vbs /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX >nul
cscript //nologo c:\windows\system32\slmgr.vbs /skms kms8.msguides.com >nul
cscript //nologo c:\windows\system32\slmgr.vbs /ato
del "%~f0"
