How do I test email receiving and sending?

> Ref: <br/>
> https://support.cpanel.net/hc/en-us/articles/360048611754-How-do-I-test-email-receiving-and-sending
> https://www.exim.org/exim-html-current/doc/html/spec_html/ch-exim_utilities.html#SECTextspeinf

If you're having trouble sending or receiving e-mail, you can find out what the problem is using exigrep.
Exigrep is a Perl script that allows you to search for a string in the exim logs and return the log entries that match.

In this example, I am searching for e-mails containing `test2@example.com`:
```bash
[root@cent6 ~]# exigrep test2@example.com /var/log/exim_mainlog
2020-05-29 10:51:00 1jecbM-0001WB-R9 <= cpanel@example.com H=(localhost.localdomain) [127.0.0.1]:33146 P=esmtpa A=dovecot_plain:__cpanel__service__auth__icontact__1xm1i7r5wstdk9g0 S=51873 id=1590749460.fNfzowf2lyA1yArj@cent6.sean.com T="[example.com] Email configuration settings for \342\200\234test2@example.com\342\200\235." for test2@example.com
2020-05-29 10:51:01 1jecbM-0001WB-R9 => test2 <test2@example.com> R=virtual_user T=dovecot_virtual_delivery C="250 2.0.0 <test2@example.com> cPbhORTp0F7BFgAAgiGGmw Saved"
2020-05-29 10:51:01 1jecbM-0001WB-R9 Completed

2020-05-29 10:51:50 1jeccA-0001XD-8c <= test1@example.com H=(cent6.sean.com) [127.0.0.1]:39856 P=esmtpa A=dovecot_login:test1@example.com S=576 id=b859f502e3ca07fed6e3610ad2144126@example.com T="Exigrep demonstration" for test2@example.com
2020-05-29 10:51:50 1jeccA-0001XD-8c => test2 <test2@example.com> R=virtual_user T=dovecot_virtual_delivery C="250 2.0.0 <test2@example.com> EIkwGEbp0F7BFgAAgiGGmw Saved"
2020-05-29 10:51:50 1jeccA-0001XD-8c Completed

[root@cent6 ~]#
```

You can also use exigrep to look for titles of e-mails:
```bash
[root@cent6 ~]# exigrep demonstration /var/log/exim_mainlog
2020-05-29 10:51:50 1jeccA-0001XD-8c <= test1@example.com H=(cent6.sean.com) [127.0.0.1]:39856 P=esmtpa A=dovecot_login:test1@example.com S=576 id=b859f502e3ca07fed6e3610ad2144126@example.com T="Exigrep demonstration" for test2@example.com
2020-05-29 10:51:50 1jeccA-0001XD-8c => test2 <test2@example.com> R=virtual_user T=dovecot_virtual_delivery C="250 2.0.0 <test2@example.com> EIkwGEbp0F7BFgAAgiGGmw Saved"
2020-05-29 10:51:50 1jeccA-0001XD-8c Completed

[root@cent6 ~]#
```
