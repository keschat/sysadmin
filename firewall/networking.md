## NetworkManager

To restart the connection manager (NetworkManager) in AlmaLinux, 
use `sudo systemctl restart NetworkManager`. 
Alternatively, toggle networking off and on with `nmcli networking off && nmcli networking on`. 
For specific interfaces, use `sudo nmcli connection down <interface>` followed by `sudo nmcli connection up <interface>`.

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
  

## almalinux force ip4

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
