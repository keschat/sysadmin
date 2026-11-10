#!/bin/bash
# Runs after an email account is created.
# DA provides: $domain, $user (the part before @), $passwd, $quota, $limit

NEWADDR="${user}@${domain}"
REPLY_TO="noreply@${domain}"
SENDER="noreply@${domain}"

# Subject with curly quotes, encoded as a MIME encoded-word (UTF-8, base64)
RAW_SUBJECT="[${domain}] Mail configuration settings for “${NEWADDR}”"
ENCODED_SUBJECT=$(printf '%s' "$RAW_SUBJECT" | base64 -w 0)
SUBJECT="=?UTF-8?B?${ENCODED_SUBJECT}?="

BOUNDARY="DA-Welcome-Email-Boundary-$(date +%s)"

# --- 1. PLAIN TEXT VERSION ---
read -r -d '' TEXT_MESSAGE << EOT
Mail Configuration settings for “${NEWADDR}”.

Webmail Direct Login
---------------------------
You can access your email dashboard directly via any browser.

* URL:       https://${domain}/webmail
* Username:  ${NEWADDR}
* Password:  Use the email account’s password.


Mail Client Manual Settings
---------------------------
Secure SSL/TLS Settings (Recommended)

Username:        ${NEWADDR}
Password:        Use the email account’s password.
Incoming Server: mail.${domain}
* IMAP Port:     993
* POP3 Port:     995

Outgoing Server: mail.${domain}
* SMTP Port:     465

IMAP, POP3, and SMTP require authentication.

---------------------------
Alternative: STARTTLS

Use these only if your mail client does not support SSL/TLS on
the ports above. The connection starts unencrypted and is then
upgraded to an encrypted one (STARTTLS). Choose "STARTTLS" as the
connection security in your mail client.

Username:        ${NEWADDR}
Password:        Use the email account’s password.
Incoming Server: mail.${domain}
* IMAP Port:     143 (STARTTLS)
* POP3 Port:     110 (STARTTLS)

Outgoing Server: mail.${domain}
* SMTP Port:     587 (STARTTLS)

IMAP, POP3, and SMTP require authentication.

Do not reply to this automated message.
EOT

