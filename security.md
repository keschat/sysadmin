# Almalinux see all users

****

## AI Overview

On AlmaLinux, you can see all users through the command line or a graphical interface. Because AlmaLinux is based on RHEL, it uses standard Linux user management files and commands. 

## Using the Command Line

The most common way to list users is by querying the system's password database.

- **List all local users:** The `/etc/passwd` file contains a list of every user account. You can view the full file with:  
  `cat /etc/passwd`
- **List only usernames:** To get a clean list of just the usernames without the extra configuration data, use cut:  
  `cut -d: -f1 /etc/passwd`
- **List users including network accounts:** If your AlmaLinux system is connected to LDAP or Active Directory, use the [getent command](https://wiki.almalinux.org/beginners/users-and-groups.html) to see both local and remote users:  
  `getent passwd`
- **Filter for "Real" (Human) Users:** By default, AlmaLinux assigns User IDs (UID) of 1000 and above to regular users. You can filter the list to hide system accounts using [awk](https://www.cyberciti.biz/faq/linux-list-users-command/):  
  `awk -F':' '{ if($3 >= 1000 && $3 < 65534) print $1 }' /etc/passwd`
- **See currently logged-in users:** To see who is active on the system right now, use the [who command](https://www.tecmint.com/check-user-in-linux/):  
  `who`


### Summary Table of Commands

| Requirement                        | Command                                   |
| ---------------------------------- | ----------------------------------------- |
| **All accounts (local)**           | `cat /etc/passwd`                         |
| **All accounts (local + network)** | `getent passwd`                           |
| **Usernames only**                 | `compgen -u` or `cut -d: -f1 /etc/passwd` |
| **Currently active users**         | `w` or `who`                              |
| **Detailed login history**         | `lastlog`                                 |


# Fail2ban

🔹 Install Fail2Ban
-------------------

dnf install fail2ban -y  
systemctl enable fail2ban --now

🛡️ Useful Fail2Ban Commands

| Goal                     | Command                                               |
| ------------------------ | ----------------------------------------------------- |
| **Check overall status** | `fail2ban-client status`                              |
| **Check Banned IPs**     | `sudo fail2ban-client status sshd`                    |
| **Unban an IP**          | `sudo fail2ban-client set sshd unbanip [IP_ADDR ESS]` |
| **View logs**            | `sudo tail -f /var/log/fail2ban.log`                  |

* * *

To check for brute-force attacks on AlmaLinux, monitor `/var/log/secure` or use [journalctl -u sshd](https://www.google.com/search?q=journalctl+-u+sshd&rlz=1C1FKPE_enZA1100ZA1100&oq=almalinux+check+bruteforce+attacks&gs_lcrp=EgZjaHJvbWUyBggAEEUYOdIBCDg1NjdqMGo3qAIAsAIA&sourceid=chrome&ie=UTF-8&mstk=AUtExfDNc8orOLxNRPHmUc1Eiw7S6sHxnwgg2bJKjIBQEtnB5WaK45TPfUeNcQY1bSLHx6VpNi5K5VBgQ_O9NUZl7OR65nB3V2BH0N-Jg4KVOxbvwX9eWorJ8c6qe0sQdlN-wVbiFBcoNAYDhwsopBOXiXrHJp1INgcK3PhWL5ntkTXixUK892X9vQP5MWKC2MokVJHVeQ1gxzAcna9yak5_sOvh4pTLAXcwuji4YA8n1jPli1PBS0ksOks2Ibre6EGAEa0nTt8obSJm-olpqmf0rQwxoW5akF51E8SzG9QQVb6Ki_VuaLjX6yQFTGk6zatqgdYdr2mYzFHOJzT7yBFWYwXrLfS8UkUYqDbe9l9HamKx-q49uuTT3mPRXG7SfLuEzlmXbftG7HQMKvXepAM8Iw&csui=3&ved=2ahUKEwi51tTS9v-TAxU09LsIHTBXHR8QgK4QegQIARAB) to identify high volumes of failed login attempts.
