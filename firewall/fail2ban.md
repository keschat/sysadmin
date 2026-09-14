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

* * *

===================================



To restart the connection manager (NetworkManager) in AlmaLinux, use `sudo systemctl restart NetworkManager`. Alternatively, toggle networking off and on with `nmcli networking off && nmcli networking on`. For specific interfaces, use `sudo nmcli connection down <interface>` followed by `sudo nmcli connection up <interface>`.



Common Methods to Restart Network in AlmaLinux

* **Restart NetworkManager Service (Recommended):**
  
  ```bash
  sudo systemctl restart NetworkManager
  ```
  
  This restarts the main service managing network connections.
  
  

* **Toggle Networking (CLI):**
  
  ```bash
  sudo nmcli networking off
  sudo nmcli networking on
  ```
  
  This simulates pulling the network cable, refreshing all connections.
  
  

* **Restart a Specific Connection:**  
  First, identify the connection name:
  
  ```bash
  nmcli connection show
  ```
  
  Then restart it:
  
  ```bash
  sudo nmcli connection down <connection_name>
  sudo nmcli connection up <connection_name>
  ```

* **Reload Connection Configuration:**  
  If you modified configuration files, apply them without dropping connections:
  
  ```bash
  sudo nmcli connection reload
  ```

* **Terminal User Interface (nmtui):**  
  Type `nmtui` in the terminal to open a graphical text interface to deactivate/activate connections.
  
  
  
  

# almalinux force ip4

AI Overview

****

To force AlmaLinux to use IPv4 over IPv6, you can configure NetworkManager to ignore IPv6, disable IPv6 entirely at the kernel level, or force tools like DNF/YUM to resolve using IPv4 only. 

Here are the most common methods to achieve this:

1. ### Force IPv4 via NetworkManager (`nmcli`)

