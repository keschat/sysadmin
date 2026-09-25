## Basic commands

> Ref:
> https://bornoe.org/blog/2023/09/basic-fail2ban-commands/

### List of commonly used commands

**Check Fail2ban status**
```bash
sudo systemctl status fail2ban
```

**Start Fail2ban**
```bash
sudo systemctl start fail2ban
```

**Stop Fail2ban**
```bash
sudo systemctl stop fail2ban
```

**Restart Fail2ban**
```bash
sudo systemctl restart fail2ban
```

**Reload Fail2ban configuration without restarting**
```bash
sudo fail2ban-client reload
```

**Enable Fail2ban to start on boot**
```bash
sudo systemctl enable fail2ban
```

**Disable Fail2ban from starting on boot**
```bash
sudo systemctl disable fail2ban
```

**View a list of all jails**
```bash
sudo fail2ban-client status
```

**List all banned IP addresses in all jails**
```bash
sudo fail2ban-client banned
```

**Check the status of a specific jail (e.g., sshd)**
```bash
sudo fail2ban-client status <JAIL>
```

_**Shows the status of a specific Fail2ban jail, such as SSH:**_
```bash
sudo fail2ban-client status sshd
```

**Manually ban an IP address**
```bash
sudo fail2ban-client set <JAIL> banip <IP-ADDRESS>
```
The specified IP is banned and included in the specified jail. E.g., if you want to ban an IP from connect through SSH:
```bash
sudo fail2ban-client set sshd banip <IP-ADDRESS>
```

**Manually unban an IP address**
```bash
sudo fail2ban-client set <JAIL> unbanip <IP-ADDRESS>
```
The specified IP in the specified jail is unbanned. E.g., if you want to unban an IP and allow it to connect through SSH:
```bash
sudo fail2ban-client set sshd unbanip <IP-ADDRESS>
```

**Display the current Fail2ban version**
```bash
sudo fail2ban-client version
```

**Check fail2ban.log**
```bash
sudo tail /var/log/fail2ban.log
```
_Displays the 10 latest entries in the log file._

**Get help and information about all Fail2ban commands**
```bash
sudo fail2ban-client --help
```
_Displays the man page for Fail2ban with details about all Fail2ban commands and options._

****

Ref: https://docs.strangebee.com/thehive/how-to/fail2ban/

### Adding TheHive into Fail2ban

To integrate TheHive logs with Fail2ban, follow the steps below. Assume TheHive logs are located at `/var/log/thehive/application.lo`g and Fail2ban configuration files are located in /`etc/fail2ban`.

1. **Step 1**: Create a Filter File
- Create a filter file in /etc/fail2ban/filter.d named thehive.conf with the following content:
```txt
[INCLUDES]
before = common.conf

[Definition]
failregex = ^.*- <HOST> (?:POST \/api\/login|GET .*) .*returned 401.*$
ignoreregex =
```

2. **Step 2**: Create a Jail File
Create a jail file in `/etc/fail2ban/jail.d` named `thehive.local` with the following content:
```txt
[thehive]
enabled = true
port = 80,443
filter = thehive
action = iptables-multiport[name=thehive, port="80,443"]
logpath = /var/log/thehive/application.log
maxretry = 5
bantime = 14400
findtime = 1200
```
_This configuration will ban any IP address for 4 hours after 5 failed authentication attempts within a 20-minute period._

3. **Step 3**: Reload Fail2ban Configuration
Reload the Fail2ban configuration to apply the changes:
```bash
fail2ban-client reload
```

### Review Banned IP Addresses
Here is a step-by-step guide to reviewing banned IP addresses on Fail2ban:

1 **Step 1**: Check Fail2ban Status:
Use the following command to get an overview of Fail2ban status and active jails:
```bash
sudo fail2ban-client status
```

2. **Step 2**: Review Banned IPs for a Specific Jail
Use this command to view banned IPs in a particular jail.
```bash
sudo fail2ban-client status thehive
```

### Unban an IP Address#
Use the following command to remove the ban on a specific IP address. Replace `jail_name` with the jail's name and `IP_address` with the specific IP address you want to unban:
```bash
sudo fail2ban-client set thehive unbanip 1.1.1.1
```
