# CentOS, Ubuntu

## How to Test/Send an SMTP Email (sendmail/exim) In the Shell

> Ref: https://bobcares.com/blog/exim-send-mail-from-command-line/

**AI Overview**

You can send a quick test email using Exim from your command line with the verbose flag enabled: `echo "Subject: Test" | exim -v recipient@example.com.`

**How to Send an Interactive Test Email**

1. Run the following command in your terminal:
we have to use the following command from our user shell to inform Exim that we plan to send an email to a specific recipient:
```bash
exim -v recipient@example.com
```

2. Type your message headers and body:
```text
From: sender@yourdomain.com
Subject: Test Email

This is a test message.
```

3. Press Ctrl + D to submit the email and watch the live SMTP connection details on your screen

4. Now, we will be able to see the SMTP connection details. We can return to our shell with the Ctrl+c key combination.

_**We can also send an email with Exim from the command line as seen below:**_
```bash
exim -i -t <<< 'From: Bob<bob@bobcares.com>
To: John Doe <John@abc.com>, jane Doe <jane@xyz.com>
Subject: Test email
Line 1
Line 2
```

Our experts would like to point out that we do not need to add quotes for the label of the email addresses before the angle brackets.
The -i option prevents dot-line termination. Additionally, the -t option ensures the recipients are derived from the content rather than a separate command line parameter.
Alternatively, we can load the email content from a text file as seen below:
```bash
exim -i -t < file/path.txt
```

**How to Test Address Routing**

If you want to check how Exim routes an email address without actually sending a message, run:
```bash
exim -bt email@domain.tld
```

****

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
Easier method but didn't seem to always work.
