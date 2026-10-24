## SMTP Relays

postfix on almalinux default_transport = smtp relay_transport = smtp

AI Overview
Setting default_transport = smtp and relay_transport = smtp in Postfix defines how mail is routed out of your server. 

Ref: 
> Postfix Configuration Parameters https://www.postfix.org/postconf.5.html
> https://www.postfix.org/transport.5.html
> How to Configure SMTP Relays on a Linux Server https://truehost.com/support/knowledge-base/how-to-configure-smtp-relays-on-a-linux-server/
> Basic Settings in the Postfix main.cf file https://docs.rackspace.com/docs/basic-settings-in-the-postfix-maincf-file


What These Parameters Mean

• **default_transport (smtp)**: This is the default mailer/transport used for remote delivery to standard external destinations when no specific rule overrides it (the default is smtp:). Postfix will directly connect to the destination domain's MX records over SMTP.
• **relay_transport (smtp)**: This is used for remote delivery to domains listed in relay_domains (the default is relay: which uses the relay mailer, queuing or relaying differently). Setting it to smtp routes mail destined for relay domains using the standard smtp client instead of the specialized relay transport.


Difference Between These and relayhost

• Setting default_transport = smtp and relay_transport = smtp does not automatically route your mail through an external smart host/relay server (like SendGrid, Mailgun, or an enterprise relay). It just tells Postfix to use the direct smtp delivery agent.
• If you want all outgoing mail to pass through a central relay host or smart host (e.g., smtp.example.com on port 587) rather than doing direct-to-MX lookups, you should configure:

```ini
relayhost = [smtp.example.com]:587
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_tls_security_level = encrypt
```

/var/log/maillog (unlike Debian/Ubuntu's /var/log/mail.log). Remember to run sudo systemctl restart postfix after making changes to /etc/postfix/main.cf.



***

## Postfix install and basic setup

> https://gist.github.com/henriquebastos/9646478

```bash
#################
# Validate Args #
#################
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 FQDN EMAIL"
    exit 1
fi


# Postfix
SERVER_FQDN="$1"
SERVER_EMAIL="$2"

cat > /var/cache/debconf/postfix.preseed <<EOF
postfix postfix/chattr  boolean false
postfix postfix/destinations    string  $SERVER_FQDN
postfix postfix/mailbox_limit   string  0
postfix postfix/mailname    string  $SERVER_FQDN
postfix postfix/main_mailer_type    select  Internet Site
postfix postfix/mynetworks  string  127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128
postfix postfix/protocols   select  all
postfix postfix/recipient_delim string  +
postfix postfix/root_address    string  $SERVER_EMAIL
EOF

if [ ! -d /etc/postfix ]
then
    mkdir -p /etc/postfix
fi

cat > /etc/postfix/main.cf <<EOF
# See /usr/share/postfix/main.cf.dist for a commented, more complete version


# Debian specific:  Specifying a file name will cause the first
# line of that file to be used as the name.  The Debian default
# is /etc/mailname.
#myorigin = /etc/mailname

smtpd_banner = $myhostname ESMTP $mail_name (Ubuntu)
biff = no

# appending .domain is the MUA's job.
append_dot_mydomain = no

# Uncomment the next line to generate "delayed mail" warnings
#delay_warning_time = 4h

readme_directory = no

# TLS parameters
smtpd_tls_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
smtpd_tls_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
smtpd_use_tls=yes
smtpd_tls_session_cache_database = btree:${data_directory}/smtpd_scache
smtp_tls_session_cache_database = btree:${data_directory}/smtp_scache

# See /usr/share/doc/postfix/TLS_README.gz in the postfix-doc package for
# information on enabling SSL in the smtp client.

myhostname = $SERVER_FQDN
alias_maps = hash:/etc/aliases
alias_database = hash:/etc/aliases
myorigin = /etc/mailname
mydestination = $SERVER_FQDN, localhost
relayhost =
mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128
mailbox_size_limit = 0
recipient_delimiter = +
inet_interfaces = loopback-only
inet_protocols = all

EOF

debconf-set-selections /var/cache/debconf/postfix.preseed
apt-get -q -y -o DPkg::Options::=--force-confold install postfix
apt-get -q -y install mailutils
```
