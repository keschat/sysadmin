## Hosts

```
hostnamectl 
```

Change it in / etc/hostname and /etc/hosts. Then restart NetworkManager or reboot.

To change or set the hostname in AlmaLinux 9, you can use the hostnamectl command. Open a terminal and run the following command:
```
sudo hostnamectl set-hostname your-new-hostname
```
Replace your-new-hostname with the desired hostname. To apply the changes immediately, you might need to restart network services using:
```bash
sudo systemctl restart systemd-hostnamed
```

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
  

## Almalinux force ip4

AI Overview
****

To force AlmaLinux to use IPv4 over IPv6, you can configure NetworkManager to ignore IPv6, disable IPv6 entirely at the kernel level, or force tools like DNF/YUM to resolve using IPv4 only. 

Here are the most common methods to achieve this:

1. ### Force IPv4 via NetworkManager (`nmcli`)

This method changes the configuration of a specific network interface to prefer IPv4. [](https://dev.to/joshalmasin88/set-static-ipv4-on-almalinux-5dj8#:~:text=Step%201:%20Identify%20Your%20Network,sudo%20nmcli%20connection%20up)

1. **Identify the connection name:**
```bash
nmcli connection show
```
2. **Disable IPv6 for that connection:**
```bash
sudo nmcli connection modify <connection_name> ipv6.method "disabled"
```
3. **Ensure IPv4 is set to manual or auto (DHCP):**
```bash
sudo nmcli connection modify <connection_name> ipv4.method "auto" # or "manual"
```
4. **Restart the connection:**
```bash
sudo nmcli connection down <connection_name> && sudo nmcli connection up <connection_name>
```
5. **Disable IPv6 at Kernel Level (Permanent)**
To ensure IPv6 is not loaded, you can add kernel parameters. [](https://techdocs.broadcom.com/us/en/ca-enterprise-software/it-operations-management/network-flow-analysis/23-3/installing/system-recommendations-and-requirements/linux-servers/disable-ipv6-networking-on-linux-servers.html)

1. **Edit `/etc/sysctl.conf` or create a new file in `/etc/sysctl.d/`:**
```bash
sudo vi /etc/sysctl.d/99-disable-ipv6.conf
```
2. **Add the following lines:**
```text
net.ipv6.conf.all.disable_ipv6 = 1net.ipv6.conf.default.disable_ipv6 = 1
```
3. **Apply the changes:**
```bash
sudo sysctl -p
```
4. **Force DNF/YUM to use IPv4**
If you only need to ensure package updates and downloads use IPv4: [](https://support.cpanel.net/hc/en-us/articles/7021847859095-How-to-force-YUM-DNF-to-use-IPv4#:~:text=Introduction,and%20close%20the%20text%20editor.)

a. **Edit the DNF configuration file:**
```bash
sudo vi /etc/dnf/dnf.conf
```
b. **Add the following line to the `[main]` section:**
```text
ip_resolve=4
```
c. **Interactive Configuration (`nmtui`)**
You can use the NetworkManager text user interface to set this up graphically: [](https://blog.evoluso.com/configuring-a-static-ipv4-address-in-almalinux-9/)
- Run `sudo nmtui`.
- Select **Edit a connection**.
- Select your connection, press Enter.
- Navigate to **IPv6 CONFIGURATION**, change it to **Ignore**.
- Save and quit. 
   
#### Verification
To verify that IPv6 is disabled, use `ip a` to check for inet6 addresses, or try to ping a domain that has both A and AAAA records (like google.com) and verify it only uses IPv4. [](https://blog.evoluso.com/configuring-a-static-ipv4-address-in-almalinux-9/)

# centos how to see dns

****

To see the DNS servers your CentOS system is currently using, you can use several methods depending on your version and environment.



1. #### The Classic Method (Works Everywhere)

The most direct way to see your configured name servers is by checking the `resolv.conf` file. 

```bash
cat /etc/resolv.conf
```

* **What to look for**: Lines starting with `nameserver` (e.g., `nameserver 8.8.8.8`).
* **Note**: If you see `127.0.0.1` or `127.0.0.53`, your system is using a local caching service (like `systemd-resolved` or `dnsmasq`).
2. #### Using Network Manager (`nmcli`)

CentOS 7 and 8/9 Stream heavily rely on NetworkManager. This command shows the DNS servers assigned to your active network interfaces. 

```bash
nmcli dev show | grep DNS
```

* **Alternative for a specific connection**:

```bash
nmcli connection show <connection_name> | grep dns
```

(Replace `<connection_name>` with your actual connection name, which you can find using `nmcli con show`).



3. #### Using `resolvectl` (CentOS 8/9 Stream)

For newer CentOS versions using `systemd-resolved`, this command provides a clean status of active DNS settings.

```bash
resolvectl status
```

* This will list the "Current DNS Server" and backup "DNS Servers" for each interface.
4. #### Testing with `dig` or `nslookup`

You can verify which server is answering your queries by performing a live lookup. 



* **Using `dig`**:
  
  ```bash
  dig google.com
  ```
  
  Look at the **SERVER** line at the bottom of the output (e.g., `;; SERVER: 192.168.1.1#53`).
  
  

* **Using `nslookup`**:
  
  ```bash
  nslookup google.com
  ```
  
  The "Server" line at the top indicates which DNS server responded.
  
  

In the context of your CentOS network settings, **nameserver** and **DNS server** refer to the same thing: the IP address of the server your computer asks to turn a domain name (like `google.com`) into an IP address. 



However, the terms are used slightly differently depending on where you see them:



1. #### In Configuration Files (The Label)

Inside Linux configuration files like `/etc/resolv.conf`, **`nameserver`** is the specific keyword required by the system to define a DNS server. 



* **Example entry:** `nameserver 8.8.8.8`

* In this context, it literally means "This is the IP of a DNS server to use". 
2. #### General Networking (The Role)

While often used interchangeably, "Name Server" can technically be a broader term: 



* **DNS Server**: Specifically refers to a server using the **Domain Name System** protocol.
* **Name Server**: Can refer to any service that translates names to addresses. For example, in very old Windows networking, a "WINS server" was a type of name server but not a DNS server. 
3. #### Website Management (The Authority)

If you are managing a website, "Nameservers" (often seen as `ns1.example.com`) refers to the **authoritative** servers that hold the master records for your specific domain. 





***
