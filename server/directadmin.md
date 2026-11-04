How to update a DirectAdmin server

https://base64.co.za/how-to-update-a-directadmin-server/

- Updating OS (Centos/Ubuntu)
- Updating Directadmin

## Update OS
If you’re running Centos, use the following commands to update the OS:

<pre>
Redhat
 yum check-update
 yum update

Debian/Ubuntu
 apt update
 apt upgrade
</pre>

## Update DirectAdmin
<pre>
cd /usr/local/directadmin/custombuild
./build update

 Check what the current versions of the software are, and what the latest versions are:
./build versions
 
Install the latest versions of the software:
./build update_versions
</pre>

## Update OS and DirectAdmin (one command)

The OS packages and DirectAdmin can be updated with one command in DirectAdmin as follows:
```
./build update_full
```
***

Unable to use login key with WHMCS https://forum.directadmin.com/threads/unable-to-use-login-key-with-whmcs.66497/

How to enable/disable the Ptrace block?
 https://cloudlinux.zendesk.com/hc/en-us/articles/4413280279836-How-to-enable-disable-the-Ptrace-block

AUTH_BLOCK_SENDER_SPOOFING granular config-support https://forum.directadmin.com/threads/auth_block_sender_spoofing-granular-config-support.80751/

First time DA user, many issues, can't figure them out. SSL not working as well as subdomains https://forum.directadmin.com/threads/first-time-da-user-many-issues-cant-figure-them-out-ssl-not-working-as-well-as-subdomains.60782/ <br> contains cloudflare reference

how to turn off unnecessary notification emails https://forum.directadmin.com/threads/how-to-turn-off-unnecessary-notification-emails.80532/

