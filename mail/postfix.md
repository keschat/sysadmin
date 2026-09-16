mailx to see messages

>https://www.redhat.com/en/blog/install-configure-postfix
>
>

### How to install and configure Postfix

Sendmail and Postfix are the most commonly used implementations of SMTP in most Linux distros. Postfix is an open source mail-transfer agent that was originally developed as an alternative to Sendmail and is usually set up as the default mail server.

**Installing Postfix**

A good habit to have is to check and see if the software is installed on the server already. It’s always helpful to check if something is there before getting to work.

To check on RPM-based distros, use this command:
```bash
rpm -qa | grep postfix
```

```bash
yum install -y postfix
```

After Postfix is installed, you can start the service and enable it to make sure it starts after reboot:
```bash
systemctl start postfix
systemctl enable postfix
```

**Configuring Postfix**

Config files in /etc/postfix
The main configuration file for the Postfix service is located at /etc/postfix/main.cf

- myhostname declares the mail server’s hostname. Hostnames normally have prefixes in them, like this:
```text
myhostname = mail.sinisterriot.com
```

- mydomain declares the domain that is actually handling mail, like this:
```
mydomain = sinisterriot.com
```

- mail_spool_directory declares the directory where mailbox files are placed, like so:
```
mail_spool_directory = /var/mail
```

- mynetworks declares a list of trusted remote SMTP servers that can relay through the server, like this:
```
mynetworks = 127.0.0.0/8, 168.100.189.0/28
```


***

1. Check your current Postfix configuration
```bash
sudo postconf myhostname
sudo postconf myorigin
sudo postconf smtp_generic_maps
sudo postconf sender_canonical_maps
sudo postconf canonical_maps

# Also

sudo postconf | grep -E '^(myhostname|myorigin|smtp_generic_maps|sender_canonical_maps|canonical_maps|relayhost)'
```

2. If you want local system mail to become system@domain.tld
The relevant setting is usually:
```
myorigin
```
Ex:
```bash
sudo postconf myorigin=domain.tld
```

Refs:
- https://reintech.io/blog/configuring-postfix-smtp-authentication-almalinux-9

### Manual test:
```
echo "Test mail from root" | mail -s "Test Subject" root

# s-nail
echo "Hello, this is a test mail" | s-nail -s "Test" dest@example.com
echo "Hello, this is a test mail" | s-nail -s "Test" dest@example.com
```

### Config:

**mail.rc**
```bash
set from="BillingAdmin <admin@domain.tld>"
set reply-to="noreply@domain.tld"
set organization="Org name"
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
nginx web-alerts@domain.tld
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









































