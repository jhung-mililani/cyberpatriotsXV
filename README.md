# cyberpatriotsXV

### This repository contains useful scripts for our team.

---

## Supported OSes:

- Windows 10
- Windows Server 2022
- Ubuntu
- Debian

---

## File Information

- autoFirewall.bat
    - [x]  basic support for updating registry keys
    - [ ]  extended support for registry keys
    - [ ]  alternate methods of enabling the firewall
- autoUpdates.bat
    - [x]  basic support for updating registry keys
- comprehensive.bat (WARNING: this file will be deprecated soon as it is more useful to break up the script into separate files.)
    1. docs coming soon!
    2. Lists brief, full, startup, and started processes, then pipes the data to text files. 
    3. Changes password policies to harden the system 
        - Minimum password length: 10 characters
        - Maximum password age: 30 days
        - Minimum password age: 5 days
        - [ ]  expand functionality to include other password policies
        - [ ]  also add registry keys to change policies at a lower level
    4. Searches the C: drive for unauthorized media files and common hacking tools. 
        - [ ]  expand list of malware to check for, possibly combine with MBAR to find *all* malware
    5. Disables remote desktop (WARNING: the readme sometimes requires remote desktop to be enabled, in which case do not choose this option.) 
        - [x]  basic support for updating registry keys
        - [ ]  disable remote desktop through services.msc
        - [ ]  extended support for registry keys
    6. Enables automatic Windows updates 
        - [ ]  either merge with autoUpdates.bat or delete file altogether
    7. Disables common unsecured services (see source for full list of disabled services, some may be listed as a “critical service.”) 
    8. Conducts a system integrity scan using sfc.exe 
        - [ ]  add dism check as well
        - [ ]  run a full scan using windows defender and remove any exclusions
        - [ ]  possibly combine with sysinternals options?
    9. Conducts a scan for rootkits using MalwareBytes Anti-Rootkit software (downloaded from the web) 
        - [ ]  possibly combine with microsoft safety scanner?
- linux.sh
    - docs coming soon!
- stopServices.bat
    - uses service control ([sc.exe](https://learn.microsoft.com/en-us/windows/win32/services/controlling-a-service-using-sc)) to manage services (start, stop, disable, enable)
    - [ ]  expand functionality with more services

---

## Planned Features

- [ ]  web scraper to compare authorized users with users present on system and update accordingly
    - [ ]  check password complexity for authorized administrators and provide an option to update accordingly
- [ ]  use sysinternals suite to check for malware (registry modification and unsecured ports)
