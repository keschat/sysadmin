Cloudlinux

## Next diagnostic step

Please run the following commands as your beeztfsrvadmin user:
```bash
command -v cldetect

sudo cldetect --detect-cp-full

sudo cldetect --get-admin-email

sudo grep -nE 'EMAIL|CP|_getemail_script' /etc/sysconfig/cloudlinux 2>/dev/null
```

Then inspect the CloudLinux configuration:

Why these matter: CloudLinux documents cldetect as a tool for identifying the control panel and retrieving the control-panel administrator email. Its license_check configuration also supports a panel-specific email script when one is available. 
CloudLinux Documentation
+1

Once you provide the output, we can determine whether your installation has a DirectAdmin-specific email lookup configured, or whether the administrator email needs to be configured through another supported mechanism.
