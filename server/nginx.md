> Ref: https://portal.smartertools.com/kb/a3652/configure-an-alternative-linux-web-server-for-smartermail.aspx

**Ubuntu Setting up Nginx**

1. Install NGINX, if it isn’t installed already using the following:
```bash
sudo apt install nginx
```

2. Create a new config file at /etc/nginx/sites-available/ named after your site

3. Create a symlink to enable the new site:
```bash
sudo ln -s /etc/nginx/sites-available/_YOUR_SITE_ /etc/nginx/sites-enabled
```

4. Disable the default site if not needed:
```bash
rm /etc/nginx/sites-enabled/default
```

5. Validate Nginx config
```bash
sudo nginx -t
```

6. Start Nginx services
```bash
sudo service nginx start
```

7. Enable Nginx to start on boot:
```bah
sudo systemctl enable nginx
```

**Ubuntu Setting up Apache**

1. Install apache
```bash
sudo apt install apache2
```

2. Create a new config file at /etc/apache2/sites-available/ named after your site with a .conf extension (e.g. domain.com.conf) 

3. Create a symlink to enable the new site:
```bash
sudo ln -s /etc/apache2/sites-available/_YOUR_SITE_ /etc/apache2/sites-enabled
```

4. Disable the default site if not needed:
```bash
rm cd /etc/apache2/sites-enabled/000-default.conf
```

5. Validate Apache config:
```bash
sudo apache2ctl configtest
```

6. Make sure the SSL module is enabled in Apache:
```bash
sudo a2enmod ssl
```

7. Start Mail and Apache services: 
```bash
sudo service smartermail start sudo service apache2 start
```

8. Enable Apache to start on boot:
```bash
sudo systemctl enable apache2
```
