## Securing DirectAdmin

https://docs.directadmin.com/directadmin/general-usage/securing-da-panel.html

***

## Restart Directadmin

You can restart DirectAdmin by running `systemctl restart directadmin` or `service directadmin restart` via SSH as the root user.

***

## Main DirectAdmin configuration file

> https://docs.directadmin.com/directadmin/general-usage/configuring-da.html

Besides of options listed in the directadmin.conf, the panel itself uses some pre-defined defaults. To list all current configuration options:
```bash
/usr/local/directadmin/directadmin config
```
or short form:
```bash
da c
```
If you are looking for a specific option, just grep it, like so (using 'letsencrypt' as an example):
```bash
/usr/local/directadmin/directadmin config | grep letsencrypt
```

Instead of editing the directadmin.conf directly, you may use the `da config-set` functionality to change the options:
```bash
# before v1.710
da config-set NAME VALUE
# since v1.710
da config-set NAME VALUE
da config-set NAME=VALUE
```
Add `--restart` flag to have directadmin restarted. Since v1.710, directadmin.service is reloaded/restarted by default, this can be turned off with `--no-reload` flag.

For example, to `set dns_ttl` to `1`, execute the commands:
```bash
# before v1.710
da config-set dns_ttl 1             # manual reload required
da config-set dns_ttl 1 --restart 
# since v1.710
da config-set dns_ttl 1
da config-set dns_ttl=1
da config-set dns_ttl=1 --no-reload # manual reload required
```
_If the setting has been changed successfully, directadmin will exit with code 0._

***

## How to change the Return Path for diradmin emails

Use the new `diradmin_envelope` option, which allows you to override the default "diradmin@host.name.com" in the Return-Path as desired:
```bash
da config-set diradmin_envelope your@email.com
systemctl restart directadmin
```
_By default, this is disabled and relies on your hostname being set up/resolving correctly._








