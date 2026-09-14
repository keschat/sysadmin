## CSF

****

To check if CSF (Config Server Firewall) is running on AlmaLinux, use the command `sudo csf -e` or `systemctl status csf`. <br>
If running properly, `csf -e` will confirm it's enabled and not disabled, while `systemctl` will show an `active (exited)` or `active (running)` status. <br>
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

### Methods to Check CSF Status

* **Check CSF/LFD Status:** Use the command to verify if both the firewall and login detection daemon are running:
```bash
sudo systemctl status csf
sudo systemctl status lfd
```
* **Verify with CSF Command:**
```bash
sudo csf -v  # Checks version and if it is active
sudo csf -e  # Ensures CSF is enabled and not in disable mode [5]
```
* **Check `iptables` Rules:** You can verify if active `iptables` rules are loaded by CSF:
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
