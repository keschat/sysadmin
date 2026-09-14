## Fail2ban

### 🔹 Install Fail2Ban

```bash
dnf install fail2ban -y  
systemctl enable fail2ban --now
```

🛡️ Useful Fail2Ban Commands

| Goal                     | Command                                               |
| ------------------------ | ----------------------------------------------------- |
| **Check overall status** | `fail2ban-client status`                              |
| **Check Banned IPs**     | `sudo fail2ban-client status sshd`                    |
| **Unban an IP**          | `sudo fail2ban-client set sshd unbanip [IP_ADDR ESS]` |
| **View logs**            | `sudo tail -f /var/log/fail2ban.log`                  |

* * *

To check for brute-force attacks on AlmaLinux, monitor `/var/log/secure` or use [journalctl -u sshd](https://www.google.com/search?q=journalctl+-u+sshd&rlz=1C1FKPE_enZA1100ZA1100&oq=almalinux+check+bruteforce+attacks&gs_lcrp=EgZjaHJvbWUyBggAEEUYOdIBCDg1NjdqMGo3qAIAsAIA&sourceid=chrome&ie=UTF-8&mstk=AUtExfDNc8orOLxNRPHmUc1Eiw7S6sHxnwgg2bJKjIBQEtnB5WaK45TPfUeNcQY1bSLHx6VpNi5K5VBgQ_O9NUZl7OR65nB3V2BH0N-Jg4KVOxbvwX9eWorJ8c6qe0sQdlN-wVbiFBcoNAYDhwsopBOXiXrHJp1INgcK3PhWL5ntkTXixUK892X9vQP5MWKC2MokVJHVeQ1gxzAcna9yak5_sOvh4pTLAXcwuji4YA8n1jPli1PBS0ksOks2Ibre6EGAEa0nTt8obSJm-olpqmf0rQwxoW5akF51E8SzG9QQVb6Ki_VuaLjX6yQFTGk6zatqgdYdr2mYzFHOJzT7yBFWYwXrLfS8UkUYqDbe9l9HamKx-q49uuTT3mPRXG7SfLuEzlmXbftG7HQMKvXepAM8Iw&csui=3&ved=2ahUKEwi51tTS9v-TAxU09LsIHTBXHR8QgK4QegQIARAB) to identify high volumes of failed login attempts. Use [grep "Failed password" /var/log/secure](https://www.google.com/search?q=grep+%22Failed+password%22+%2Fvar%2Flog%2Fsecure&rlz=1C1FKPE_enZA1100ZA1100&oq=almalinux+check+bruteforce+attacks&gs_lcrp=EgZjaHJvbWUyBggAEEUYOdIBCDg1NjdqMGo3qAIAsAIA&sourceid=chrome&ie=UTF-8&mstk=AUtExfDNc8orOLxNRPHmUc1Eiw7S6sHxnwgg2bJKjIBQEtnB5WaK45TPfUeNcQY1bSLHx6VpNi5K5VBgQ_O9NUZl7OR65nB3V2BH0N-Jg4KVOxbvwX9eWorJ8c6qe0sQdlN-wVbiFBcoNAYDhwsopBOXiXrHJp1INgcK3PhWL5ntkTXixUK892X9vQP5MWKC2MokVJHVeQ1gxzAcna9yak5_sOvh4pTLAXcwuji4YA8n1jPli1PBS0ksOks2Ibre6EGAEa0nTt8obSJm-olpqmf0rQwxoW5akF51E8SzG9QQVb6Ki_VuaLjX6yQFTGk6zatqgdYdr2mYzFHOJzT7yBFWYwXrLfS8UkUYqDbe9l9HamKx-q49uuTT3mPRXG7SfLuEzlmXbftG7HQMKvXepAM8Iw&csui=3&ved=2ahUKEwi51tTS9v-TAxU09LsIHTBXHR8QgK4QegQIARAC) to list failed attempts and [lastb](https://www.google.com/search?q=lastb&rlz=1C1FKPE_enZA1100ZA1100&oq=almalinux+check+bruteforce+attacks&gs_lcrp=EgZjaHJvbWUyBggAEEUYOdIBCDg1NjdqMGo3qAIAsAIA&sourceid=chrome&ie=UTF-8&mstk=AUtExfDNc8orOLxNRPHmUc1Eiw7S6sHxnwgg2bJKjIBQEtnB5WaK45TPfUeNcQY1bSLHx6VpNi5K5VBgQ_O9NUZl7OR65nB3V2BH0N-Jg4KVOxbvwX9eWorJ8c6qe0sQdlN-wVbiFBcoNAYDhwsopBOXiXrHJp1INgcK3PhWL5ntkTXixUK892X9vQP5MWKC2MokVJHVeQ1gxzAcna9yak5_sOvh4pTLAXcwuji4YA8n1jPli1PBS0ksOks2Ibre6EGAEa0nTt8obSJm-olpqmf0rQwxoW5akF51E8SzG9QQVb6Ki_VuaLjX6yQFTGk6zatqgdYdr2mYzFHOJzT7yBFWYwXrLfS8UkUYqDbe9l9HamKx-q49uuTT3mPRXG7SfLuEzlmXbftG7HQMKvXepAM8Iw&csui=3&ved=2ahUKEwi51tTS9v-TAxU09LsIHTBXHR8QgK4QegQIARAD) to see bad login attempts.

[](https://serverfault.com/questions/479912/how-to-identify-respond-to-bruteforce-attacks#:~:text=Another%20approach%20is%20to%20use%20fail2ban%20%2D,addresses%20and%20comes%20with%20pre%2Dconfigured%20attack%20detection.)

1. ### Identify Attacks via Logs

AlmaLinux, like other RHEL-based systems, logs authentication attempts in `/var/log/secure`. 

* **View Failed SSH Attempts:**
  
  ```bash
  grep "Failed password" /var/log/secure
  ```

* **Count Failed Attempts by IP:**
  
  ```bash
  grep "Failed password" /var/log/secure | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr
  ```

* **Check `journalctl` for SSH:**
  
  ```bash
  journalctl -u sshd | grep "Failed password"
  ```

* **View Recent Bad Logins:**
  
  ```bash
  lastb
  ```
2. ### Identify Successful Attacks

A successful attack is usually characterized by many failures followed by a single successful login from the same IP. [](https://www.youtube.com/watch?v=MzSKq02QvxE&t=257)

* **Check Successful Logins:**
  
  ```bash
  grep "Accepted" /var/log/secure
  ```
3. ### Automated Prevention with Fail2Ban

`fail2ban` scans logs and bans IPs with too many failed attempts. [](https://serverfault.com/questions/479912/how-to-identify-respond-to-bruteforce-attacks#:~:text=Another%20approach%20is%20to%20use%20fail2ban%20%2D,addresses%20and%20comes%20with%20pre%2Dconfigured%20attack%20detection.)

* **Install Fail2Ban:**
  
  ```bash
  sudo dnf install epel-release -ysudo dnf install fail2ban -y
  ```

* **Enable and Start:**
  
  ```bash
  sudo systemctl enable --now fail2ban
  ```

* **Check Status:**
  
  ```bash
  sudo fail2ban-client status sshd
  ```
4. ### Hardening Against Future Attacks
* **Change SSH Port:** Edit `/etc/ssh/sshd_config` to change the default Port 22 to a random high port.

* **Disable Root Login:** Set `PermitRootLogin no` in `/etc/ssh/sshd_config`.

* **Use SSH Keys:** Disable password authentication entirely by setting `PasswordAuthentication no`.

* **Firewall:** Use `firewalld` to restrict access to the SSH port. [](https://tuxcare.com/blog/secure-almalinux/)
  
  

To see currently banned IP addresses in Fail2ban, run `sudo fail2ban-client status <jail-name>` for a specific jail. [[1](https://serverfault.com/questions/841183/how-to-show-all-banned-ip-with-fail2ban), [2](https://sive.host/index.php/knowledgebase/343/Fail2ban-client-show-banned-IPs.html)]

View Banned IPs by Jail

To see the list of active jails and check who is blocked, use these commands:

* List all active jails:  
  `sudo fail2ban-client status`

* See currently banned IPs for a specific jail (like `sshd`):  
  `sudo fail2ban-client status sshd` [[1](https://serverfault.com/questions/841183/how-to-show-all-banned-ip-with-fail2ban), [2](https://docs.strangebee.com/thehive/how-to/fail2ban/), [3](https://sive.host/index.php/knowledgebase/343/Fail2ban-client-show-banned-IPs.html)]