This method changes the configuration of a specific network interface to prefer IPv4. [](https://dev.to/joshalmasin88/set-static-ipv4-on-almalinux-5dj8#:~:text=Step%201:%20Identify%20Your%20Network,sudo%20nmcli%20connection%20up)

1. **Identify the connection name:**
   bash
      nmcli connection show

2. **Disable IPv6 for that connection:**
   bash
      sudo nmcli connection modify <connection_name> ipv6.method "disabled"

3. **Ensure IPv4 is set to manual or auto (DHCP):**
   bash
      sudo nmcli connection modify <connection_name> ipv4.method "auto" # or "manual"

4. **Restart the connection:**
   bash
      sudo nmcli connection down <connection_name> && sudo nmcli connection up <connection_name>
    

5. ### Disable IPv6 at Kernel Level (Permanent)

To ensure IPv6 is not loaded, you can add kernel parameters. [](https://techdocs.broadcom.com/us/en/ca-enterprise-software/it-operations-management/network-flow-analysis/23-3/installing/system-recommendations-and-requirements/linux-servers/disable-ipv6-networking-on-linux-servers.html)

1. **Edit `/etc/sysctl.conf` or create a new file in `/etc/sysctl.d/`:**
   bash
      sudo vi /etc/sysctl.d/99-disable-ipv6.conf

2. **Add the following lines:**
   text
      net.ipv6.conf.all.disable_ipv6 = 1net.ipv6.conf.default.disable_ipv6 = 1

3. **Apply the changes:**
   bash
      sudo sysctl -p
    

4. ### Force DNF/YUM to use IPv4

If you only need to ensure package updates and downloads use IPv4: [](https://support.cpanel.net/hc/en-us/articles/7021847859095-How-to-force-YUM-DNF-to-use-IPv4#:~:text=Introduction,and%20close%20the%20text%20editor.)

1. **Edit the DNF configuration file:**
   bash
      sudo vi /etc/dnf/dnf.conf

2. **Add the following line to the `[main]` section:**
   text
      ip_resolve=4
    

3. ### Interactive Configuration (`nmtui`)

You can use the NetworkManager text user interface to set this up graphically: [](https://blog.evoluso.com/configuring-a-static-ipv4-address-in-almalinux-9/)

1. Run `sudo nmtui`.
2. Select **Edit a connection**.
3. Select your connection, press Enter.
4. Navigate to **IPv6 CONFIGURATION**, change it to **Ignore**.
5. Save and quit. 
   
   

**Verification**

To verify that IPv6 is disabled, use `ip a` to check for inet6 addresses, or try to ping a domain that has both A and AAAA records (like google.com) and verify it only uses IPv4. [](https://blog.evoluso.com/configuring-a-static-ipv4-address-in-almalinux-9/)



****

## CSF

****

To check if CSF (Config Server Firewall) is running on AlmaLinux, use the command `sudo csf -e` or `systemctl status csf`. If running properly, `csf -e` will confirm it's enabled and not disabled, while `systemctl` will show an `active (exited)` or `active (running)` status. 

To check if CSF (ConfigServer Security & Firewall) is running on AlmaLinux, use the command `sudo csf -v` to check the version or `sudo service csf status` to check the service status. If active, the output will indicate it is running, usually with `active (exited)` or a list of iptables rules.



**Here are the primary methods to check the status of CSF:**

* **[Check via Systemd](https://www.google.com/search?q=Check+via+Systemd&rlz=1C1FKPE_enZA1100ZA1100&oq=almalinux+check+if+csf+is+running&gs_lcrp=EgZjaHJvbWUyCQgAEEUYORigATIHCAEQIRigATIHCAIQIRigATIHCAMQIRigATIHCAQQIRigATIHCAUQIRifBTIHCAYQIRiPAtIBCDc5MjJqMGo3qAIAsAIA&sourceid=chrome&ie=UTF-8&mstk=AUtExfBzAmfa37yZQDfFO6F34aPy-xdF97Xhc085IX4tN-sTMdkiREzabTzWs0Yk-gDQIUNjmxPKHYBTzIyElMkMb8HFjhRgFtKe-eRLtSlMsJ0oiZZyLjKkCTfvKl6sfRLxGnmeLKfUHSTfatSiS4PKOO-kddV8_c3aQXJ3YP9uzMvA4_SpyTMUrxWV2ecyKFCgavEZ54TQ6P_JZAJVhW9uhJLQHUZEavauRdyfepBUhv8xk4_tfzBymc7F_cjQKmOWKD_h1V8KroANiCQvNuimQBPd9PBBjl-rwy0QfoeoaoC0bMfSfVRp5SntH1eU84XtIrbSH44ug79_JxlRLXyzRgHg_VNH1vuvYmB5exw4WPhM&csui=3&ved=2ahUKEwjZ_4Km34OUAxWQU0EAHRRiFL0QgK4QegQIAxAB):**  
  `sudo systemctl status csf`
* **[Check via CSF Command](https://www.google.com/search?q=Check+via+CSF+Command&rlz=1C1FKPE_enZA1100ZA1100&oq=almalinux+check+if+csf+is+running&gs_lcrp=EgZjaHJvbWUyCQgAEEUYORigATIHCAEQIRigATIHCAIQIRigATIHCAMQIRigATIHCAQQIRigATIHCAUQIRifBTIHCAYQIRiPAtIBCDc5MjJqMGo3qAIAsAIA&sourceid=chrome&ie=UTF-8&mstk=AUtExfBzAmfa37yZQDfFO6F34aPy-xdF97Xhc085IX4tN-sTMdkiREzabTzWs0Yk-gDQIUNjmxPKHYBTzIyElMkMb8HFjhRgFtKe-eRLtSlMsJ0oiZZyLjKkCTfvKl6sfRLxGnmeLKfUHSTfatSiS4PKOO-kddV8_c3aQXJ3YP9uzMvA4_SpyTMUrxWV2ecyKFCgavEZ54TQ6P_JZAJVhW9uhJLQHUZEavauRdyfepBUhv8xk4_tfzBymc7F_cjQKmOWKD_h1V8KroANiCQvNuimQBPd9PBBjl-rwy0QfoeoaoC0bMfSfVRp5SntH1eU84XtIrbSH44ug79_JxlRLXyzRgHg_VNH1vuvYmB5exw4WPhM&csui=3&ved=2ahUKEwjZ_4Km34OUAxWQU0EAHRRiFL0QgK4QegQIAxAD):**  
  `sudo csf -v` (Displays version if active)
* **[Check via Service Command](https://www.google.com/search?q=Check+via+Service+Command&rlz=1C1FKPE_enZA1100ZA1100&oq=almalinux+check+if+csf+is+running&gs_lcrp=EgZjaHJvbWUyCQgAEEUYORigATIHCAEQIRigATIHCAIQIRigATIHCAMQIRigATIHCAQQIRigATIHCAUQIRifBTIHCAYQIRiPAtIBCDc5MjJqMGo3qAIAsAIA&sourceid=chrome&ie=UTF-8&mstk=AUtExfBzAmfa37yZQDfFO6F34aPy-xdF97Xhc085IX4tN-sTMdkiREzabTzWs0Yk-gDQIUNjmxPKHYBTzIyElMkMb8HFjhRgFtKe-eRLtSlMsJ0oiZZyLjKkCTfvKl6sfRLxGnmeLKfUHSTfatSiS4PKOO-kddV8_c3aQXJ3YP9uzMvA4_SpyTMUrxWV2ecyKFCgavEZ54TQ6P_JZAJVhW9uhJLQHUZEavauRdyfepBUhv8xk4_tfzBymc7F_cjQKmOWKD_h1V8KroANiCQvNuimQBPd9PBBjl-rwy0QfoeoaoC0bMfSfVRp5SntH1eU84XtIrbSH44ug79_JxlRLXyzRgHg_VNH1vuvYmB5exw4WPhM&csui=3&ved=2ahUKEwjZ_4Km34OUAxWQU0EAHRRiFL0QgK4QegQIAxAF):**  
  `sudo service csf status`
* **[Verify Rules are Loaded](https://www.google.com/search?q=Verify+Rules+are+Loaded&rlz=1C1FKPE_enZA1100ZA1100&oq=almalinux+check+if+csf+is+running&gs_lcrp=EgZjaHJvbWUyCQgAEEUYORigATIHCAEQIRigATIHCAIQIRigATIHCAMQIRigATIHCAQQIRigATIHCAUQIRifBTIHCAYQIRiPAtIBCDc5MjJqMGo3qAIAsAIA&sourceid=chrome&ie=UTF-8&mstk=AUtExfBzAmfa37yZQDfFO6F34aPy-xdF97Xhc085IX4tN-sTMdkiREzabTzWs0Yk-gDQIUNjmxPKHYBTzIyElMkMb8HFjhRgFtKe-eRLtSlMsJ0oiZZyLjKkCTfvKl6sfRLxGnmeLKfUHSTfatSiS4PKOO-kddV8_c3aQXJ3YP9uzMvA4_SpyTMUrxWV2ecyKFCgavEZ54TQ6P_JZAJVhW9uhJLQHUZEavauRdyfepBUhv8xk4_tfzBymc7F_cjQKmOWKD_h1V8KroANiCQvNuimQBPd9PBBjl-rwy0QfoeoaoC0bMfSfVRp5SntH1eU84XtIrbSH44ug79_JxlRLXyzRgHg_VNH1vuvYmB5exw4WPhM&csui=3&ved=2ahUKEwjZ_4Km34OUAxWQU0EAHRRiFL0QgK4QegQIAxAH):**  
  `sudo iptables -nv -L` (Lists active iptables rules managed by CSF)
* **[Check LFD Status](https://www.google.com/search?q=Check+LFD+Status&rlz=1C1FKPE_enZA1100ZA1100&oq=almalinux+check+if+csf+is+running&gs_lcrp=EgZjaHJvbWUyCQgAEEUYORigATIHCAEQIRigATIHCAIQIRigATIHCAMQIRigATIHCAQQIRigATIHCAUQIRifBTIHCAYQIRiPAtIBCDc5MjJqMGo3qAIAsAIA&sourceid=chrome&ie=UTF-8&mstk=AUtExfBzAmfa37yZQDfFO6F34aPy-xdF97Xhc085IX4tN-sTMdkiREzabTzWs0Yk-gDQIUNjmxPKHYBTzIyElMkMb8HFjhRgFtKe-eRLtSlMsJ0oiZZyLjKkCTfvKl6sfRLxGnmeLKfUHSTfatSiS4PKOO-kddV8_c3aQXJ3YP9uzMvA4_SpyTMUrxWV2ecyKFCgavEZ54TQ6P_JZAJVhW9uhJLQHUZEavauRdyfepBUhv8xk4_tfzBymc7F_cjQKmOWKD_h1V8KroANiCQvNuimQBPd9PBBjl-rwy0QfoeoaoC0bMfSfVRp5SntH1eU84XtIrbSH44ug79_JxlRLXyzRgHg_VNH1vuvYmB5exw4WPhM&csui=3&ved=2ahUKEwjZ_4Km34OUAxWQU0EAHRRiFL0QgK4QegQIAxAJ) (Login Failure Daemon):**  
  `sudo service lfd status`

#### Methods to Check CSF Status

* **Check CSF/LFD Status:** Use the command to verify if both the firewall and login detection daemon are running:
  bash
  
  ```bash
  sudo systemctl status csf
  sudo systemctl status lfd
  ```

* **Verify with CSF Command:**
  bash
  
  ```bash
  sudo csf -v  # Checks version and if it is active
  sudo csf -e  # Ensures CSF is enabled and not in disable mode [5]
  ```

* **Check `iptables` Rules:** You can verify if active `iptables` rules are loaded by CSF:
  bash
  
  ```bash
  sudo iptables -nv -L
  ```

### Managing CSF on AlmaLinux

* **Restart CSF:** `sudo csf -r`
* **Disable CSF:** `sudo csf -x`
* **Enable CSF:** `sudo csf -e` 
  
  

> **Note:** It is recommended to disable `firewalld` to avoid conflicts when using CSF on AlmaLinux.



**Important Note:** On AlmaLinux, it is crucial to ensure `firewalld` is stopped and disabled to prevent conflicts, as CSF should be the primary firewall management tool.  
`sudo systemctl stop firewalld`  
`sudo systemctl disable firewalld` 

If CSF is not running, you can start it with `sudo csf -e`.
