> Ref:
> https://www.claudiokuenzler.com/blog/1360/where-is-mailx-command-rocky-linux-el-9-s-nail-package

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
