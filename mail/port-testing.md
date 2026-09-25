## chck if imap is working

To check if your IMAP service is working on AlmaLinux, test the local service status, verify the listening ports (143 for plain IMAP, 993 for IMAPS), and test the connection.
```
https://serverfault.com/questions/317860/how-do-i-find-out-if-my-server-is-running-imap
```
1. ### Check the IMAP Service Status
Check if your mail server software (such as Dovecot) is running via systemd:
- Run `sudo systemctl status dovecot2`

2. ### Check Listening Ports
Check if the system is actively listening on standard IMAP ports:
- Run `sudo ss -tulpn | grep -E '143|993'`

3. ### Test Local Connectivity
Test if you can connect to the IMAP port locally:
- For unencrypted IMAP (Port 143): nc localhost 143 or telnet localhost 143
- For secure IMAPS (Port 993): openssl s_client -connect localhost:9934.

4. ### Check Firewall Settings
If external connections fail, ensure firewalld allows IMAP traffic:
- Check active rules: `sudo firewall-cmd --list-services`
- Allow IMAP/IMAPS permanently: `sudo firewall-cmd --permanent --add-service=imap` and `sudo firewall-cmd --reload`
