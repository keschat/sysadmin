## Moving DA and general structure

- Move site and domain of admin to an other account [DA forum](https://forum.directadmin.com/threads/move-site-and-domain-of-admin-to-an-other-account.57228/)

## Securing DirectAdmin

- Securing DirectAdmin https://docs.directadmin.com/directadmin/general-usage/securing-da-panel.html <br/>
- https://docs.directadmin.com/webservices/ssl/service-ssls-and-le.html <br/>
- How can I disable telnet https://forum.directadmin.com/threads/how-can-i-disable-telnet.23632/

***

## Restart Directadmin

You can restart DirectAdmin by running `systemctl restart directadmin` or `service directadmin restart` via SSH as the root user.

***

## Mail Accounts

- System mail accounts https://forum.directadmin.com/threads/system-mail-accounts-returning-550-no-such-recipient-here.59446/

***

## Customizing

- All directadmin.conf values https://docs.directadmin.com/directadmin/general-usage/all-directadmin-conf-values.html
- Directories and locations https://docs.directadmin.com/directadmin/general-usage/directories-and-locations.html
- Customizing Admin https://docs.directadmin.com/directadmin/customizing-workflow/customizing-admin.html
- Customizing Users https://docs.directadmin.com/directadmin/customizing-workflow/customizing-users.html
- Customize-everything https://docs.directadmin.com/custombuild/customize-everything.html
- Pre-defined options installation, also directadmin.conf possible? And other questions https://forum.directadmin.com/threads/pre-defined-options-installation-also-directadmin-conf-possible-and-other-questions.68921/
- Customizing Nginx+Apache https://docs.directadmin.com/webservices/nginx_apache/customizing-nginx-apache.html </br>
- Main DirectAdmin configuration file https://docs.directadmin.com/directadmin/general-usage/configuring-da.html <br/>
- How to enable notifications for account creation in DirectAdmin https://www.plothost.com/kb/notifications-account-creation-directadmin/
- How to block a user from sending emails https://www.plothost.com/kb/block-smtp-user-directadmin/

Besides of options listed in the directadmin.conf, the panel itself uses some pre-defined defaults. To list all current configuration options:
```bash
/usr/local/directadmin/directadmin config
```
or short form:
```bash
da c
```
If you are looking for a specific option, just grep it, like so (using 'letsencrypt' as an example):
```bash
/usr/local/directadmin/directadmin config | grep letsencrypt
```

Instead of editing the directadmin.conf directly, you may use the `da config-set` functionality to change the options:
```bash
# before v1.710
da config-set NAME VALUE
# since v1.710
da config-set NAME VALUE
da config-set NAME=VALUE
```
Add `--restart` flag to have directadmin restarted. Since v1.710, directadmin.service is reloaded/restarted by default, this can be turned off with `--no-reload` flag.

For example, to `set dns_ttl` to `1`, execute the commands:
```bash
# before v1.710
da config-set dns_ttl 1             # manual reload required
da config-set dns_ttl 1 --restart 
# since v1.710
da config-set dns_ttl 1
da config-set dns_ttl=1
da config-set dns_ttl=1 --no-reload # manual reload required
```
_If the setting has been changed successfully, directadmin will exit with code 0._

***

## How to change the Return Path for diradmin emails

> https://docs.directadmin.com/directadmin/general-usage/configuring-da.html

Use the new `diradmin_envelope` option, which allows you to override the default "diradmin@host.name.com" in the Return-Path as desired:
```bash
da config-set diradmin_envelope your@email.com
systemctl restart directadmin
```
_By default, this is disabled and relies on your hostname being set up/resolving correctly._

***
# directadmin set msg_sys=Message System

The `msg_sys=Message` System setting in DirectAdmin defines the sender name ("From" display name) used for automated system notification emails.

- Ref: https://docs.directadmin.com/directadmin/general-usage/all-directadmin-conf-values.html

### How to Change the Setting

1. Open the DirectAdmin configuration file via SSH using a text editor:
```bash
nano /usr/local/directadmin/conf/directadmin.conf
```

2. Locate or add the `msg_sys` variable and change it to your desired name (such as your hosting company or server name):
```ini
msg_sys=Your Hosting Company Name
```

3. Save the file and restart DirectAdmin to apply the changes:bashservice directadmin restart
```bash
service directadmin restart
```

***

## Troubleshooting Exim

- https://docs.directadmin.com/other-hosting-services/exim/troubleshooting.html

