* mailx or s-nail to see messages
* /etc/aliases file:
* /etc/postfix/virtual
* postalias /etc/aliases

_Ref: https://hostperl.com/kb/tutorials/configure-mail-aliases-virtual-users-ubuntu-vps-complete-setup_

Mail aliases redirect messages from one address to another existing user account. Virtual users exist only in the mail system—no corresponding system accounts needed. Both features give you precise control over email routing and delivery on your

## Brief

**Some background** <br>
_Ref: https://serverfault.com/questions/644306/confused-about-alias-maps-and-virtual-alias-maps_

Postfix inherited some features from older sendmail like milter and aliases. The file /etc/aliases is part of aliases inheritance and implemented by alias_maps. On the other side, postfix has virtual_maps/virtual_alias_maps for handle email aliasing. So what's the difference between them?

**Parameter alias_maps**

* Used only for local(8) delivery
* According to address class in postfix, email will delivery by local(8) if the recipient domain names are listed in the `mydestination`
* The lookup input was only local parts from full email addres (e.g myuser from myuser@example.com). It discard domain parts of recipient.
* The lookup result can contains one or more of the following:
<pre>
    <b>email address</b>: email will forwarded to email address
    <b>/file/name</b>: email will be appended to /file/name
    <b>|command</b>: mail piped to the command
    <b>:include:/file/name</b>: include alias from /file/name
</pre>

**Parameter virtual_alias_maps**

* Used by virtual(5) delivery
* Always invoked first time before any other address classes. It doesn't care whether the recipient domain was listed in mydestination, virtual_mailbox_domains or other places. It will override the address/alias defined in other places.
* The lookup input has some format
<pre>
    <be>user@domain</be>: it will match user@domain literally
    <be>user</be>: it will match user@site when site is equal to $myorigin, when site is listed in $mydestination, or when it is     listed in $inet_interfaces or $proxy_interfaces. This functionality overlaps with functionality of the local aliases(5) database.
    <b>@domain</b>: it will match any email intended for domain regardless of local parts
</pre>
* The lookup result must be
<pre>
    valid email address
    user without domain. Postfix will append $myorigin if append_at_myorigin set yes
</pre>

> Why do we need /etc/aliases when having the email inside virtual aliases map seems to override it?

As you can see above, alias_maps(/etc/aliases) has some additional features (beside forwarding) like piping to command. In contrast with virtual_alias_maps that just forwards emails.

> What is the purpose of having these 2 separate aliases mapping and when do we decide when to use what?

The alias_maps drawback is that you cannot differentiate if the original recipient has root@example.com or root@example.net. Both will be mapped to root entry in alias_maps. In other words, you can define different forwarding address with virtual_alias_maps.

***

## Postfix/generic map example

**AI Overview**

The **Postfix generic map** allows you to alter outgoing email addresses (both headers and envelopes) when mail leaves your system via SMTP. This is particularly useful for rewriting invalid internal domains (like .local or local hostnames) into valid public internet email addresses.
> Ref: <br/>
> https://linux.die.net/man/5/generic <br/>
> https://gist.github.com/697d5fe9ddabf1902d13

Here is a step-by-step example of how to configure and use it:

1. ### Enable generic maps in `main.cf`

Open your Postfix configuration file (usually /etc/postfix/main.cf) and add or modify the following line to define your lookup table:
> Ref: <br/>
> https://www.postfix.org/generic.5.html
> https://www.postfix.org/ADDRESS_REWRITING_README.html
> https://gist.github.com/697d5fe9ddabf1902d13
```ini
smtp_generic_maps = hash:/etc/postfix/generic
```
_(Note: Some modern Linux distributions use `lmdb`: instead of `hash`:. You can check what your system supports by running `postconf -m`)._
> Ref: <br/>
> https://www.postfix.org/STANDARD_CONFIGURATION_README.html <br/>
> https://www.postfix.org/generic.5.html

