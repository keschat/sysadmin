## Firewall Configuration

> **Axigen Documentation**
> https://www.axigen.com/documentation/firewall-configuration-p45255022

**Add the new zone**
```bash
firewall-cmd --permanent --new-zone=ha
firewall-cmd --reload
```

We should check if the new zone was configured properly with the following command:
```bash
firewall-cmd --zone=ha --list-all
ha (active)
  interfaces: enp0s3
  sources:
  services:
  ports:
  masquerade: no
  forward-ports:
  icmp-blocks:
  rich rules:
```
_Note: Do not continue if the new zone is not marked as active and the interface designated for cluster communication is not included in its interfaces._

Allow DRBD and cluster communication through the new configured zone:
```bash
firewall-cmd --permanent --zone=ha --add-port=7788/tcp
firewall-cmd --permanent --zone=ha --add-service=high-availability
firewall-cmd --reload
```

Allow Axigen services communication through the default public zone (for example for WebMail, IMAP, POP3, SMTP and WebAdmin), running the following commands:
```bash
firewall-cmd --permanent \
  --add-port=443/tcp --add-port=80/tcp  \
  --add-port=993/tcp --add-port=143/tcp \
  --add-port=465/tcp --add-port=25/tcp \
  --add-port=995/tcp --add-port=110/tcp \
  --add-port=9000/tcp
firewall-cmd --reload
```
