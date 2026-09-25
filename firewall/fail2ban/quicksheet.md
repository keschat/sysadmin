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
sudo fail2ban-client set <JAIL> banip <IP>
```
The specified IP is banned and included in the specified jail. E.g., if you want to ban an IP from connect through SSH:
```bash
sudo fail2ban-client set sshd banip 192.0.2.1
```

**Manually unban an IP address**
```bash
sudo fail2ban-client set <JAIL> unbanip <IP>
```
The specified IP in the specified jail is unbanned. E.g., if you want to unban an IP and allow it to connect through SSH:
```bash
sudo fail2ban-client set sshd unbanip 192.0.2.1
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
