CentOS, Ubuntu

How to Test/Send an SMTP Email (sendmail/exim) In the Shell

echo "Subject: test" | /usr/lib/sendmail -v me@domain.com
OR
echo "Subject: test" | /usr/sbin/exim4 -v me@domain.com
Use “which exim4” to find the correct path.
