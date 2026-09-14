To show firewall rules on AlmaLinux, the primary command is `sudo firewall-cmd --list-all`, which displays active zones, services, ports, and rich rules. AlmaLinux uses `firewalld` by default, managed via `firewall-cmd`. To verify if the firewall is active, use `systemctl status firewalld`.

Essential Firewall Commands (`firewalld`)

* **List all active rules:** `sudo firewall-cmd --list-all`.
* **List rules for a specific zone:** `sudo firewall-cmd --zone=public --list-all`.
* **List allowed services:** `sudo firewall-cmd --list-services`.
* **List allowed ports:** `sudo firewall-cmd --list-ports`.
* **Show active zones:** `sudo firewall-cmd --get-active-zones`.
* **List rich rules:** `sudo firewall-cmd --list-rich-rules`.
  
Other Useful Commands

* **Check firewall status:** `systemctl status firewalld`.
* **List iptables rules (raw format):** `sudo iptables -L -v -n`. ![Bobcares](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAADEElEQVQ4jX2TT2gUZxjGn2/2W2eT2U0mmdXu2iSaf3YbEhvUQhRLaaFHD3oxiIdSaNC2eBCpeqkEbWnTGqQEMSl48SKCop4a2lqNGLVUELHNZpPoRrPJJrvZ7M7fnZ355uspAylNn/P7/nhenvchnHMCAOTCTVnSjAbDm07yM2fc9sHr3dOTy88h0xD/7hMd64j4gP67tF3SxkTmdmbUQu+7rW0fP5yafMQYDxOwEX3gs+z/AgAg0n9lU6cSz5q5jBuJbU4m0y+idbIyr5eNP8z8Qkp164f4cJ+7BvDOyOi+asa/McpOAyCkOMf2hnA4VHEcrGglbHlzM2YXFzE58fRPElF+dg31QybgmcMDp/jwSdV3UHvsfK+ovDHYtjEeEzwOZmhobmzEgmrAtm3otomX82lIYlWZed5Xue+P/gAAwqqV9/fuKXc1xovLRsHUnQpM7uHV4hKCQgBWpQwxKCIqR2HZdkgrLg/QT7/uBQC6Cng8dv+AEnCKv3/Rk7idKuFxxkKYVqCIKi7O6tAtC0Ipj/DSLCTXhhpt6ib9/dd8wNTn7fLVX2Z6snmKbcEqxMM5fPReArrN0B0PYW5Fx/CNv1As67BqoqCOfSIyxQv+CQKtampva4MgSiCUoqVrN8afTOC38Rfw8gZqs7O4e2QHQrWy64Qkj1FxjNHQrz4gINWktWIGtq6iWgrj1csZTE7nkOjcgfpNMby96wM8eDqNvdubTDckAeA3qFWK+SkYM6NJArJN1UxklgqISwGIch2evBawpbkV6VQSz+9dh1Jf48qtLUP77zvn+NDpgg/Q/741TwQh5n+I58HjHrgQQGomg8aYDKblkUml4HpE3X30R3lNCl5FuwMSPFSxLLgcICCglCK7mIUSDCIsUph2FUBIpS4WP7y65wNqNohHiobWQQK8OwgCTdXgWDY2RqpBBQ5nOYNSfkUNmsrWxP7Txf/sAgCUHv50gnH3W3AugHsgjAGuA1XV9XKFffnWwbOX1i3Tqgpjgw2CFzhOOOsASNG2yndez6Uv7+wbdv89+w+XlINsYDkhDwAAAABJRU5ErkJggg==)Bobcares +2

If you are using a specific zone other than public, replace `public` in the commands above with the relevant zone name (e.g., `work`, `home`, `trusted`). 
