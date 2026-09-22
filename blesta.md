Allow the Blesta server to talk to the DirectAdmin API

certbot --nginx -d sub.domain.net

semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/uploads(/.*)?"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/logs_blesta(/.*)?"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/my/cache(/.*)?"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/my/config(/.*)?"

restorecon -Rv /var/www/my

*/5 * * * * /usr/bin/php /var/www/my/index.php cron
