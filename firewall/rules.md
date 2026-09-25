# Rules

Q. cpguard i need to allow the following in netcup and also my directadmin server:

  1. Whitelist our IPs given below in your server and network firewall. They must be able to connect to the agent service running on TCP port 9098 on your server.
   - 137.184.200.210
   - 159.89.87.35
   - 167.99.149.179
  2. No other process is using port 9098 on your server

A. Yes. For CPGuard, you need to allow **TCP/9098 inbound** from those three source IPs at **both layers**:

1. **Netcup firewall**
2. **DirectAdmin server firewall** (likely firewalld/CSF depending on your setup)

And separately verify that **nothing else is listening on TCP 9098**.

For your DirectAdmin server, I’d configure this as a **source-restricted rule**, not simply open 9098/tcp to the Internet.
