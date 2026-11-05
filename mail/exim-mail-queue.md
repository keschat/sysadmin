# Comprehensive Guide: Managing and Troubleshooting the Exim Mail Queue

This guide covers essential commands for inspecting, searching, and managing the Exim mail queue, along with troubleshooting steps for common delivery issues.

---

## 1. Queue Inspection Basics

To get a quick overview of your mail queue volume and structure, use these fundamental commands. Root privileges via SSH are required.

* **Count messages in queue:** Displays a single integer showing the total number of items currently waiting.
  ```bash
  exim -bpc
  ```
* **List all queued messages:** Displays a detailed list including message age, size, unique Message ID, sender, and recipient.
  ```bash
  exim -bp
  ```
* **Summarise queue by domain:** Pipes the queue list into `exiqsumm` to show a breakdown of messages grouped by target domain, including the oldest message age.
  ```bash
  exim -bp | exiqsumm
  ```

---

## 2. Advanced Searching with `exiqgrep`

When dealing with large queues, `exiqgrep` allows you to filter messages based on specific criteria.

* **Search by sender address:**
  ```bash
  exiqgrep -f user@example.com
  ```
* **Search by recipient address:**
  ```bash
  exiqgrep -r recipient@domain.co.za
  ```
* **List frozen messages only:** Frozen messages are emails that Exim has stopped trying to deliver automatically due to permanent failures.
  ```bash
  exiqgrep -z
  ```
* **Output Message IDs only:** Useful for combining with loops or `xargs` to perform bulk actions (e.g., `-zi` targets only frozen message IDs).
  ```bash
  exiqgrep -i
  ```
* **Search for messages older than a specific time:** (e.g., older than 86400 seconds / 24 hours):
  ```bash
  exiqgrep -o 86400
  ```

---

## 3. Inspecting Individual Messages

Every message in the queue is assigned an alphanumeric **Message ID** (e.g., `1a2B3C-0004xx-XX`). Use this ID to look inside the message files without modifying them.

* **View message headers:** Helpful for inspecting the `From`, `To`, `Subject`, and routing path headers.
  ```bash
  exim -Mvh MESSAGE_ID
  ```
* **View message body:** Displays the raw text content of the email payload.
  ```bash
  exim -Mvb MESSAGE_ID
  ```
* **View specific message logs:** Shows the internal transaction history and delivery attempts for that specific ID.
  ```bash
  exim -Mvl MESSAGE_ID
  ```

---

## 4. Queue Management & Actions

Use these commands to force delivery, remove messages, or manage delivery attempts.

* **Force delivery attempt on a single message:**
  ```bash
  exim -M MESSAGE_ID
  ```
* **Force a full queue run:** Tells Exim to attempt delivery for every message currently in the queue.
  ```bash
  exim -qf
  ```
* **Remove a message from the queue (No bounce):** Deletes the message silently without notifying the sender.
  ```bash
  exim -Mrm MESSAGE_ID
  ```
* **Bulk delete all frozen messages:**
  ```bash
  exiqgrep -z -i | xargs exim -Mrm
  ```
* **Thaw a frozen message:** Forces Exim to change the status back to active so it can attempt delivery again.
  ```bash
  exim -Mt MESSAGE_ID
  ```

---

## 5. Identifying Outbound Spam Scripts

If your queue spikes unexpectedly, it is often due to a compromised CMS web script (like WordPress or Joomla) sending unauthorized outbound spam.

* **Find the most active sending directories:** Look inside the headers of queued messages to find the `cwd` (current working directory) from which the email script was executed.
  ```bash
  exim -bpr | grep 'cwd=' | awk '{print $3}' | sort | uniq -c | sort -n
  ```
* **Trace the script filename:** Run an inspection on a message header (`exim -Mvh MESSAGE_ID`) and look for specific X-PHP-Script headers or custom mailer configurations:
  ```text
  X-PHP-Originating-Script: 1001:spam_mailer.php
  ```
* **Track real-time injections via Exim mainlog:** Filter the live log for active web server submissions (usually submitted via the `local` or `as` protocol rather than remote SMTP).
  ```bash
  tail -f /var/log/exim_mainlog | grep -E "U=www-data|U=apache"
  ```

---

## 6. Suspending and Blocking Compromised Accounts

When an individual SMTP user account has its password leaked or cracked, a spammer will flood the queue using legitimate authentication credentials.

### Identification
Find the authenticated user account causing the problem by querying your active queue:
```bash
exim -bpr | grep 'A=' | awk '{print $2, $3, $4}' | sort | uniq -c | sort -n
```
*(Look for strings like `A=login:spammed_user@domain.com`)*

### Action: Drop Existing Queue Messages from the User
Once the target user is identified, clear all their pending messages out of the queue immediately:
```bash
exiqgrep -i -f spammed_user@domain.com | xargs exim -Mrm
```

### Action: System Block Options
1. **cPanel/WHM System:** Navigate to *Email Accounts*, click *Manage* next to the account, and set **Sending** to **Suspend**. Alternately, use the WHM API:
   ```bash
   uapi --user=USERNAME Email suspend_outgoing user='spammed_user@domain.com'
   ```
2. **DirectAdmin System:** Add the user to the blocked list file:
   ```bash
   echo "spammed_user@domain.com" >> /etc/virtual/blacklist_usernames
   ```
