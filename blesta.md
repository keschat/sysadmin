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

To investigate and find exactly where Blesta is sending these 200 emails on your DirectAdmin server, you need to look at both the DirectAdmin mail server (Exim) logs and Blesta's internal logs.DirectAdmin generates automated warnings like "Warning: 200 E-Mails have just been sent by..." when a specific user or account hits its daily threshold. Here is how you can track down those emails:

- ### 1. Check the DirectAdmin Mail Server (Exim Logs)
