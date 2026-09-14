DKIM Tools

[DMARC Inspector - dmarcian](https://dmarcian.com/dmarc-inspector/)

https://mxtoolbox.com/SuperTool.aspx

https://mxtoolbox.com/EmailHeaders.aspx

https://www.learndmarc.com/

[Common Boot Issues and Recovery Methods in AlmaLinux | Krython](https://krython.com/post/common-boot-issues-and-recovery-methods/)

[Linux: Add User to Sudoers](https://kodekloud.com/blog/linux-add-user-to-sudoers/)

***

# Apache Server

****

To check which port Apache is running on in Ubuntu, you can use several command-line tools or inspect its configuration files. 



1. ### Using `ss` (Modern & Recommended)

The `ss` command is the modern replacement for `netstat` and is installed by default on newer Ubuntu versions (22.04, 24.04). DigitalOcean +1

```bash
sudo ss -ltnp | grep apache2
```

* **`-l`**: Show listening sockets.

* **`-t`**: Show TCP sockets.

* **`-n`**: Show numerical port numbers instead of service names.

* **`-p`**: Show the process name/PID. 
2. ### Using `netstat` If you prefer the traditional tool, use `netstat`. You may need to install it first via `sudo apt install net-tools`.

```bash
sudo netstat -tulpn | grep apache2
```

This will display the **Local Address** column, where you can see the port (e.g., `0.0.0.0:80`). 



3. ### Using `lsof`

The `lsof` (List Open Files) command is excellent for identifying exactly which process is tied to a specific port. 

```bash
sudo lsof -i -P -n | grep apache2
```



4. ### Checking Configuration Files

If the service isn't currently running and you want to know which port it _will_ use, check the Apache configuration files: 



* **Primary Port Config**: View `/etc/apache2/ports.conf` to see the `Listen` directive (default is `80`).
  bash
  
      cat /etc/apache2/ports.conf

* **Virtual Hosts**: Check specific site configurations in `/etc/apache2/sites-enabled/` for custom port overrides (e.g., `<VirtualHost *:8080>`).
  
  

Summary of Quick Checks

| Tool           | Command                         | What it shows                                             |
| -------------- | ------------------------------- | --------------------------------------------------------- |
| **Status**     | `sudo systemctl status apache2` | If Apache is active and its main PID.                     |
| **Port Usage** | `sudo ss -tulpn`                | All active listening ports and their associated programs. |
| **IP/Browser** | `hostname -I`                   | Use the returned IP in a browser to test connectivity.    |



****

****

# Nginx Server

****

***

Learn paths;

hosts.cx

coolify.io



## Installation

1. sudo apt-get update
2. sudo apt-get install nginx

## Check status

1. sudo systemctl status nginx
   
   

****

[Creating a Document Root for a Static Site](https://www.digitalocean.com/community/tutorials/nginx-essentials-installation-and-configuration-troubleshooting#creating-a-document-root-for-a-static-site)



[Creating a Document Root for a Dynamically Processed Site](https://www.digitalocean.com/community/tutorials/nginx-essentials-installation-and-configuration-troubleshooting#creating-a-document-root-for-a-dynamically-processed-site)

When using Nginx with certain programs (e.g., PHP-FPM) to produce a dynamically-processed site, you may need to adjust some files’ permissions to allow the `www-data` group access or even ownership, especially if it needs to be able to write to the directory.

The commands in the block below will create a new document root, modify ownership of the document root to the `www-data` group, and modify the permissions of each subdirectory within `/var/www`.



```bash
sudo mkdir -p /var/www/example.com/html
sudo chown -R www-data:www-data /var/www/example.com
sudo find /var/www -type d -exec chmod 775 {} \;
```



[Enabling Configuration Files](https://www.digitalocean.com/community/tutorials/nginx-essentials-installation-and-configuration-troubleshooting#enabling-configuration-files)

We can enable a server block’s configuration file by creating a symbolic link from the `sites-available` directory to the `sites-enabled` directory, which Nginx will read during startup.



To do this, enter the following command:

```bash
sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/
```



After linking the files, reload Nginx to reflect the change and enable the server block’s configuration file:

```bash
sudo systemctl reload nginx
```



[Resolving Hash Bucket Memory Issues](https://www.digitalocean.com/community/tutorials/nginx-essentials-installation-and-configuration-troubleshooting#resolving-hash-bucket-memory-issues)

Nginx uses hash tables (which are organized into “buckets”) to quickly process static data like server names or MIME types. Thus, if you’ve added multiple server names, there’s a chance that the size of the server name hash buckets will no longer be sufficient and you will see a `server_names_hash_bucket_size` error as you make changes. This can be addressed by adjusting a single value within your `/etc/nginx/nginx.conf` file.



To open this config file, enter:

```bash
sudo nano /etc/nginx/nginx.conf
```



Within the file, find the `server_names_hash_bucket_size` directive. Remove the `#` symbol to uncomment the line, and increase the directive’s value by the next power of two:



```nginx
# /etc/nginx/nginx.conf

http {
    . . .

    server_names_hash_bucket_size 64;

    . . .
}
```



Doing this will increase the bucket size of Nginx’s server names hash tables and allow the service to process all the server names you’ve added. Save and close the file when you are finished, and then restart Nginx to reflect the changes.



****

[Important Nginx Files and Directories](https://www.digitalocean.com/community/tutorials/nginx-essentials-installation-and-configuration-troubleshooting#important-nginx-files-and-directories)

As you spend time working with Nginx, you may find yourself frequently accessing the following files and directories:



[Content](https://www.digitalocean.com/community/tutorials/nginx-essentials-installation-and-configuration-troubleshooting#content)[](https://www.digitalocean.com/community/tutorials/nginx-essentials-installation-and-configuration-troubleshooting#content)

* `/var/www/html`: This is the location of the default document root from which the actual web content is served. The document root can be changed by altering Nginx configuration files.
  
  

[Server Configuration](https://www.digitalocean.com/community/tutorials/nginx-essentials-installation-and-configuration-troubleshooting#server-configuration)[](https://www.digitalocean.com/community/tutorials/nginx-essentials-installation-and-configuration-troubleshooting#server-configuration)

* `/etc/nginx/`: The default Nginx configuration directory where all your Nginx config files can be found.
* `/etc/nginx/nginx.conf`: The primary Nginx configuration file. This can be directed to make global changes to Nginx’s configuration.
* `/etc/nginx/sites-available/default`: Nginx’s default server block file. Other per-site server blocks are also stored within the `sites-available` directory, although these will not be used unless they are linked to in the `sites-enabled` directory.
* `/etc/nginx/sites-enabled/`: The directory where enabled per-site “server blocks” are stored. Typically, these are created by linking to configuration files found in the `sites-available` directory.
  
  

[Server Logs](https://www.digitalocean.com/community/tutorials/nginx-essentials-installation-and-configuration-troubleshooting#server-logs)[](https://www.digitalocean.com/community/tutorials/nginx-essentials-installation-and-configuration-troubleshooting#server-logs)

* `/var/log/nginx/access.log`: Every request to your web server is recorded in this log file unless Nginx is configured to do otherwise.
* `/var/log/nginx/error.log`: Any Nginx errors will be recorded in this log.
* To access the Nginx process’s systemd logs, run the following command:
  
  

```bash
sudo journalctl -u nginx
```













****

Nginx Configuration Management Guide
------------------------------------

This guide provides the necessary commands to disable, re-enable, and apply configuration changes to Nginx sites using symbolic links.

* * *

1. Disable a Site (Unlink)

--------------------------

To disable a site without deleting the source configuration file, remove the symbolic link from the `sites-enabled` directory.
    sudo unlink /etc/nginx/sites-enabled/your_site.conf

2. Re-enable a Site (Link)

--------------------------

To bring a site back online, create a symbolic link from the source file in `sites-available` to the `sites-enabled` directory.
    sudo ln -s /etc/nginx/sites-available/your_site.conf /etc/nginx/sites-enabled/

3. Verify Configuration

-----------------------

Before applying any changes, always check for syntax errors to ensure the server remains stable.
    sudo nginx -t

Expected Result:

> nginx: the configuration file /etc/nginx/nginx.conf syntax is ok  
> nginx: configuration file /etc/nginx/nginx.conf test is successful

4. Reload Nginx

---------------

Once the configuration is verified, reload the service to apply changes. This is safer than a restart as it does not drop active connections.
    sudo systemctl reload nginx

* * *

Quick Reference Summary
-----------------------

| Action        | Command                                                                  |
| ------------- | ------------------------------------------------------------------------ |
| Disable Site  | `sudo unlink /etc/nginx/sites-enabled/<file>`                            |
| Enable Site   | `sudo ln -s /etc/nginx/sites-available/<file> /etc/nginx/sites-enabled/` |
| Check Syntax  | `sudo nginx -t`                                                          |
| Apply Changes | `sudo systemctl reload nginx`                                            |

Nginx Configuration: Disabling a Site
-------------------------------------

This guide explains how to safely disable an Nginx site by removing its symbolic link and reloading the service.

* * *

1. Locate and Unlink the Configuration

--------------------------------------

In most Linux distributions, active configurations are stored as symbolic links in the `sites-enabled` directory. Use the `unlink` command to remove the link without deleting the actual file in `sites-available`.
    sudo unlink /etc/nginx/sites-enabled/your_config_name

_(Replace `your_config_name` with the actual name of your configuration file.)_

2. Test the Configuration

-------------------------

Always verify that the remaining configuration files are syntactically correct before applying changes.
    sudo nginx -t

Expected Output:

> nginx: the configuration file /etc/nginx/nginx.conf syntax is ok  
> nginx: configuration file /etc/nginx/nginx.conf test is successful

3. Reload Nginx

---------------

Apply the changes by reloading the Nginx process. This is preferred over a full restart as it maintains current active connections.
    sudo systemctl reload nginx

* * *

Summary of Commands
-------------------

| Action         | Command                                       |
| -------------- | --------------------------------------------- |
| Unlink         | `sudo unlink /etc/nginx/sites-enabled/<file>` |
| Check Syntax   | `sudo nginx -t`                               |
| Reload Service | `sudo systemctl reload nginx`                 |



_Note: To unlink an Nginx configuration file and reload the service, follow these steps:

1. Remove the Symbolic Link 

Most Nginx setups use symbolic links in the `sites-enabled` directory to activate configurations stored in `sites-available`. To disable a site, you must remove this link. 

* **Using `unlink`**:
  
      sudo unlink /etc/nginx/sites-enabled/your_config_name

* **Using `rm`** (alternative):
  bash
  
      sudo rm /etc/nginx/sites-enabled/your_config_name
  
  

_Note: Using `unlink` or `rm` only deletes the shortcut; your actual configuration file remains safe in `/etc/nginx/sites-available/`.



2. Verify the Configuration

Before applying changes, always test for syntax errors to prevent the web server from failing. 



```bash
sudo nginx -t
```



3. Reload Nginx 

Reloading is preferred over restarting because it applies changes without dropping active connections. 



* **Standard Command**:
  bash
  
      sudo systemctl reload nginx

* **Alternative (via Nginx binary)**:
  bash
  
      sudo nginx -s reload
  
  

Nginx Configuration Guide: Managing Sites
-----------------------------------------

This guide covers how to disable and re-enable Nginx sites using symbolic links (symlinks) and how to apply those changes safely.

* * *

1. How to Disable a Site (Unlink)

---------------------------------

To disable a site without deleting the source file, remove the link from the `sites-enabled` directory.
    sudo unlink /etc/nginx/sites-enabled/your_site.conf

2. How to Re-enable a Site (Link)

---------------------------------

To bring a site back online, create a new symbolic link from the source file in `sites-available` to the `sites-enabled` folder.
    sudo ln -s /etc/nginx/sites-available/your_site.conf /etc/nginx/sites-enabled/

3. Verify and Apply Changes

---------------------------

After unlinking or re-linking, always test the configuration for syntax errors before reloading.

Test Configuration:
    sudo nginx -t

Reload Nginx:  
If the test is successful, reload the service to apply the changes without dropping active connections.
    sudo systemctl reload nginx

* * *

Quick Reference Table
---------------------

| Action           | Command                                                                    |
| ---------------- | -------------------------------------------------------------------------- |
| Disable (Unlink) | `sudo unlink /etc/nginx/sites-enabled/filename`                            |
| Enable (Link)    | `sudo ln -s /etc/nginx/sites-available/filename /etc/nginx/sites-enabled/` |
| Check Syntax     | `sudo nginx -t`                                                            |
| Apply Changes    | `sudo systemctl reload nginx`                                              |

# Testing server syntax

#### **Testing NGINX Syntax**

The `nginx` command includes a flag specifically for testing the current configuration. 

* **Quick Test:** Run `sudo nginx -t`.

* **Success Output:** `nginx: the configuration file /etc/nginx/nginx.conf syntax is ok` and `nginx: configuration file /etc/nginx/nginx.conf test is successful`.

* **Failure Output:** The command will display the specific file and line number where the error occurred (e.g., `unexpected ";" in /etc/nginx/nginx.conf:16`).

* **Dump Configuration:** Use `sudo nginx -T` to test the syntax and dump the entire configuration to the console, including all included files.
  
  

#### **Testing Apache Syntax**

Apache provides the `apache2ctl` (or `httpd`) tool to validate configuration files. 

* **Standard Test:** Run `sudo apache2ctl configtest`.

* **Success Output:** `Syntax OK`.

* **Failure Output:** It reports the specific file and line number containing the problem.

* **Detailed Virtual Host Check:** Run `sudo apache2ctl -S` to see a detailed parsing of all virtual hosts, which can help find overlapping `ServerName` directives or port conflicts.
  
  

#### **Key Syntax Differences**

| Feature                 | Apache Syntax                                        | NGINX Syntax                                                    |
| ----------------------- | ---------------------------------------------------- | --------------------------------------------------------------- |
| **Line Ending**         | One directive per line.                              | Every directive must end with a semicolon (`;`).                |
| **Structure**           | Uses XML-like tags (e.g., `<VirtualHost *:80>`).     | Uses context blocks with curly braces `{}`.                     |
| **Directory Config**    | Supports `.htaccess` files in website directories.   | Does not support `.htaccess`; all config must be in main files. |
| **Regular Expressions** | Standard Perl-Compatible Regular Expressions (PCRE). | Similar Perl syntax, often preceded by a tilde ( `~` ).         |



****