3. **Vanilla Exim System:** Add a drop condition inside the `acl_check_rcpt` section of your `/etc/exim/exim.conf` file:
   ```text
   deny
     authenticated = *
     condition     = ${if eq{$authenticated_id}{spammed_user@domain.com}}
     message       = This account has been temporarily suspended for abuse.
   ```

---

## 7. Enforcing Outbound Email Rate Limits

To prevent any single user or site from destroying your server's IP reputation, implement hourly rate limiting.

### Configuration via Exim.conf (Ratelimit ACL)
Add a tracking rule inside the `acl_check_not_smtp` (for web scripts) and `acl_check_rcpt` (for SMTP users) blocks of your `/etc/exim/exim.conf` file:

```text
# Limit authenticated SMTP users to 200 emails per hour
deny
  authenticated = *
  ratelimit     = 200 / 1h / per_rcpt / strict / $authenticated_id
  message       = Message dropped. Your account ($authenticated_id) has exceeded the hourly limit of 200 emails.

# Limit local web server processes (e.g., Apache/php) to 100 emails per hour
deny
  authenticated = !*
  ratelimit     = 100 / 1h / per_rcpt / strict / $sender_ident
  message       = Message dropped. Local script system has exceeded the hourly sending quota.
```
*Remember to restart the service to apply changes:* `systemctl restart exim`

### Platform-Specific Shortcuts
* **cPanel/WHM:** Go to *WHM -> Tweak Settings -> Mail* and adjust **Max hourly emails per domain**.
* **DirectAdmin:** Edit `/etc/virtual/limit` (global limit) or `/etc/virtual/limit_username` (user-specific limit) and specify an integer.

---

## 8. Monitoring Logs for SMTP Delivery Errors

To diagnose why emails are stuck in the queue instead of routing successfully, you must inspect `/var/log/exim_mainlog`.

### Useful Log Grep Commands
* **Find permanent delivery failures (5xx Errors / Denied):**
  ```bash
  grep "**" /var/log/exim_mainlog | less
  ```
* **Find temporary delivery deferrals (4xx Errors / Rate Limits/ Greylisting):**
  ```bash
  grep "==" /var/log/exim_mainlog | less
  ```
* **Find successful deliveries (for volume verification):**
  ```bash
  grep "=>" /var/log/exim_mainlog | less
  ```

### Common Log Flag Reference
* **`==`**: Deferral. Exim will retry later. Common triggers include remote target greylisting or temporary network timeouts.
* **`**`**: Permanent Failure. The message is frozen or returned to the sender. Common triggers include *550 User Unknown* or SPF/DKIM verification hard rejects.

---

## 9. Configuring a Fallback Smarthost Relay

If your server's public IP address becomes blacklisted or blocked, you can configure Exim to automatically route all or some queued emails via an external authenticated relay (like SendGrid, Mailgun, or another gateway).

### Configuration Setup
Edit your `/etc/exim/exim.conf` file to declare a fallback router and transport mechanism.

1. **Add the Router (under the `begin routers` section):**
   Place this router directly before your standard remote outbound router (`lookuphost` / `dnslookup`):
   ```text
   smarthost_fallback:
     driver = manualroute
     domains = ! +local_domains
     transport = smarthost_smtp
     route_data = smtp.relayprovider.com
     no_more
   ```

2. **Add the Transport (under the `begin transports` section):**
   ```text
   smarthost_smtp:
     driver = smtp
     port = 587
     hosts_require_auth = *
   ```

3. **Add Credentials (under the `begin authenticators` section):**
   ```text
   smarthost_login:
     driver = plaintext
     public_name = LOGIN
     client_send = : your_relay_username : your_relay_password
   ```
*Always validate configuration and reload:* `exim -bV && systemctl restart exim`

---

## 10. Automating Frozen Mail Cleanup (Cron Job)

Leaving hundreds of thousands of frozen emails in the queue degrades Exim's performance. You can set up a scheduled cron job to clear them periodically.

1. Open the root crontab editor:
   ```bash
   crontab -e
   ```
2. Append the following configuration line to purge frozen messages automatically **every night at midnight**:
   ```cron
   0 0 * * * /usr/sbin/exiqgrep -z -i | xargs /usr/sbin/exim -Mrm > /dev/null 2>&1
   ```
   *Note: Ensure you use the absolute paths for `/usr/sbin/exiqgrep` and `/usr/sbin/exim` within cron environments.*

---

## 11. Web References & Official Documentation

For further reading and configuration variables, consult the official documentation:

* [Exim Official Specification - Chapter 5: The Exim Command Line](https://www.exim.org/exim-html-current/doc/html/spec_html/ch-the_exim_command_line.html)
* [Exim Official Specification - Chapter 20: The manualroute router](https://www.exim.org/exim-html-current/doc/html/spec_html/ch-the_manualroute_router.html)
* [Exim Official Specification - Chapter 42: Access Control Lists (Ratelimiting)](https://www.exim.org/exim-html-current/doc/html/spec_html/ch-access_control_lists.html)
* [Exim Official Specification - Chapter 53: Exim Utilities (exiqgrep and exiqsumm)](https://www.exim.org/exim-html-current/doc/html/spec_html/ch-exim_utilities.html)
* [DirectAdmin Knowledgebase - Managing the Mail Queue](https://docs.directadmin.com/)