2. ### Configure the rules in `/etc/postfix/generic`

Open or create the /etc/postfix/generic file. The syntax relies on a simple format: **original_address   rewritten_address**.
> Ref: <br/>
> https://www.postfix.org/generic.5.html <br/>
> https://superuser.com/questions/1849071/how-to-apply-postfix-milter-before-smtp-generic-maps-for-dkim-purposes <br/>
> https://gist.github.com/697d5fe9ddabf1902d13
```txt
text# Map specific local users to a public address
root@localdomain.local       admin@yourcompany.com
john@localdomain.local       john.doe@yourcompany.com

# Map an entire local domain to a single fallback address
@localdomain.local           noreply@yourcompany.com
```

3. ### Generate the database and restart

Whenever you change the map file, you must rebuild the Postfix lookup database using the `postmap` command. After that, reload or restart Postfix to apply the changes.
> Ref: <br/>
> https://www.postfix.org/generic.5.html <br/>
> https://www.cyberciti.biz/tips/howto-postfix-masquerade-change-email-mail-address.html <br/>
> https://linux.die.net/man/5/generic <br/>
> https://gist.github.com/697d5fe9ddabf1902d13

Run the following commands in your terminal:
```bash
sudo postmap /etc/postfix/generic
sudo systemctl restart postfix
```

### How to test your mapping

You can verify that your generic map is resolving accurately without sending a test email by using `postmap -q`:
> Ref: <br/>
> https://linux.die.net/man/5/generic
```bash
postmap -q "john@localdomain.local" hash:/etc/postfix/generic
```
**Expected output**: john.doe@yourcompany.com

****

## Postfix rewrite mail address ONLY for outgoing/sending e-mail

- https://www.claudiokuenzler.com/blog/164/postfix-rewrite-change-mail-address-for-outgoing-sending-mails

rewriting outgoing sender should be done @ /etc/postfix/generic

The parameter smtp_generic_maps:

> _Note "When mail is sent to a remote host via SMTP, this replaces  his@localdomain.local by his ISP mail address, replaces her@localdomain.local by her ISP mail address, ...."_

The sender_canonical_maps parameter:

> _Note Example: you want to rewrite the SENDER address "user@ugly.domain" to "user@pretty.domain", while still being able to send mail to the RECIPIENT address "user@ugly.domain"._

# Postfix

## Configuration
> https://www.postfix.org/BASIC_CONFIGURATION_README.html

**What domain name to use in outbound mail**

The myorigin parameter specifies the domain that appears in mail that is posted on this machine. The default is to use the local machine name, <u>$myhostname</u>, which defaults to the name of the machine. Unless you are running a really small site, you probably want to change that into $mydomain, which defaults to the parent domain of the machine name.

For the sake of consistency between sender and recipient addresses, myorigin also specifies the domain name that is appended to an unqualified recipient address.

Examples (specify only one of the following):
<pre>
/etc/postfix/main.cf:
    myorigin = $myhostname (default: send mail as "user@$myhostname")
    myorigin = $mydomain   (probably desirable: "user@$mydomain")
</pre>

**What domains to receive mail for**
<pre>
IMPORTANT: If your machine is a mail server for its entire domain, you must list $mydomain as well.

Example 1: default setting.

/etc/postfix/main.cf:
    mydestination = $myhostname localhost.$mydomain localhost
Example 2: domain-wide mail server.

/etc/postfix/main.cf:
    mydestination = $myhostname localhost.$mydomain localhost $mydomain
Example 3: host with multiple DNS A records.

/etc/postfix/main.cf:
    mydestination = $myhostname localhost.$mydomain localhost 
        www.$mydomain ftp.$mydomain
Caution: in order to avoid mail delivery loops, you must list all hostnames of the machine, including $myhostname, and localhost.$mydomain.
</pre>

**What trouble to report to the postmaster**

