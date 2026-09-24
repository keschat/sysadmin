## almalinux telnet replacement

> Ref: <br/>
> https://www.redhat.com/en/blog/stop-using-telnet-test-port <br/>
> https://www.emreguclu.io/linux/networking/troubleshooting/2024/10/02/telnet-alternatives-for-port-testing-in-linux.html <br/>
> https://medium.com/geekculture/linux-useful-tricks-telnet-alternatives-ed9f342149a1 <br/>
> https://linux.how2shout.com/how-to-install-telnet-on-almalinux-9/ <br/>
> https://mainvps.net/blog/best-telnet-alternatives-linux/ <br/>
> https://www.siberoloji.com/setup-network-settings-almalinux/ <br/>
> https://forums.rockylinux.org/t/rocky-9-and-telnet-missing/6604

**AI Overview**        

Secure alternatives to Telnet on AlmaLinux depend on whether you are doing remote login management or testing network ports.

### Remote Login and Management

- **SSH (Secure Shell):** Use **OpenSSH** (`ssh user@host`) as the direct, encrypted replacement for remote shell access. It is installed by default on AlmaLinux passwords and data.
  > Ref: <br/>
  > https://www.youtube.com/watch?v=2WS3CWUUmxM <br/>
  > https://www.manageengine.com/vulnerability-management/misconfiguration/linux-insecure-services/how-to-disable-telnet-in-linux.html

### Network and Port Troubleshooting

- **Ncat / Netcat (`nc`)**: Use [Netcat](https://unix.stackexchange.com/questions/479710/what-are-the-alternatives-for-checking-open-ports-besides-telnet) (`nc -zv host port`) to check if a remote TCP port is open. Install it via `sudo dnf install ncat`.
- **Curl (`curl`):** Use `curl -v telnet://host:port` or test HTTP/HTTPS endpoints directly to check if a service responds.
- **Nmap (nmap):** Use `nmap -p port host` for advanced scanning and port state verification. Install it via `sudo dnf install nmap`.
- **Bash Built-in:** Use `cat < /dev/tcp/host/port` in Bash to quickly test if a TCP connection succeeds without installing extra packages.