# --- 2. HTML VERSION ---
read -r -d '' HTML_MESSAGE << EOT
<!DOCTYPE html>
<html>
<body style="background-color: #fff; color:#1b1b1b; margin:0; padding:0;font-family:-apple-system,BlinkMacSystemFont,'Segoe UI','Helvetica Neue',sans-serif">
    <div style="padding: 0;">
        <table cellpadding="10" cellspacing="0" border="0" width="100%">
            <tbody>
                <tr>
                    <td align="center">
                        <table cellpadding="0" cellspacing="0" border="0" width="680" style="max-width:680px; width:100%; text-align:left;">
                            <tbody>
                                <tr>
                                    <td>
                                        <div style="background-color: #f0f0f0; margin-bottom: 3px; padding: 10px;
                                        font-family:-apple-system,BlinkMacSystemFont,'Segoe UI','Helvetica Neue',sans-serif; font-size:16px;">
                                            Mail Configuration settings for <strong>“${NEWADDR}”</strong>.
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding: 20px; border: 1px solid #e6e6e6; border-bottom: 3px solid #676cc8;">
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" style="font-family:-apple-system,BlinkMacSystemFont,'Segoe UI','Helvetica Neue',sans-serif;">
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <!-- Webmail Access Box -->
                                                        <h2 style="font-size:20px; margin-top:0; color:#454545; font-weight: 500; border-bottom:1px solid #e4e4e7; padding-bottom:10px;">
                                                            Webmail Access
                                                        </h2>
                                                        <div style="background-color: #fafafa; border: 1px solid #538200; border-radius: 4px; padding: 15px; margin-bottom: 25px;">
                                                            <h3 style="color:#538200; margin-top:0; font-size:16px;">Direct Web Login</h3>
                                                            <p style="color: #3d4551; font-size:14px; margin: 8px 0;">Log in instantly via your web browser to manage your inbox, calendar, and contacts.</p>
                                                            <div style="border: 1px solid #e6e6e6; padding: 10px; background-color: #f0f0f0;">
                                                                <p style="font-size:14px; margin: 5px 0;"><strong>Webmail URL:</strong> 
                                                                    <a href="https://${domain}/webmail" style="color:#538200; text-decoration:underline;">https://${domain}/webmail</a>
                                                                </p>
                                                                <p style="font-size:14px; margin: 5px 0;"><strog>Username:</strong> ${NEWADDR}</p>
                                                                <p style="font-size:14px; margin: 5px 0;"><strong>Password:</strong> Use the email account’s password.</p>
                                                            </div>
                                                        </div>

                                                        <h2 style="font-size:20px; margin-top:0; color:#454545; font-weight: 500; border-bottom:1px solid #e4e4e7; padding-bottom:10px;">
                                                            Mail Client Manual Settings
                                                        </h2>

                                                        <!-- SSL Settings Box -->
                                                        <div style="background-color: #fafafa; border: 1px solid #0076d6; border-radius: 4px; padding: 15px; margin-bottom: 20px;">
                                                            <h3 style="color:#0076d6; margin-top:0; font-size:16px;">Secure SSL/TLS Settings (Recommended)</h3>
                                                            <div style="border: 1px solid #e6e6e6; padding: 10px; background-color: #f0f0f0;">
                                                                <p style="font-size:14px; margin: 5px 0;"><strong>Username:</strong> ${NEWADDR}</p>
                                                                <p style="font-size:14px; margin: 5px 0;"><strong>Password:</strong> Use the email account’s password.</p>
                                                                <p style="font-size:14px; margin: 5px 0;"><strong>Incoming Server:</strong> mail.${domain}</p>
                                                                <ul style="font-size:14px; margin: 5px 0; padding-left:20px;">
                                                                    <li>IMAP Port: 993</li>
                                                                    <li>POP3 Port: 995</li>
                                                                </ul>
                                                                <p style="font-size:14px; margin: 5px 0;"><strong>Outgoing Server:</strong> mail.${domain}</p>
                                                                <ul style="font-size:14px; margin: 5px 0; padding-left:20px;">
                                                                    <li>SMTP Port: 465</li>
                                                                </ul>
                                                            </div>
                                                            <p style="font-size:12px; color:#565c65; font-style:italic; margin-top:10px;">IMAP, POP3, and SMTP require authentication.</p>
                                                        </div>

                                                        <!-- STARTTLS Settings Box -->
                                                        <div style="background-color: #fafafa; border: 1px solid #e66f0e; border-radius: 4px; padding: 15px;">
                                                            <h3 style="color:#e66f0e; margin-top:0; font-size:16px;">Alternative: STARTTLS</h3>
                                                            <p style="font-size:13px; color:#565c65; margin: 5px 0 10px 0;">
                                                                Use these only if your mail client does not support SSL/TLS on the ports above. The connection starts
                                                                unencrypted and is then upgraded to an encrypted one. Choose <strong>STARTTLS</strong> as the connection
                                                                security in your mail client.
                                                            </p>
                                                            <div style="border: 1px solid #e6e6e6; padding: 10px; background-color: #f0f0f0;">
                                                                <p style="font-size:14px; margin: 5px 0;"><strong>Username:</strong> ${NEWADDR}</p>
                                                                <p style="font-size:14px; margin: 5px 0;"><strong>Password:</strong> Use the email account’s password.</p>
                                                                <p style="font-size:14px; margin: 5px 0;"><strong>Incoming Server:</strong> mail.${domain}</p>
                                                                <ul style="font-size:14px; margin: 5px 0; padding-left:20px;">
                                                                    <li>IMAP Port: 143 (STARTTLS)</li>
                                                                    <li>POP3 Port: 110 (STARTTLS)</li>
                                                                </ul>
                                                                <p style="font-size:14px; margin: 5px 0;"><strong>Outgoing Server:</strong> mail.${domain}</p>
                                                                <ul style="font-size:14px; margin: 5px 0; padding-left:20px;">
                                                                    <li>SMTP Port: 587 (STARTTLS)</li>
                                                                </ul>
                                                            </div>
                                                            <p style="font-size:12px; color:#565c65; font-style:italic; margin-top:10px;">IMAP, POP3, and SMTP require authentication.</p>
                                                        </div>

                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-family:-apple-system,BlinkMacSystemFont,'Segoe UI','Helvetica Neue',sans-serif; font-size:11px; color:#71767a; text-align:center; padding-top:15px;">
                                        Do not reply to this automated message.
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</body>

</html>
EOT

# --- 3. CONSTRUCT MULTIPART MIME EMAIL ---
# Bodies are base64-encoded (76-char lines) so the non-ASCII characters
# (curly quotes, ’) are transported safely through any relay.
(
printf '%s\n' "From: \"Mail Server on ${domain}\" <${SENDER}>"
printf '%s\n' "Reply-To: <${REPLY_TO}>"
printf '%s\n' "To: <${NEWADDR}>"
printf '%s\n' "Subject: ${SUBJECT}"
printf '%s\n' "Auto-Submitted: auto-generated"
printf '%s\n' "MIME-Version: 1.0"
printf '%s\n' "Content-Type: multipart/alternative; boundary=\"${BOUNDARY}\""
printf '\n'
printf '%s\n' "--${BOUNDARY}"
printf '%s\n' "Content-Type: text/plain; charset=utf-8"
printf '%s\n' "Content-Transfer-Encoding: base64"
printf '\n'
printf '%s\n' "$TEXT_MESSAGE" | base64 -w 76
printf '\n'
printf '%s\n' "--${BOUNDARY}"
printf '%s\n' "Content-Type: text/html; charset=utf-8"
printf '%s\n' "Content-Transfer-Encoding: base64"
printf '\n'
printf '%s\n' "$HTML_MESSAGE" | base64 -w 76
printf '\n'
printf '%s\n' "--${BOUNDARY}--"
) | /usr/sbin/sendmail -oMt Automation -t -f "${REPLY_TO}"

exit 0
