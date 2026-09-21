# CentOS, Ubuntu

## How to Test/Send an SMTP Email (sendmail/exim) In the Shell

echo "Subject: test" | /usr/lib/sendmail -v me@domain.com <br>
OR <br>
echo "Subject: test" | /usr/sbin/exim4 -v me@domain.com

Use “which exim4” to find the correct path.

## directadmin exim set root alias

To set a root email alias in DirectAdmin with Exim, you need to redirect system mail destined for root to an active external or administrative email address.

Steps to Set the Root Alias

1. **Edit the aliases file** using a text editor (like nano):
```bash
nano /etc/aliases
```

2. **Add or modify the root entry** to point to your target email address:
```text
root: your@email.com
```

3. **Save and close** the file.

4. **Update the alias database** by running:
```bash
newaliases
```

5. **Restart the Exim service** to apply changes:
```bash
systemctl restart exim
```

_(Alternative: You can also place a .forward file containing your email address inside the /root directory, though editing /etc/aliases is the most reliable method.)_

To create a forward file, make a file named .forward inside this file list the e-mail address you want these e-mails to be sent too. Save in it the /root directory and that's it.
