Almalinux see all users
####

<!--
lastb

Refs:
[[https://forums.opensuse.org/t/leap-16-lastb-command-not-found/189792/2](https://linuxcommandlibrary.com/man/lastb)](https://linuxcommandlibrary.com/man/lastb#description)

-->

lastb
same as last, but shows failed login attempts as recorded in /var/log/btmp

DESCRIPTION

lastb is the same as last, but shows failed login attempts as recorded in /var/log/btmp. It is useful for security auditing to identify brute force attacks or unauthorized access attempts.
The output shows username attempted, terminal, source address, and timestamp of each failed login.

PARAMETERS

```bash
-s, --since TIME
Display records since specified time

-t, --until TIME
Display records until specified time

-p, --present TIME
Display users who were present at specified time

-d, --dns
Translate IP addresses to hostnames

-n, --limit NUM
Limit output to NUM records

-f, --file FILE
Read from specified file instead of /var/log/btmp

-F, --fulltimes
Print full login and logout times and dates

-i, --ip
Display IP addresses instead of hostnames

-R, --nohostname
Suppress display of the hostname field

-w, --fullnames
Display full user and domain names

-x, --system
Display system shutdown entries and run level changes

--time-format FORMAT
Output timestamp format: notime, short, full, or iso


COMMANDS

List failed login attempts
$ sudo lastb

List failed logins since a date
$ sudo lastb -s [YYYY-MM-DD]

List failed logins until a date
$ sudo lastb -t [YYYY-MM-DD]

Show users who were present at a specific time
$ sudo lastb -p [YYYY-MM-DD HH:MM]

Resolve IPs to hostnames
$ sudo lastb -d

Limit output to a specific number of entries
$ sudo lastb -n [10]

Show full timestamps including year and seconds
$ sudo lastb -F

Read from a specific btmp file
$ sudo lastb -f [/var/log/btmp.1]
```

****

### AI Overview

On AlmaLinux, you can see all users through the command line or a graphical interface. Because AlmaLinux is based on RHEL, it uses standard Linux user management files and commands. 

### Using the Command Line

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

***

## UBUNTU Server

[Step 1 — Logging Into Your Server](https://www.digitalocean.com/community/tutorials/how-to-create-a-new-sudo-enabled-user-on-ubuntu#step-1-logging-into-your-server)
```bash
ssh root@your_server_ip_address
```
### Create Users

#### [#](https://www.cherryservers.com/blog/how-to-add-user-to-sudoers-in-ubuntu#step-1-create-a-regular-user-in-ubuntu "Permalink")Step 1: Create a regular User in Ubuntu
```bash
sudo adduser usernam
```
> The `adduser` command provides an interactive way for adding users to the system by prompting user details.
> When you execute the command, a series of events happen. The command creates a user called `cherry` and assigns a UID (User ID) to the user from the UID range of 1000 to 59999. It then creates a new group that corresponds to the username and adds the user to the group. This is also known as the primary group. Next, the command creates a home directory, and copies user-specific configuration files from `/etc/skel` to the home directory.

To check the groups the user belongs to, run the `groups` command followed by the username.
```bash
groups cherry
```
> From the output, you can see that the user belongs to two groups:`cherry` group which is the primary group, and `users`, the supplementary group.

#### [#](https://www.cherryservers.com/blog/how-to-add-user-to-sudoers-in-ubuntu#step-2-add-a-regular-user-to-the-sudo-group-sudoers-file "Permalink")Step 2: Add a regular user to the sudo group /sudoers file

So far, you have created a regular login user called `cherry`. However, the user is only limited to standard tasks on the system. If you run a privileged task with the `sudo` command, you will be notified that the user is not in the sudoers file, and the command will not be executed

**Adding a regular user to sudo group using `usermod` command**

The `usermod` command is a command-line tool used to modify user accounts. <br>
It modifies various user attributes including the uid, shell, and login name. You can also use it to change the user’s default group and add a user to an existing group.

To add a user to the sudo group, use the `usermod` syntax as shown below.
```bash
sudo usermod -aG sudo username
```
_Note_ The command can also take the following format where `a` and `G` options are specified separately using a hyphen.
```bash
sudo usermod -a -G sudo username
```
_Note_ The `-a` option appends the user to a secondary group while the `-G` option specifies the name of the group that the user is being added to, in this case, `sudo`.

**Adding a regular user to sudo group using `adduser` command**

The `adduser` command is typically used to create or add new users to the system. In addition, you can also use it to add an existing user to another group using the following syntax.
```bash
sudo adduser username group
```

#### [#](https://www.cherryservers.com/blog/how-to-add-user-to-sudoers-in-ubuntu#step-3-confirm-user-belongs-to-sudo-group "Permalink")Step 3: Confirm user belongs to sudo group
```bash
groups username
```
_Note_ This time around, you will see that the user belongs to three groups: the two original groups ( `cherry` and `users` ) and `sudo`.
Alternatively, you can run the `id` command followed by the username. This provides a more detailed output which includes the UID of the user, and the groups the user belongs to along with their GIDs.
```bash
id  cherry
```

#### [#](https://www.cherryservers.com/blog/how-to-add-user-to-sudoers-in-ubuntu#step-4-run-privileged-tasks-as-sudo-user "Permalink")Step 4: Run privileged tasks as sudo user

For example, to switch to user `cherry`, run the command:
```bash
su - cherry
```
Once you have switched to the sudo user for the first time, you will see a notification informing you of how to run commands as root using the `sudo` command.

When you run the `whoami` command with `sudo`, you will get `root` as the output. This indicates you can run commands as root by invoking `sudo`.
```bash
sudo whoami
```

To check users and groups on Ubuntu, you can use several terminal commands or a graphical interface. The most common and reliable methods are listed below. 

1. **Check All Users**

Ubuntu stores user information in `/etc/passwd`. You can list everyone on the system or filter for just the names. 

* **List all users with full details:**  
`getent passwd`  
This is preferred over reading files directly because it includes users from network services like LDAP.

* **List only usernames:**  
`cut -d: -f1 /etc/passwd`  
This extracts just the first column (the username) for a cleaner list.

* **List "human" users (UID 1000 and above):**  
`awk -F: '$3 >= 1000 && $3 != 65534 {print $1}' /etc/passwd`  
On Ubuntu, regular user accounts typically start at ID 1000.
  
2. **Check All Groups**

Group information is stored in `/etc/group`. 

* **List all groups with full details:**  
`getent group`

* **List only group names:**  
`getent group | cut -d: -f1`

* **See members of a specific group (e.g., sudo):**  
`getent group sudo`  
This shows you which users have administrative privileges.

3. **Check a Specific User's Groups**

If you want to know which groups a particular person belongs to:

* **Quick list of group names:**  
`groups [username]`  
Example: `groups john`.

* **Detailed ID information:**  
`id [username]`  
This shows the User ID (UID), primary group ID (GID), and all secondary groups.

4. Check Currently Logged-In Users

To see who is active right now:

* **Summary list:** `who`
* **Detailed activity:** `w` (shows what they are currently doing and their system usage).
  
5. Using the Graphical Interface (Desktop Only)

If you prefer not to use the terminal:

1. Open **Settings**.
2. Scroll down to **Users** in the sidebar.
3. For more advanced group management, you may need to install the [GNOME System Tools](https://askubuntu.com/questions/66718/how-to-manage-users-and-groups-using-gui) by running `sudo apt install gnome-system-tools`, which provides a "Users and Groups" application.

****

# Guide: Checking Users and Groups on Ubuntu

This guide covers the essential terminal commands and GUI methods for managing and auditing user accounts and groups on an Ubuntu system.

---

## 1. Checking Users
User account information is primarily stored in the `/etc/passwd` file.

### List All Usernames
To get a simple list of every user account on the system:```bashcut -d: -f1 /etc/passwd

Show Detailed User Information
------------------------------

The `getent` command is the most reliable way to view user details, as it includes both local and network-based users (if applicable):
getent passwd
Filter for "Human" Users

------------------------

By default, Ubuntu assigns UIDs (User IDs) starting at 1000 for regular users. Use this command to ignore system service accounts:
awk -F: '$3 >= 1000' /etc/passwd
Check Currently Logged-in Users

-------------------------------

To see who is active on the system right now:
    who
    # OR for more detail (idle time, JCPU, etc.)
    w

* * *

2. Checking Groups

------------------

Group data is stored in the `/etc/group` file.
List All Group Names

--------------------

To see a list of every group available on the system:
    cut -d: -f1 /etc/group
Show Detailed Group Info

------------------------

To see group IDs and the members assigned to them:
    getent group
Check Members of a Specific Group

---------------------------------

If you want to see who has administrative privileges, check the `sudo` group:
    getent group sudo

* * *

3. Checking a Specific User

---------------------------

To audit which groups a specific user belongs to, use their username:

* Simple list of group names:
  
      groups [username]

* Detailed list (UID, GID, and Names):
  
      id [username]
  
  

* * *

4. Graphical Interface (GUI)

----------------------------

For those using Ubuntu Desktop who prefer a visual management tool:

1. Open Settings.
2. Navigate to the Users tab.
3. Unlock the panel (top right) to make changes.

Advanced GUI Tool
-----------------

For more granular control over groups via a GUI, you can install the Gnome System Tools:
    sudo apt update && sudo apt install gnome-system-tools

Once installed, search for "Users and Groups" in your application launcher.
    Would you like any specific **permission settings** or **account creation** commands added to this guide?





****



To check for Nginx or OpenLiteSpeed in AlmaLinux, use `rpm -qa | grep -E "nginx|openlitespeed"` to check installed packages, and `systemctl status nginx` or `systemctl status lsws` (LiteSpeed Web Server) to check if they are running. OpenLiteSpeed uses port 7080 for its web admin dashboard. 



Checking Nginx

1. **Check if Installed:**
   
   ```bash
   rpm -qa | grep nginx
   ```

2. **Check Service Status:**
   
   ```bash
   systemctl status nginx
   ```

3. **Check Version:**
   
   ```bash
   nginx -v
   ```

## Checking OpenLiteSpeed

1. **Check if Installed:**
   
   ```bash
   rpm -qa | grep openlitespeed
   ```

2. **Check Service Status (Note: lsws, not openlitespeed):**
   
   ```bash
   systemctl status lsws
   ```

3. **Check Version:**
   
   ```bash
     /usr/local/lsws/bin/openlitespeed -v
   ```

Checking Running Web Server

* **List listening ports** to see which server is occupying port 80/443:
  bash
  
      sudo ss -tulpn | grep -E ':80|:443'
  
   

Potential Conflicts

Note that OpenLiteSpeed and Nginx cannot run simultaneously on the same ports. If you are replacing one with the other, ensure the service for the old server is completely stopped and disabled: 

```bash
sudo systemctl stop nginx
sudo systemctl disable nginx 
# OR 
sudo systemctl stop lsws
sudo systemctl disable lsws
```



****

# rpm: check available package to install

****

To check available and installed packages on RPM-based systems (like RHEL, Fedora, CentOS, or openSUSE), 

you can use the **`rpm`** command for local queries or higher-level tools like **`dnf`** or **`yum`** for repository searches. 



1. ### Check if a Package is Already Installed

Use the `rpm` command to query the local database: 

* **Check a specific package:** `rpm -q <package_name>`

* **List all installed packages:** `rpm -qa`

* **Search for a package in the installed list:** `rpm -qa | grep <keyword>`

* **Get detailed info on an installed package:** `rpm -qi <package_name>
2. ### Search for Available Packages (Not Yet Installed)

The `rpm` command itself generally cannot search remote repositories. Instead, use your system's package manager: 

* **Using DNF (Modern RHEL/Fedora):** `dnf list available` or `dnf search <keyword>`

* **Using YUM (Older CentOS/RHEL):** `yum list available` or `yum search <keyword>`

* **Show all versions available:** `dnf list <package_name> --showduplicates` 
3. ### Check an Uninstalled `.rpm` File

If you have a downloaded `.rpm` file and want to see its contents or info before installing:

* **View package info:** `rpm -qip <package_file.rpm>`

* **List files inside the package:** `rpm -qpl <package_file.rpm>`

* **Check dependencies:** `rpm -qpR <package_file.rpm>` 
4. ### Comparison Summary

| Task                          | Command                |
| ----------------------------- | ---------------------- |
| **Check if installed**        | `rpm -q <package>`     |
| **List all installed**        | `rpm -qa`              |
| **Search available (online)** | `dnf search <keyword>` |
| **Check local file info**     | `rpm -qip <file.rpm>`  |
| **List local file contents**  | `rpm -qpl <file.rpm>`  |



****

****



AI Overview

To check RAM and CPU information in AlmaLinux, use the following command-line tools:

Check RAM

* **`free -h`**: This is the most common command for a quick summary. The `-h` flag provides [human-readable output](https://www.youtube.com/watch?v=IOEXHA1IlNc) (e.g., GB instead of KB).
* **`cat /proc/meminfo`**: Use this to view [detailed kernel-level memory statistics](https://www.cyberciti.biz/faq/linux-check-memory-usage/), including total, free, and cached RAM.
* **`sudo dmidecode -t memory`**: For hardware-specific details like RAM speed, type, and slots used, use this command (requires root privileges). 
  
  

Check Number of CPUs

* **`lscpu`**: Provides a comprehensive [overview of CPU architecture](https://techpiezo.com/almalinux/get-cpu-information-in-almalinux-ubuntu/), including total CPUs, cores per socket, and threads per core.
* **`nproc`**: Displays only the [total number of available processing units](https://www.geeksforgeeks.org/linux-unix/how-to-check-how-many-cpus-are-there-in-linux-system/).
* **`cat /proc/cpuinfo`**: View the full [low-level processor configuration](https://linuxconfig.org/how-to-obtain-cpu-information-on-linux). To quickly count the cores, use: `grep -c ^processor /proc/cpuinfo`. 
  
  

Real-Time Monitoring 

* **`top`** or **`htop`**: These tools provide an [interactive view of both RAM and CPU usage](https://www.networkworld.com/article/968314/showing-memory-usage-in-linux-by-process-and-user.html). `htop` is generally preferred for its more readable, color-coded display, though it may require installation via `dnf install htop`. 
  
  

****

****

AI Overview

To count lines with `grep`, you can use the built-in `-c` flag or pipe the output to the `wc` utility. 

* **Count lines matching a pattern:** Use the `-c` or `--count` option to print only the number of lines containing the match.
  bash
  
      grep -c "pattern" filename

* **Count total lines in a file:** Use a Regular Expression to match the start (`^`) or end (`$`) of every line.
  bash
  
      grep -c "^" filename

* **Count lines using a pipe:** For more complex filtering, pipe the results to wc -l to count the number of lines returned.
  bash
  
      grep "pattern" filename | wc -l

* **Count all individual occurrences:** Note that `grep -c` only counts _lines_ with a match. To count every instance (even if multiple matches appear on one line), use the `-o` flag to output each match on its own line and then pipe to `wc -l`.
  bash
  
      grep -o "pattern" filename | wc -l

* **Count non-matching lines:** Use the `-v` flag to invert the search and count lines that do _not_ contain the pattern.
  bash
  
      grep -vc "pattern" filename
  
  

****

****

## To set up local SSL on Ubuntu, you can either generate a quick **self-signed certificate** using OpenSSL or use **mkcert** to create locally-trusted certificates that won't trigger browser warnings.



#### Method 1: Using mkcert (Recommended for Devs)

[mkcert](https://github.com/FiloSottile/mkcert) creates a local Certificate Authority (CA) on your machine, making your browser trust local certificates [12, 22]. 

1. **Install mkcert:**
   bash
      sudo apt updatesudo apt install libnss3-toolscurl -JLO "https://filippo.io"
      chmod +x mkcert-v*-linux-amd64sudo mv mkcert-v*-linux-amd64 /usr/local/bin/mkcert

2. **Install Local CA:** Run `mkcert -install` to add the local CA to your system's trust stores [12].

3. **Generate Certificate:** Create a certificate for your local domain (e.g., `localhost` or `myapp.local`):
   
   ```bash
   mkcert localhost myapp.local
   ```
   
   This generates two files: `localhost+1.pem` (certificate) and `localhost+1-key.pem` (private key) [22]. 
   
   

#### Method 2: Using OpenSSL (Standard Self-Signed)

This method is standard but will cause a "Your connection is not private" warning in browsers, which you must manually bypass [10, 20]. 

1. **Generate Certificate & Key:**
   
   ```bash
   sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
   -keyout /etc/ssl/private/apache-selfsigned.key \
   -out /etc/ssl/certs/apache-selfsigned.crt
   ```
* **Common Name (CN):** When prompted, enter your local domain name or `localhost` [9, 10].
2. **Enable SSL in Apache:**
* Enable the module: `sudo a2enmod ssl` [11, 15].
* Configure the virtual host: Edit `/etc/apache2/sites-available/default-ssl.conf` to point `SSLCertificateFile` and `SSLCertificateKeyFile` to the paths above [17, 25].
* Enable the site: `sudo a2ensite default-ssl.conf` [9, 34].
* Restart: `sudo systemctl restart apache2` [10, 11]. 
  
  

**Method 3: Quick "Snakeoil" SSL (Apache Only)**

Ubuntu comes with a pre-installed ssl-cert package that provides a default self-signed "snakeoil" certificate [5.7, 34]. 

1. **Enable SSL Module:** `sudo a2enmod ssl`
2. **Enable Default SSL Site:** `sudo a2ensite default-ssl`
3. **Restart Apache:** `sudo systemctl restart apache2`
4. **Access:** Your server will now be accessible at `https://localhost` using the built-in snakeoil keys [34]. 
   
   

**Summary Table**

| Feature          | mkcert                       | OpenSSL                       |
| ---------------- | ---------------------------- | ----------------------------- |
| **Trust Status** | Locally Trusted (Green Lock) | Untrusted (Warning Page)      |
| **Setup Speed**  | Medium                       | Fast                          |
| **Use Case**     | Active Local Development     | Quick testing / Single server |
| **Difficulty**   | Requires installation        | Built-in                      |



****

****



To show firewall rules on AlmaLinux, the primary command is `sudo firewall-cmd --list-all`, which displays active zones, services, ports, and rich rules. AlmaLinux uses `firewalld` by default, managed via `firewall-cmd`. To verify if the firewall is active, use `systemctl status firewalld`.

Essential Firewall Commands (`firewalld`)

* **List all active rules:** `sudo firewall-cmd --list-all`.
* **List rules for a specific zone:** `sudo firewall-cmd --zone=public --list-all`.
* **List allowed services:** `sudo firewall-cmd --list-services`.
* **List allowed ports:** `sudo firewall-cmd --list-ports`.
* **Show active zones:** `sudo firewall-cmd --get-active-zones`.
* **List rich rules:** `sudo firewall-cmd --list-rich-rules`.
  
  

Other Useful Commands

* **Check firewall status:** `systemctl status firewalld`.
* **List iptables rules (raw format):** `sudo iptables -L -v -n`. ![Bobcares](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAADEElEQVQ4jX2TT2gUZxjGn2/2W2eT2U0mmdXu2iSaf3YbEhvUQhRLaaFHD3oxiIdSaNC2eBCpeqkEbWnTGqQEMSl48SKCop4a2lqNGLVUELHNZpPoRrPJJrvZ7M7fnZ355uspAylNn/P7/nhenvchnHMCAOTCTVnSjAbDm07yM2fc9sHr3dOTy88h0xD/7hMd64j4gP67tF3SxkTmdmbUQu+7rW0fP5yafMQYDxOwEX3gs+z/AgAg0n9lU6cSz5q5jBuJbU4m0y+idbIyr5eNP8z8Qkp164f4cJ+7BvDOyOi+asa/McpOAyCkOMf2hnA4VHEcrGglbHlzM2YXFzE58fRPElF+dg31QybgmcMDp/jwSdV3UHvsfK+ovDHYtjEeEzwOZmhobmzEgmrAtm3otomX82lIYlWZed5Xue+P/gAAwqqV9/fuKXc1xovLRsHUnQpM7uHV4hKCQgBWpQwxKCIqR2HZdkgrLg/QT7/uBQC6Cng8dv+AEnCKv3/Rk7idKuFxxkKYVqCIKi7O6tAtC0Ipj/DSLCTXhhpt6ib9/dd8wNTn7fLVX2Z6snmKbcEqxMM5fPReArrN0B0PYW5Fx/CNv1As67BqoqCOfSIyxQv+CQKtampva4MgSiCUoqVrN8afTOC38Rfw8gZqs7O4e2QHQrWy64Qkj1FxjNHQrz4gINWktWIGtq6iWgrj1csZTE7nkOjcgfpNMby96wM8eDqNvdubTDckAeA3qFWK+SkYM6NJArJN1UxklgqISwGIch2evBawpbkV6VQSz+9dh1Jf48qtLUP77zvn+NDpgg/Q/741TwQh5n+I58HjHrgQQGomg8aYDKblkUml4HpE3X30R3lNCl5FuwMSPFSxLLgcICCglCK7mIUSDCIsUph2FUBIpS4WP7y65wNqNohHiobWQQK8OwgCTdXgWDY2RqpBBQ5nOYNSfkUNmsrWxP7Txf/sAgCUHv50gnH3W3AugHsgjAGuA1XV9XKFffnWwbOX1i3Tqgpjgw2CFzhOOOsASNG2yndez6Uv7+wbdv89+w+XlINsYDkhDwAAAABJRU5ErkJggg==)Bobcares +2

If you are using a specific zone other than public, replace `public` in the commands above with the relevant zone name (e.g., `work`, `home`, `trusted`). 



****



To resize an ext2/ext3/ext4 filesystem on AlmaLinux using `resize2fs`, first extend the underlying partition or Logical Volume (LVM), then run `sudo resize2fs /dev/device_name` to expand the filesystem to fill the new space. For XFS filesystems (default in AlmaLinux), use `xfs_growfs` instead. 



#### **Steps to Resize an Ext4 Partition in AlmaLinux:**

1. **Identify the Filesystem:** Run `df -hT` to check if your filesystem is ext4 or XFS.
2. **Extend Partition/LVM:** If using LVM, use `lvextend` to increase the logical volume size first.
3. **Resize Filesystem (`resize2fs`):**
   * To expand the filesystem to the maximum available space:  
     `sudo resize2fs /dev/mapper/almalinux-root` (replace with your logical volume path).
   * Alternatively, for a standard partition:  
     `sudo resize2fs /dev/sda1`. 

#### **Important Notes:**

* **XFS Warning:** If `df -hT` shows `xfs`, you must use `xfs_growfs /mount/point` instead of `resize2fs`.
* `resize2fs` can typically be run on a mounted (live) filesystem.
* If you resized the physical disk, you may need to run `partprobe` to inform the kernel of partition changes before running `resize2fs`.
  
  

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



To create a swap partition on AlmaLinux, you must first create a dedicated disk partition, format it as a swap area, and then enable it in the system configuration for persistence. 



**Step 1: Create a New Partition**

1. Identify the disk you want to use (e.g., `/dev/sdb`) by running `lsblk` or `sudo fdisk -l`.

2. Open the disk utility for that drive:
   
   ```bash
   sudo fdisk /dev/sdb
   ```

3. Follow these prompts within `fdisk` to create the partition:
   
   * Type **`n`** for a new partition.
   * Select a partition type and number (usually default).
   * Specify the size (e.g., **`+2G`** for 2GB).
   * Type **`t`** to change the partition type.
   * Enter **`82`** (the hexadecimal code for "Linux swap").
   * Type **`w`** to write changes and exit. 
     
     

**Step 2: Initialize the Swap Partition**

Format the newly created partition (e.g., `/dev/sdb1`) as a swap area using the mkswap utility: 

```bash
sudo mkswap /dev/sdb1
```



**Step 3: Enable the Swap Space** 

Activate the swap partition immediately using the swapon command: 

```bash
sudo swapon /dev/sdb1
```

To verify it is active, use `swapon --show` or `free -h`. 



**Step 4: Make the Swap Permanent** 

To ensure the swap partition is mounted automatically after a reboot, you must add it to the `/etc/fstab` file.

1. Open the file with a text editor: `sudo vi /etc/fstab`

2. Add the following line at the end:
   
   ```textile
   /dev/sdb1 none swap sw 0 0
   ```
   
   _Note: Using the partition's **UUID** instead of `/dev/sdb1` is safer as device names can change. You can find the UUID by running `blkid /dev/sdb1`._ 
   
   

**Optional: Adjust Swappiness** 

You can control how aggressively the kernel uses swap by adjusting the "swappiness" value. 

* **Check current value:** `cat /proc/sys/vm/swappiness` (Default is usually 60).
* **Temporary change:** `sudo sysctl vm.swappiness=10`.
* **Permanent change:** Add `vm.swappiness=10` to `/etc/sysctl.conf` and run `sudo sysctl -p`. 
  
  

****



## Ubuntu check hostname

#### Using the Terminal

* **`hostname`**: Displays the current system hostname.
* **`hostnamectl`**: Provides a detailed summary including the "Static hostname," operating system, kernel version, and architecture.
* **`cat /etc/hostname`**: Directly reads the configuration file where the static hostname is stored.
* **`uname -n`**: Displays the network node hostname (same as the basic `hostname` command).
* **`hostname -f`**: Shows the **Fully Qualified Domain Name (FQDN)** if it is configured in your system files. 
  
  

#### Using the Graphical User Interface (GUI)

1. Open **Settings** from the [Ubuntu Activities overview](https://help.ubuntu.com/stable/ubuntu-help/net-findip.html.en).
2. Scroll down and click on **About** (or **Details**) in the sidebar.
3. The hostname is listed under the **Device Name** field. 
   
   

#### Command Summary Table

| Goal             | Command       |
| ---------------- | ------------- |
| **Simple Name**  | `hostname`    |
| **Full Details** | `hostnamectl` |
| **FQDN**         | `hostname -f` |
| **Short Name**   | `hostname -s` |



****

# Almalinux see logged in users



To see currently logged-in users and their activity in AlmaLinux, you can use several standard Linux commands. Here are the most effective methods: 



1. ### Show Currently Logged-in Users (`w` command)

The `w` command provides a comprehensive overview of who is logged in, their terminal (TTY), remote IP address, login time, idle time, and what command they are currently running. 

```bash
w
```



2. ### Simple List of Logged-in Users (`who` command)

The `who` command displays a simpler list, showing the username, terminal, login date/time, and remote host, if applicable. ![Tecmint](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAACdElEQVQ4jX2TSUiUcRjGf///fONWNjlq4YJlBoELie0UTBSEA9HVzELyEIF47NJF5iKduwUtqGAeOkqjB6NpwUiUGgPRkjRnXArHhTH95lv+Hb4ZHaV6zu/zLs/zvIIk/O0hggEf/vZQDXAduAocBRQwBfQBvcGAbyxVCyBIg7899BS4zf/RDTQHAz4FIP3toRT5UzpZuDKw4gsklmcQUktvcAv4nNpa/HWykKy9f4i5PM3KSoysgiMUXb6H0DLTGz0LBnwtInlzeJssSEy9ouFCMXleL+NrOr9mZ3jzYYai040IsePqfJkULA0CczWK31/PPo+HkmNV1DffwVyPsRCZ2K1Hp8RRewfc3nI+Do9y5cRPToohBrqeoLI8WIbO/I9xlLJTpRcljlUp5bCWv7P5NUhdXS3G/htMFzdyqaEJczoE64tYZoLFyCTKtgGyJY7PAFixb2wMPwLhIicnB1BIZZCbl4/mzkBMvQR9FdPQWYw650ickCCki/hcmM0DpwDQdX1rMUPfxEzoUFgNS5OgFKaRYG7my4bESRjKtsitvIbtKUdKycjIKG4pEFIy0PUYzSVQB2uh5CwknbAt+50G9AL3AaQQFB46znr0NR0dD9jr8TAZ+83gi+e4vBWgZYNtbovtzribClIXTsJQCM643jIS6mc1obG8EkOTUFF9jglZhdiSTPSMdbc1iWSUBU48ayQWexYH2TAgup6BZVoUZCvcwiKiipwGQgyVFpSdn4/NqX8+08LsOKahs+vfANFTWlh2M7oUIdzZqmQamWDA1wLkA31FZZVx6XJbSZvjIPrd7szDY91tTfOxORXubFUAfwAmfADm9JPJXAAAAABJRU5ErkJggg==)Tecmint +1

```bash
who
```



3. ### List Only Usernames (`users` command)

If you only need a quick list of usernames currently logged in, separated by spaces on a single line, use: 

```bash
users
```




4. ### View Recent Logins (`last` command)

To see a history of users who have logged in and out, including those still logged in, use:

```bash
last
```

This reads from `/var/log/wtmp`. 



5. ### Check Specific User Activity

To see if a specific user is logged in and what they are doing:

```bash
w username   
```

Alternatively, to see if a user has any processes running:

```bash
ps -ef | grep username
```




6. ### Graphical Interface (GUI)

If you are using a desktop environment, you can go to **Settings > Users** to view active user accounts, though command-line tools are more reliable for listing active sessions. 



#### **Summary of Differences**

* **`w`**: Detailed (who, what, idle time, terminal).
* **`who`**: Brief (who, terminal, login time).
* **`users`**: Minimal (only usernames).
* **`last`**: Historical (logins/logouts). 
