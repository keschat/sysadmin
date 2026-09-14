Refs:
- https://reintech.io/blog/configuring-postfix-smtp-authentication-almalinux-9

### Manual test:
```
echo "Test mail from root" | mail -s "Test Subject" root

# s-nail
echo "Hello, this is a test mail" | s-nail -s "Test" destination@example.com
echo "Hello, this is a test mail" | s-nail -s "Test" colornest@beez24.net
```

### Config:

**mail.rc**
```bash
set from="BillingAdmin <admin@beez24.net>"
set reply-to="noreply@beez24.net"
set organization="Beez24"
```

**Aliases**
```bash
nano /etc/aliases

# Run this command to update Exim's alias database: newaliases

postfix reload
```

**Sender canonical**
```bash
nano /etc/postfix/sender_canonical
nginx nginx-alerts@beez24.net
```

**Vrtual**
```bash
nano  /etc/postfix/virtual

postmap /etc/postfix/virtual
postmap -q "string" /etc/postfix/virtual
postmap -q - /etc/postfix/virtual <inputfile

postfix reload
```

**Generic**

- vi /etc/postfix/generic <br>
root     myname@domain.tld
- vi /etc/postfix/main.cf <br>
smtp_generic_maps = hash:/etc/postfix/generic
- postmap /etc/postfix/generic
- postfix reload


## postfix from email address

You can change or set the outgoing "From" email address in Postfix by configuring smtp_generic_maps in your main configuration file. <br>
[1] (https://www.cyberciti.biz/tips/howto-postfix-masquerade-change-email-mail-address.html)


#### How to Configure smtp_generic_maps

1. **Open the main configuration file:**
```bash
sudo nano /etc/postfix/main.cf
```
2. **Add or uncomment the generic maps parameter:**
```text
smtp_generic_maps = hash:/etc/postfix/generic
```
3. **Edit the mapping file:**
Open /etc/postfix/generic and map the local system username/address to your desired external email address:
```bash
root@yourserver.com     desired-from@example.com
username@yourserver.com   desired-from@example.com
```
4 . **Generate the hash database file:**
Run the following command to update Postfix's lookup table:
```bash
sudo postmap /etc/postfix/generic
sudo postmap -v /etc/postfix/generic
```
5. **Restart Postfix:**
Apply the changes by restarting the service:
```bash
sudo systemctl restart postfix
```

## [.](https://www.cyberciti.biz/tips/howto-postfix-masquerade-change-email-mail-address.html) Postfix masquerading or changing outgoing SMTP email or mail address

Address rewriting allows changing outgoing email ID or the domain name itself. Useful for hiding out internal user names, especially shell users on Linux and Unix boxes. <br>
For example: <br>
» SMTP user/shell user: tom-01 <br>
» EMAIL ID: tom@domain.com <br>
» Server name (FQDN): server01.hosting.com <br>

**Postfix masquerading and changing outgoing SMTP email or mail address**

Postfix MTA offers smtp_generic_maps parameter. You can specify lookup tables that replace local mail addresses by valid Internet addresses when mail leaves the machine via SMTP.

Open your main.cf config file using a text editor such as vim command/nano command:
```bash
# vi /etc/postfix/main.cf
```
Append or uncomment following parameter
```
smtp_generic_maps = hash:/etc/postfix/generic
```
Save and close the file when using vim. Open /etc/postfix/generic file:
```bash
# vi /etc/postfix/generic
```
Make sure tom-01@server01.hosting.com change to tom@domain.com as follows:
```
tom-01@server01.hosting.com tom@domain.com
```
Save and close the file. Create or update generic postfix table using the postmap command:
```bash
# postmap /etc/postfix/generic
```
Finally restart or reload postfix service:
```bash
# /etc/init.d/postfix restart
## OR ##
# systemctl restart postfix.service
```
















