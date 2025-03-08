@echo off
cscript //nologo c:\windows\system32\slmgr.vbs /ipk D2N9P-3P6X9-2R39C-7RTCD-MDVJX >nul
cscript //nologo c:\windows\system32\slmgr.vbs /skms kms.vultr.com >nul
cscript //nologo c:\windows\system32\slmgr.vbs /ato
del "%~f0"