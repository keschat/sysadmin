## Allow the Blesta server to talk to the DirectAdmin API

certbot --nginx -d sub.domain.net

semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/uploads(/.*)?"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/logs_blesta(/.*)?"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/my/cache(/.*)?"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/my/config(/.*)?"

restorecon -Rv /var/www/my

*/5 * * * * /usr/bin/php /var/www/my/index.php cron

****

## how can i check where blesta is ending 200 emails to directadmin server

To investigate and find exactly where Blesta is sending these 200 emails on your DirectAdmin server, you need to look at both the DirectAdmin mail server (Exim) logs and Blesta's internal logs.

DirectAdmin generates automated warnings like **"Warning: 200 E-Mails have just been sent by..."** when a specific user or account hits its daily threshold. Here is how you can track down those emails:

- ### 1. Check the DirectAdmin Mail Server (Exim Logs)

DirectAdmin uses **Exim** as its default mail agent. You can track down the exact recipients, timestamps, and subjects using SSH as the root user:

> Ref:
> https://forum.directadmin.com/threads/email-sending-and-receiving-issue.65649/ <br>
> https://orissawebhosting.in/knowledgebase/log-file-location-in-directadmin/

- **View live or recent email traffic:** Run tail to see emails as they process:
```bash
tail -n 500 /var/log/exim/mainlog
```

- **Search logs by the sending email address:** Replace yourbilling@domain.com with the email address configured in Blesta:
```bash
grep "yourbilling@domain.com" /var/log/exim/mainlog
```

- **Track a specific message lifecycle:** If you find a specific message ID (e.g., 1sNDnI-000000-XX), use exigrep to aggregate all relevant lines for that specific email transaction:
```bash
exigrep "1sNDnI-000000-XX" /var/log/exim/mainlog
```
 > Ref:
 > https://forum.directadmin.com/threads/user-account-emails-not-sending-out.68132/ <br>
 > https://forum.directadmin.com/threads/exim-emails-not-resending-after.49223/ <br>
 > https://forum.directadmin.com/threads/new-message-warning-200-e-mails-have-just-been-sent-by-myemail-mydomain-com.61425/

- ### 2. Check the Mail Queue in the DirectAdmin Panel

If the emails are still processing or are being delayed, they will be sitting in your server's queue:

 > Ref:
 > https://forum.directadmin.com/threads/account-just-send-100-email-set-to-200.66977/

1. Log into your **DirectAdmin** panel as Admin.
2. Navigate to **Admin Tools** > **Mail Queue Administration**.
3. Look for patterns in sender or recipient addresses. Click on any message to view its headers, which will reveal exactly where it is heading and what content it contains.

 > Ref:
 > https://docs.directadmin.com/other-hosting-services/exim/maintaining-email-queue.html <br>
 > https://forum.directadmin.com/threads/new-message-warning-200-e-mails-have-just-been-sent-by-myemail-mydomain-com.61425/ <br>
 > https://bobcares.com/blog/directadmin-mail-queue-administration/

- ### 3. Check the Logs Directly Inside BlestaBlesta maintains internal records of all outgoing correspondence. You can check this from the admin panel to correlate with your server spikes

Blesta maintains internal records of all outgoing correspondence. You can check this from the admin panel to correlate with your server spikes:

 > Ref:
 > https://docs.blesta.com/integrations/plugins/mass-mailer/

1. Log into your **Blesta Admin Portal**.
2. Go to **Tools** > **Logs**.
3. Look under the **Email Log** tab. This displays a paginated list of all emails dispatched by the core system or plugins, complete with the recipient's email address, subject line, and delivery status.
 > Ref:
 > https://source-docs.blesta.com/classes/Logs.html <br>
 > https://docs.blesta.com/support/releases/4/470/ <br>
 > https://docs.supportpal.com/current/Blesta+Information

## Why is Blesta sending 200 emails?

Common culprits for a sudden burst of emails from Blesta include:

- **The Daily Automation Cron:** Blesta runs cron tasks to process daily renewals, invoice generations, late notices, and service suspensions. If you have many active clients or late invoices, this can easily trigger a surge of emails.
  > Ref: https://docs.blesta.com/support/moving-blesta/
- **Mass Mailer Plugin:** Check if another admin or staff member ran a marketing or system update campaign via the Mass Mailer plugin.
  > Ref: https://docs.blesta.com/integrations/plugins/mass-mailer/
- **Email Loop / Verification Spike:** An automated setup configuration rule could be cycling (e.g., automated email verification triggers or stuck ticket notifications in Support Manager).
  > Ref:
  > https://docs.blesta.com/support/releases/4/4120/ <br>
  > https://docs.blesta.com/support/releases/4/470/






