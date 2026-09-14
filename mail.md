## almalinux check if imap is working

To check if IMAP is working on your AlmaLinux server, verify the service status, listen ports, and local connectivity. 
[1] (https://serverfault.com/questions/317860/how-do-i-find-out-if-my-server-is-running-imap)

### 1. Check Service Status

Run the following command to see if your IMAP server daemon (such as Dovecot) is running and active:
```bash
sudo systemctl status dovecot

# If it is not running, start it using:

sudo systemctl start dovecot
```

### 2. Check Listening Ports

IMAP typically runs on port 143 (non-secure/STARTTLS) and port 993 (IMAPS/SSL). <br> 

**Use ss to check if the system is actively listening on these ports:** <br> 
[1] (https://serverfault.com/questions/317860/how-do-i-find-out-if-my-server-is-running-imap)

```bash
sudo ss -tulpn | grep -E '143|993'
```

Look for dovecot or the corresponding process name in the output under the listening state.

### 3. Test Local Connectivity

Test if you can connect to the IMAP service locally using nc (netcat) or openssl: <br>
[1] (https://serverfault.com/questions/1038895/how-do-you-properly-test-an-imap993-connection-to-determine-whether-implicit-or), <br>
[2] (https://serverfault.com/questions/317860/how-do-i-find-out-if-my-server-is-running-imap)

- For standard port 143:
```bash
nc -zv localhost 143
```

- For secure SSL port 993:
```bash
openssl s_client -connect localhost:993 -crlf
```

[1] (https://serverfault.com/questions/317860/how-do-i-find-out-if-my-server-is-running-imap), <br>
[2] (https://serverfault.com/questions/1038895/how-do-you-properly-test-an-imap993-connection-to-determine-whether-implicit-or)

### 4. Check Firewall Settings

If external devices or local email clients cannot connect, verify that firewalld allows IMAP traffic: <br>
[1] (https://wiki.almalinux.org/series/system/SystemSeriesA02), <br>
[2] (https://www.codetwo.com/kb/how-to-test-imap-connection-with-server/)

```bash
sudo firewall-cmd --list-services
```

If imap or imaps is missing, allow them through the firewall:

```bash
sudo firewall-cmd --permanent --add-service=imap
sudo firewall-cmd --permanent --add-service=imaps
sudo firewall-cmd --reload
```

If you're still experiencing issues, let me know:Which IMAP software you are using (e.g., Dovecot)If you see any specific errors in the logs (journalctl -u dovecot)I can help you troubleshoot further.
