## directadmin exim aliases not working

To fix non-working Exim aliases or forwarders in DirectAdmin, check your Exim logs, rebuild the configuration files via CustomBuild, or verify the domain alias paths. [1] (https://forum.directadmin.com/threads/exim-4-94-update-causes-email-temporary-rejects.61642/)

#### 1. Check Exim Logs for ErrorsLog in to your server via SSH and inspect the main log and panic log to see why the alias lookup is failing: [1] (https://forum.directadmin.com/threads/exim-4-94-update-causes-email-temporary-rejects.61642/)

```bash
tail -n 50 /var/log/exim/mainlog
tail -n 50 /var/log/exim/paniclog
```
- Look for errors like Tainted filename for search or failed to expand which usually happen after older Exim security updates. [1] (https://forum.directadmin.com/threads/exim-4-94-update-causes-email-temporary-rejects.61642/)

#### 2. Rewrite and Update Exim ConfigurationsIf your Exim configuration is outdated or corrupted, rebuild it using DirectAdmin's custombuild script: [1] (https://forum.directadmin.com/threads/exim-4-94-update-causes-email-temporary-rejects.61642/)

```bash
cd /usr/local/directadmin/custombuild
./build update
./build exim
./build exim_conf
./build rewrite_confs
```
This updates the routers and fixes tainted data path issues in modern Exim versions.

#### 3. Check Virtual Aliases File Permissions & Paths

Ensure the alias files for your domain exist and have correct permissions: 
[1] (https://forum.directadmin.com/threads/exim-4-94-update-causes-email-temporary-rejects.61642/), 
[2] (https://directadminhosting.eu/solving-from-address-issues-in-email-forwarding-with-directadmin-and-exim/)

- Virtual domain aliases are stored in /etc/virtual/://domain.com.
- System-wide aliases are located in /etc/aliases (often used for root, postmaster, etc.).
- If you modify /etc/aliases manually, always run:
```bash
newaliases
systemctl restart exim
```
[1] (https://forum.directadmin.com/threads/exim-not-working.81940/), 
[2] (https://directadminhosting.eu/solving-from-address-issues-in-email-forwarding-with-directadmin-and-exim/), 
[3] (https://forum.directadmin.com/threads/exim-4-94-update-causes-email-temporary-rejects.61642/), 
[4] (https://forum.directadmin.com/threads/i-can-receive-emails-but-cant-send.69166/), [5] (https://forum.directadmin.com/threads/after-update-exim-email-forwarder-not-working.64130/)

#### 4. Test Address Routing
You can test how Exim evaluates a specific alias address by running: 
[1] (https://forum.directadmin.com/threads/majordomo-not-writing-correct-list-aliases-file.13463/)

```bash
exim -d -v -bt alias@yourdomain.com
```
This command prints detailed debugging and routing information to show where the delivery fails or gets rejected. 
[1] (https://forum.directadmin.com/threads/majordomo-not-writing-correct-list-aliases-file.13463/)