You should set up a postmaster alias in the aliases(5) table that directs mail to a human person. The postmaster address is required to exist, so that people can report mail delivery problems. While you're updating the aliases(5) table, be sure to direct mail for the super-user to a human person too.

<pre>
/etc/aliases:
    postmaster: you
    root: you
</pre>

Execute the command "newaliases" after changing the aliases file. Instead of /etc/aliases, your alias file may be located elsewhere. Use the command "postconf alias_maps" to find out.


## Terms

- **Virtual Email Mapping**
    Imagine your company has generic email addresses like info@company.com or support@company.com. Virtual mapping lets you:

    Create these addresses without creating actual user accounts
    Direct emails sent to these addresses to real user inboxes

 - **The Postmap Command and "Lookups"**

    Before postmap: You have a text file with entries like info@example.com testuser
    The lookup process: When an email arrives, Postfix needs to quickly find who should receive it
    The problem: Searching through a text file line by line is slow
    What postmap does: Creates a special database that works like a phone book for faster lookups

## Redhat
> https://www.redhat.com/en/blog/install-configure-postfix <br>
> https://orcacore.com/install-postfix-almalinux-9/
> https://reintech.io/blog/configuring-postfix-smtp-authentication-almalinux-9

### How to install and configure Postfix

Sendmail and Postfix are the most commonly used implementations of SMTP in most Linux distros. Postfix is an open source mail-transfer agent that was originally developed as an alternative to Sendmail and is usually set up as the default mail server.

**Installing Postfix**

A good habit to have is to check and see if the software is installed on the server already. It’s always helpful to check if something is there before getting to work.

```bash
# Update System
# Update your local package index with the following command:
sudo dnf update -y

# Check if sendmail is installed
rpm -qa | grep sendmail

# If you have Sendmail installed on your server, you need to remove it with the following command:
sudo dnf remove sendmail*

# Check if postfix is installed
rpm -qa | grep postfix

# Install if not present
yum install -y postfix

# After Postfix is installed, you can start the service and enable it to make sure it starts after reboot:
systemctl start postfix
systemctl enable postfix
```

**Configuring Postfix**

By default, Postfix configuration files are in /etc/postfix.
The two most important files are main.cf and master.cf; these files must be owned by root. Giving someone else write permission to main.cf or master.cf (or to their parent directories) means giving root privileges to that person.
The main configuration file for the Postfix service is located at /etc/postfix/main.cf

<pre>
_You specify a configuration parameter as:_
/etc/postfix/main.cf:
    parameter = value
    
and you use it by putting a "$" character in front of its name:
/etc/postfix/main.cf:
    other_parameter = $parameter

Whenever you make a change to the main.cf or master.cf file, execute the following command as root in order to refresh a running mail system:
# postfix reload
</pre>

1. Check your current Postfix configuration
```bash
sudo postconf myhostname
sudo postconf myorigin
sudo postconf smtp_generic_maps
sudo postconf sender_canonical_maps
sudo postconf canonical_maps

# Or

sudo postconf | grep -E '^(myhostname|myorigin|smtp_generic_maps|sender_canonical_maps|canonical_maps|relayhost)'
```

2. If you want local system mail to become system@domain.tld
The relevant setting is usually: myorigin
Ex:
```bash
sudo postconf myorigin=domain.tld
```

- myhostname declares the mail server’s hostname. Hostnames normally have prefixes in them, like this:
```txt
myhostname = mail.domain.tld or sub.domain.tld
```

- mydomain declares the domain that is actually handling mail, like this:
```txt
mydomain = domain.tld
```

- mail_spool_directory declares the directory where mailbox files are placed, like so:
```txt
mail_spool_directory = /var/mail
```

- mynetworks declares a list of trusted remote SMTP servers that can relay through the server, like this:
```txt
mynetworks = 127.0.0.0/8, 168.100.189.0/28
```
_Note_ The list provided with mynetworks should only contain local network IP addresses, or network/netmask patterns that are separated by commas or whitespace. It’s important to only use local network addresses to avoid unauthorized users using your mail server for malicious activity, resulting in your server and addresses being blacklisted.

