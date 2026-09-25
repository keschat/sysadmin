S-mailx (aka s-nail)
S-mailx is an active fork of Heirloom mailx which ceased development around 2010. 
```bash
$ docker compose exec vw-backup bash
$ printenv MAIL_SMTP_VARIABLES
-S 'v15-compat' -S 'mta=smtp://smtp.example.com:587' -S 'smtp-use-starttls' -S 'smtp-auth=login' -S 'user=no-reply@example.com' -S 'password=changeit' -S 'from=no-reply@example.com'

$ mail -S 'v15-compat' -S 'mta=smtp://smtp.example.com:587' -S 'smtp-use-starttls' -S 'smtp-auth=login' -S 'user=no-reply@example.com' -S 'password=changeit' -S 'from=no-reply@example.com test@example.com'
```

> Ref:
> https://www.claudiokuenzler.com/blog/1360/where-is-mailx-command-rocky-linux-el-9-s-nail-package
> https://wiki.sdf.org/doku.php?id=s-mailx

**mailx missing:**
```bash
[beeztfsrvadmin@de-web01 ~]$ sudo dnf search mailx
Last metadata expiration check: 0:52:17 ago on Fri 25 Sep 2026 13:54:15 SAST.
No matches found.
```

**Install s-nail is missing:**
```bash
dnf install s-nail
```

**Send mails with s-nail:**
```bash
echo "Message body" | s-nail -s "Subject" dest@domain.tld
```

**View logs:**
```bash
tail /var/log/mailog
```

**Sending mails without local MTA:**
```bash
echo "Message body" | s-nail -s "Subject" -S mta=smtp://relay.domain.tld:587 -r "noreply@send.domain.tld" dest@domain.tld 
```
