# Q. when postfix works as relay, what mappings are suitable for root, apache, nginx in /etc/potfix/generic

**AI Overview**      

When configuring Postfix as a relay host, local system accounts like **root**, **apache**, and **nginx** often generate outbound emails (e.g., cron jobs, system alerts, or web application notifications) with invalid internal domains like `root@localhost` or `apache@yourhostname.local`.

Most external relay services (like SendGrid, Mailgun, or AWS SES) will reject these because the domains are unroutable. The `/etc/postfix/generic` file fixes this by rewriting local sender addresses into **valid, fully-qualified domain names (FQDN)** that you own and have configured with proper SPF/DKIM records.

**Recommended Mappings for** `/etc/postfix/generic`

Here is a standard, production-ready mapping structure:
```txt
# Local Address                     # Valid Outbound Relay Address
root                                system-alerts@yourdomain.com
root@localhost                      system-alerts@yourdomain.com
root@localhost.localdomain          system-alerts@yourdomain.com
root@yourhostname.local             system-alerts@yourdomain.com

apache                              web-app@yourdomain.com
apache@localhost                    web-app@yourdomain.com
apache@yourhostname.local           web-app@yourdomain.com

nginx                               web-alerts@yourdomain.com
nginx@localhost                    web-alerts@yourdomain.com
nginx@yourhostname.local           web-alerts@yourdomain.com
```

**Strategic Mapping Choices (Trade-offs)**

You have two main strategies for mapping these addresses depending on how granular you want your logging and filtering to be:

| Strategy | generic Mapping Example | Best Used For... | Pros & Cons |
| --- | --- | --- | --- |
|**Separated Accounts** (Recommended) | root →  <br/> sysadmin@domain.com <br/> apache → <br/> www-data@domain.com | Production environments running critical web applications. | **Pros:** Easy to create email filters and identify if a specific web server or system cron is failing. <br/> **Cons:** Requires managing multiple email aliases on your receiving mail server. | 
| **Single Catch-All Alias** | root → <br/> noreply@domain.com <br/> apache → <br/> noreply@domain.com | Staging environments, simple setups, or when your relay billing tiers charge per unique sender address. | **Pros:** Simple setup; only one external email address needs authorization. <br/> **Cons:** Harder to quickly distinguish system failures from application bugs at a glance. |

**How to Apply These Changes**
To make Postfix actively use these mappings, ensure the following steps are completed on your server:

1. **Enable the generic map in Postfix:** Open `/etc/postfix/main.cf` and ensure this line is active:
```text
smtp_generic_maps = hash:/etc/postfix/generic
```
2. **Compile the lookup table:** Every time you edit the `/etc/postfix/generic file`, you must run postmap to generate the .db file:
```bash
sudo postmap /etc/postfix/generic
```
3. **Reload Postfix:** Reload the service to apply the configuration:
```bash
sudo systemctl reload postfix
```