**Testing Postfix**

Before putting something into production, testing it in a dev environment is always a good idea.

First, I recommend testing whether you can send an email to a local recipient. If successful, you can proceed to a remote recipient. I prefer to use the telnet command to test my mail server:
```
telnet mail.sinisterriot.com 25
```

Add the HELO command to tell the server which domain you are coming from:
```
HELO sinisterriot.com
```

Next is the sender. This ID can be added with the MAIL FROM command:
```
MAIL FROM: somewhere@sinisteriot.com
```

This entry is followed by the recipient, and you can add more than one by using the RCPT TO command multiple times:
```txt
RCPT TO: someone@sinisterriot.com
```

Finally, we can add the content of the message. To reach the content mode, we add the prefix DATA on a line by itself, followed by the Subject line, and the body message. Listed below is an example:
```txt
DATA
Subject: This is a test message  
Hello,
This is a test message
.
```

In order to finish the message body and close it, you need to add a single period (.) or dot on a line by itself. Once this process is complete, the server will attempt to send the email with the information you provided. The code response will notify you if the email was successful or not. Once done, use the quit command to close the mailing window.

In any regard, check the mail logs for errors. They are located in /var/log/maillog by default, but this location can be changed to another place. As a system administrator, checking error logs is a good habit to have. This practice is great in troubleshooting and gives us insight into identifying and fixing an issue faster. Deciphering mail logs is an important part of admin work as well, as each part of the log lets us know what is important. In my past years, knowing these parts has helped me write scripts for specific requests while only needing to redact or leave out parts of the mail logs.

***

## Ubuntu
> https://ubuntu.com/server/docs/how-to/mail-services/install-postfix/ <br>
> https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-postfix-on-ubuntu-20-04

### **Install and configure Postfix**

**Install Postfix**
To install Postfix run the following command:
```bash
sudo apt install postfix
```
It is OK to accept defaults initially by pressing return for each question. Some of the configuration options will be investigated in greater detail in the configuration stage.

> **Configure Postfix**
There are four things you should decide before configuring:

- The <Domain> for which you’ll accept email (we’ll use mail.example.com in our example)
- The network and class range of your mail server (we’ll use 192.168.0.0/24)
- The username (we’re using steve)
- Type of mailbox format (mbox is the default, but we’ll use the alternative, Maildir)

To configure postfix, run the following command:
```bash
sudo dpkg-reconfigure postfix
```

The user interface will be displayed. On each screen, select the following values:

- Internet Site
- mail.example.com
- steve
- mail.example.com, localhost.localdomain, localhost
- No
- 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128 192.168.0.0/24
- 0
- +
- all

To set the mailbox format, you can either edit the configuration file directly, or use the postconf command. In either case, the configuration parameters will be stored in /etc/postfix/main.cf file. Later if you wish to re-configure a particular parameter, you can either run the command or change it manually in the file.


*** 

### Manual test:
```
echo "Test mail from root" | mail -s "Test Subject" root

# s-nail
echo "Hello, this is a test mail" | s-nail -s "Test" dest@example.com
echo "Hello, this is a test mail" | s-nail -s "Test" dest@example.com
```

### Config:

**Sample .mailrc configuration file for Gmail**
```txt
set smtp-use-starttls
set smtp=smtp://smtp.gmail.com:587
set smtp-auth=login
# Change 'xxxxxx' with your username
set smtp-auth-user=xxxxxx@gmail.com
# Change 'xxxxxxxxxxxx' with your password
set smtp-auth-password=xxxxxxxxxxxx
# Change 'xxxxxxxx' with the name of your Firefox's profile,
# it is located in the ~/.mozilla/firefox/ directory.
set nss-config-dir=~/.mozilla/firefox/xxxxxxxx.default
set ssl-verify=ignore
```

**mail.rc**
```txt
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









































