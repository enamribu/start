@echo off
cscript //nologo c:\windows\system32\slmgr.vbs /ipk WC2BQ-8NRM3-FDDYY-2BFGV-KHKQY >nul
cscript //nologo c:\windows\system32\slmgr.vbs /skms kms.vultr.com >nul
cscript //nologo c:\windows\system32\slmgr.vbs /ato
del "%~f0"