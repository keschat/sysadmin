# Blesta how tickets are assigned

In Blesta, support tickets are assigned and routed through its core [Support Manager](https://docs.blesta.com/5/integrations/plugins/support-manager) plugin using a combination of departments, staff access levels, automated schedules, and (in Blesta 6.0+) AI plain-English logic. [1, 2]

Here is how tickets find their way to the right staff member:
## 1. Department Assignment (The First Layer)
Every ticket belongs to a specific Support Department (e.g., Billing, Technical Support, Sales). [3] 

* **Client Selection:** When clients open a ticket via the client portal, they choose which department to submit it to.
* **Email Piping/IMAP:** If an email is sent to billing@yourdomain.com, Blesta's email parser automatically assigns that incoming ticket to the Billing department.
* **Staff Access:** Staff members can only view, interact with, or be assigned tickets within departments they have explicitly been granted access to. [1, 4, 5, 6] 

## 2. Manual and Re-assignment
Once a ticket is inside a department, any staff member with access to that department can manually manage its assignment: [7] 

* **Self-Assignment / Escalation:** A staff member can pick up an unassigned ticket, change its assigned staff member, or **escalate** it to another department entirely if it requires a different team's expertise. [3] 

## 3. Automated Routing & AI (Blesta 6.0+)
If you are running Blesta 6.0 or newer, the [Blesta AI](https://www.blesta.com/2026/08/04/blesta-6.0-released/) engine can handle ticket routing automatically based on natural language rules: [2] 

* You can write **plain-English guardrails** without needing to build complex workflows or scripts.
* For example, you can set a rule like: _"Assign billing questions to Jane, and abuse reports to John or Dave."_
* The AI will read the incoming ticket contents and adjust the priority or **assign staff automatically** matching your instructions. [2, 8, 9] 

## 4. Notification Schedules (Who gets alerted?)
Blesta doesn't just assign visibility; it controls who gets notified based on strict parameters:

* Staff Schedules: In the Support Manager settings under Support > Staff > Edit, each operator has a scheduled start and end time. Staff will only receive ticket notices if the ticket arrives during their active shift. [3, 9, 10] 
* Priority Matching: Operators can opt to receive notifications only for certain ticket priorities (e.g., only "Critical" or "Emergency" tickets). [10] 
* Notification Preferences: Through the global admin notification system, staff can choose to receive their assignment notices via email, third-party messengers (like Slack/Telegram), or the internal admin interface. [11, 12] 

------------------------------
If you are having trouble getting tickets to route correctly, let me know:

* Which Blesta version are you running (e.g., v5.x or v6.x)?
* Are tickets arriving via the web portal or through email piping?
* Are staff members failing to see tickets, or are they just not getting notifications?

I can help you pinpoint exactly where your settings might be misconfigured!

[1] [https://docs.blesta.com](https://docs.blesta.com/5/integrations/plugins/support-manager)
[2] [https://www.blesta.com](https://www.blesta.com/2026/08/04/blesta-6.0-released/)
[3] [https://www.blesta.com](https://www.blesta.com/tags/ticket-system/)
[4] [https://docs.blesta.com](https://docs.blesta.com/integrations/plugins/support-manager/)
[5] [https://account.blesta.com](https://account.blesta.com/client/plugin/support_manager/client_tickets/add/3/)
[6] [https://docs.blesta.com](https://docs.blesta.com/getting-started/migrating/)
[7] [https://docs.blesta.com](https://docs.blesta.com/support/releases/3/360/)
[8] [https://www.blesta.com](https://www.blesta.com/features/ai/)
[9] https://www.blesta.com
[10] [https://www.blesta.com](https://www.blesta.com/forums/index.php?/topic/2042-support-system-ticket-documentation/)
[11] [https://marketplace.blesta.com](https://marketplace.blesta.com/category/5)
[12] [https://docs.blesta.com](https://docs.blesta.com/integrations/plugins/support-manager/)

# Q. What are common names for departments and staff groups

In web hosting, IT, and automated billing environments like Blesta, structuring your organization into clear tiers ensures tickets route to the right people immediately.
The most common names for support departments and staff groups across the industry include:
## Support Departments (Client-Facing)
These are the public-facing categories clients select when opening a ticket or emailing a specific inbox (e.g., sales@ or billing@).

* Billing & Accounts: For invoice disputes, payment issues, refunds, and subscription cancellations.
* Technical Support: The general landing spot for broken services, errors, or troubleshooting.
* Sales & Pre-Sales: For prospective clients asking about plans, custom quotes, or feature availability.
* Abuse & Security: A critical department for handling DMCA takedown notices, spam reports, or hacked accounts.
* Customer Success / Account Management: Typically used for high-value enterprise clients requiring personalized retention care.

## Staff Groups (Internal Roles)
These are internal operational designations used to group employees by their technical skill set, authority levels, or shifts.

* Tier 1 Support (Frontline): The first line of defense. They handle basic password resets, general questions, and triage tickets before escalating.
* Tier 2 Support (Administrators): Experienced staff who handle deeper troubleshooting, software configurations, and minor service disruptions.
* Tier 3 Support (Engineers / Developers): The highest escalation tier. They manage root server access, database fixes, infrastructure issues, and bug patching.
* Billing Specialists: A staff group locked down specifically to financial data, processing manual transactions or verifying fraud alerts.
* Super Admins / Management: Executive staff with overriding access to see all tickets, pull metrics, and override staff assignments.

------------------------------
If you want, tell me:

* What services or products do you sell?
* How many staff members are on your team?

I can suggest a tailored department structure and permission scheme for your exact setup.

# Q. Hosting products, services include custom web design, 4 staff at the moment

For a small team of 4 staff members managing web hosting and custom web design, the key is to keep things streamlined. If you create too many departments, your clients will get confused, and your team will waste time passing tickets back and forth.
With 4 people, everyone will likely wear multiple hats, but you still need clear division of labor between your automated hosting services and your labor-intensive design projects.
Here is the ideal, lean Blesta setup for your team:
Keep your public options down to just 3 or 4 departments so clients always know exactly which one to pick.

* 
* Support & Hosting Maintenance: The main landing zone for active hosting clients experiencing downtime, email issues, or control panel troubleshooting.
* Web Design & Development: A dedicated queue strictly for your custom design projects. This separates ongoing project tasks (like revisions, asset delivery, and feedback) from urgent hosting outages.
* Billing & Account Access: For payment issues, custom design invoices, upgrades, or domain renewals.
* Sales & Quotes: For new leads asking about hosting packages or requesting a quote for a custom web design project.
* 

Instead of complex multi-tiered groups, group your team into two primary roles based on their core skill sets. This allows you to route technical tasks to the right minds instantly.

| Staff Group | Core Focus | Ideal Department Access |
|---|---|---|
| System Administrators (1-2 people) | Server uptime, hosting tickets, complex technical issues, and global Blesta billing setup. | Support & Hosting, Billing, Sales |
| Creative & Frontend Group (2-3 people) | UI/UX design, custom coding, client revisions, and onboarding web design leads. | Web Design & Development, Sales |

To make this setup highly efficient with 4 people, structure your ticket assignment rules using these practical steps:

* 
* Route Web Design Separately: Ensure your creative staff do not get distracted by technical hosting alerts. Lock the Web Design & Development department down so only your designers receive its notifications.
* Share the Sales Queue: Assign everyone to the Sales & Quotes department. Designers can jump on custom design inquiries, while sysadmins can quickly handle standard hosting pre-sales questions.
* Utilize Shift Schedules: Since hosting requires quick responses, use Blesta’s staff scheduling feature to split your 4 team members across overlapping shifts. This ensures someone is always designated to receive emergency alerts during business hours and slightly beyond.
* 

------------------------------
Would you like help setting up email piping so emails sent to design@yourdomain.com route differently than support@yourdomain.com, or should we look into how to restrict billing data visibility for specific staff members?

# Q. Restrict

In Blesta, restricting sensitive billing data while allowing staff to handle support requests is a critical step for data privacy and security.
Here is exactly how to lock down financial data for your design and support staff while keeping them productive:
## 1. Separate Staff Groups by Permissions
To restrict access, you must place your staff into different Staff Groups within Blesta, as permissions cannot be set on an individual, per-user basis.

   1. Navigate to Settings > Company > Staff > Staff Groups.
   2. Create or edit a group (e.g., Creative & Frontend Group or Support Staff).
   3. Under the Permissions tab, you will see a tree of checkboxes matching Blesta's core components.

## 2. The Key Permissions to Uncheck
To completely hide financial metrics, invoices, and payment gateways from non-administrative staff, uncheck the following checkboxes for that group:

* Invoices: Disables the ability to create, view, or void invoices.
* Transactions: Hides client payment histories, credits, and refunds.
* Gateways / Payment Methods: Prevents staff from viewing or editing merchant accounts or payment details.
* Packages / Packages (Billing): (Optional) Uncheck this if you don't want staff seeing the backend pricing structures of your hosting plans.

## 3. Maintaining Support Functionality
While billing is restricted, your staff still need to help clients. Ensure these permissions remain checked:

* Clients: Allow them to see client profiles so they know who they are talking to.
* Support Manager Plugin: Ensure full access is granted to view, reply to, and assign tickets.

## 4. Department-Level Ticket Restrictions
If a client replies to an invoice, Blesta often automatically creates a ticket in the Billing Department. To prevent non-billing staff from accidentally seeing financial chatter through the support desk:

   1. Go to Plugins > Support Manager > Departments.
   2. Edit your Billing & Account Access department.
   3. Scroll to the Staff section and uncheck your designers or general support staff.
   4. This ensures that even if they are logged into the ticket system, the Billing ticket queue remains entirely invisible to them.

------------------------------
Would you like assistance setting up custom access roles for your administrators next, or are you ready to configure the automated ticket email templates for your restricted staff?

# Q. configure the automated ticket email templates

Configuring your automated ticket email templates ensures that both your hosting and web design clients get professional, on-brand notifications. Because you are managing a small team of 4 people, setting these up perfectly will help triage requests without manual intervention.
## 1. Where to Find Ticket Templates
Ticket templates are handled by the [Support Manager Plugin](https://docs.blesta.com/5/integrations/plugins/support-manager).

   1. Log into your Blesta Admin portal.
   2. Go to Settings > Company > Emails > Email Templates.
   3. Scroll down to the Plugin Templates section.

You will see several core ticket templates available for editing, including:

* 
* Ticket Received: Sent to the client as an autoreply when a ticket is opened.
* Ticket Staff Reply: Sent to the client when a staff member posts a response.
* Ticket Assigned: Sent internally to a staff member when a ticket is routed to them.
* 

------------------------------
## 2. Supported Template Tags
Blesta allows you to use dynamic variables (tags) wrapped in curly braces {} to personalize the content. The most useful tags for support templates are:

| Tag | What it Displays |
|---|---|
| {ticket.code} | The unique ticket hash code (e.g., #A1B2-C3D4). |
| {ticket.id} | The internal database ID of the ticket. |
| {ticket.summary} | The subject line or summary of the ticket. |
| {ticket.department_name} | The department it belongs to (e.g., Web Design & Development). |
| {client.first_name} | The client's first name. |
| {update.body} | The message body of the latest ticket reply. |

------------------------------
## 3. Recommended Email Layouts## Template: Ticket Received (Client Autoreply)
When clients submit design requests or hosting bugs, a clear confirmation sets the right expectation for response times.

* 
* Subject: [{ticket.code}] Ticket Received: {ticket.summary}
* Text / HTML Body:
* 

Hi {client.first_name},

Thank you for reaching out to us. We have successfully received your request, and a ticket has been created in our {ticket.department_name} department.

Ticket Details:
----------------------------------------
Ticket ID: {ticket.code}
Subject: {ticket.summary}
----------------------------------------

What happens next?
- If this is a Support & Hosting Maintenance issue, our team will review the technical details shortly.
- If this is a Web Design & Development project update, your assigned designer will review the request during studio hours.

You can reply directly to this email to add more information, or view your ticket progress anytime via the client portal.

Best regards,
The Team

## Template: Ticket Staff Reply
When your team answers a ticket, this email delivers the response directly to the client's inbox.

* 
* Subject: Re: [{ticket.code}] {ticket.summary}
* Text / HTML Body:
* 

Hi {client.first_name},

A member of our team has updated your ticket with the following response:

----------------------------------------
{update.body}
----------------------------------------

To reply, simply respond directly to this email or visit the client portal. Please keep the ticket code [{ticket.code}] in the subject line intact so your response routes correctly.

Best regards,
The Team

------------------------------
## 4. Designing & Formatting (Pro-Tips)

* 
* Match Your Brand: If you are running Blesta 5.11 or newer, the platform fully supports responsive HTML email templates. Since you offer custom web design, take advantage of this by adding a clean, modern HTML layout.
* Utilize Blesta AI (v6.0+): If you are using Blesta 6.0+, you can use the built-in [Blesta AI engine](https://www.blesta.com/2026/08/04/blesta-6.0-released/) to automatically draft alternative variations of your HTML structures or polish your copy.
* 

------------------------------
Would you like help formatting the HTML wrapper code for these emails to give them a premium agency layout, or should we set up Predefined Responses next so your staff can drop saved answers into design or hosting tickets with one click?

# Q. HTML wrapper code and Predefined Responses

Here is a modern, responsive HTML email wrapper tailored for a web design and hosting agency, followed by a set of essential predefined responses for your 4-man team.
## 1. Modern HTML Email Wrapper
To apply this globally, go to Settings > Company > Emails > Email Templates and edit your Global Template (or create a custom one). This wrapper ensures your emails look professional on both desktop and mobile devices.
```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{ticket.summary}</title>
    <style>
        body { margin: 0; padding: 0; background-color: #f4f6f8; font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; -webkit-font-smoothing: antialiased; color: #333333; }
        .wrapper { width: 100%; table-layout: fixed; background-color: #f4f6f8; padding-bottom: 40px; padding-top: 40px; }
        .main-table { width: 100%; max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 10px rgba(0,0,0,0.05); }
        .header { background-color: #1e293b; padding: 30px 40px; text-align: left; }
        .header h1 { color: #ffffff; margin: 0; font-size: 22px; font-weight: 600; letter-spacing: -0.5px; }
        .content { padding: 40px; line-height: 1.6; font-size: 16px; }
        .ticket-box { background-color: #f8fafc; border-left: 4px solid #3b82f6; padding: 15px 20px; margin: 20px 0; border-radius: 0 6px 6px 0; font-size: 14px; }
        .footer { background-color: #f8fafc; padding: 20px 40px; text-align: center; font-size: 12px; color: #64748b; border-top: 1px solid #e2e8f0; }
        .footer a { color: #3b82f6; text-decoration: none; }
        @media screen and (max-width: 600px) { .content { padding: 20px; } .header { padding: 20px; } }
    </style>
</head>
<body>
    <center class="wrapper">
        <table class="main-table" cellpadding="0" cellspacing="0" border="0">
            <!-- Header -->
            <tr>
                <td class="header">
                    <h1>Our Agency Support</h1>
                </td>
            </tr>
            <!-- Content Area -->
            <tr>
                <td class="content">
                    {email_body}
                </td>
            </tr>
            <!-- Footer -->
            <tr>
                <td class="footer">
                    Sent via our Client Portal. Need immediate help? <a href="{client_url}">Log in to your account</a>.<br>
                    &copy; 2026 Your Agency Name. All rights reserved.
                </td>
            </tr>
        </table>
    </center>
</body>
</html>
```
Note: Ensure your ticket templates simply contain the text/paragraphs you want to output. Blesta injects that text directly where {email_body} is located.
------------------------------
## 2. Predefined Responses (Canned Replies)
Predefined responses save your team massive amounts of time. You can set these up by navigating to Support > Predefined Responses. Create separate Categories to keep things organized for your hosting and design staff.
## Category: Web Design & Development

* Template Name: Design Phase Kickoff
* Response:
   
   Hi {client.first_name},
   
   Great news! We are officially ready to kick off the design phase of your project. 
   
   Our creative team is currently reviewing your project brief and asset submissions. Over the next [X] business days, we will be working on your initial wireframes and concepts.
   
   If you have any last-minute inspiration or design assets to share, please reply directly to this ticket so we can keep everything tracked in one place.
   
   Best regards,
   
   * Template Name: Revision Request Acknowledgment
* Response:
   
   Hi {client.first_name},
   
   Thank you for sending over your detailed feedback and revision requests. 
   
   I have handed these specific changes over to your assigned frontend developer/designer. We are jumping right into these adjustments and aim to have the updated staging link ready for your review by [Time/Date].
   
   We will keep you updated right here as soon as it's live!
   
   
## Category: Support & Hosting

* Template Name: IP Blacklist / False Positive Block
* Response:
   
   Hi {client.first_name},
   
   It looks like your local IP address was temporarily flagged and blocked by our server firewall, likely due to multiple failed login attempts to your email or control panel.
   
   I have successfully unblocked your IP address from the cluster. Please try accessing your website and services again. If you continue to experience a timeout, you can check your current public IP via https://icanhazip.com and reply with it here so we can deeply whitelist it.
   
   * Template Name: Migration Request Data Needed
* Response:
   
   Hi {client.first_name},
   
   We would be happy to migrate your existing website over to our secure hosting infrastructure. To get started seamlessly, could you please provide the following details?
   
   - Current Host Provider:
   - Control Panel URL (cPanel/Plesk):
   - Username:
   - Password:
   
   Once we have verified these credentials, our systems administration team will schedule the migration during an off-peak maintenance window to ensure zero downtime for your visitors.
   
   
------------------------------
Would you like to build a quick custom onboarding text template for new hosting signups, or should we look into setting up ticket priorities so design tasks don't push critical server alerts down the queue?

# Q. custom onboarding text template and ticket priorities

Here is how to set up your Custom Onboarding Text Template and configure your Ticket Priorities so your team of 4 can manage project launches and server alerts effectively.
## 1. Custom Onboarding Text Template
When a client purchases a hosting package or signs a web design contract, Blesta can automatically send a welcome email. Navigate to Settings > Company > Emails > Email Templates and edit the Welcome Email / Service Creation template.
Here is a highly professional, text-based onboarding template designed for an agency selling both hosting and custom design:

Subject: Welcome to Our Agency! Important Details Inside

Hi {client.first_name},

Thank you for partnering with us! Your account has been successfully set up, and we are thrilled to help grow your digital presence. 

Below are the essential details and next steps depending on what you signed up for today:

----------------------------------------------------------------------
1. FOR WEB HOSTING CLIENTS
----------------------------------------------------------------------
Your hosting environment is fully provisioned and ready for data deployment.

* Control Panel Login: {service.panel_url} (or login via our portal)
* Username: {service.username}
* Password: {service.password}

* Nameservers to update at your registrar:
  - ://youragency.com
  - ://youragency.com

----------------------------------------------------------------------
2. FOR CUSTOM WEB DESIGN CLIENTS
----------------------------------------------------------------------
Our creative team has been notified of your project activation! 

* Next Steps: Please log into the client portal and complete your "Project Briefing Questionnaire" so we can map out your wireframes.
* Collaboration: Your assigned designer will open a dedicated ticket in our "Web Design & Development" loop within 24 business hours to kick off communication.

----------------------------------------------------------------------
NEED HELP? HOW TO REACH US
----------------------------------------------------------------------
To ensure nothing gets lost in translation, all requests must go through our support desk rather than direct personal emails. 

Simply log in at {client_url} to open a ticket, view active invoices, or track project milestones. 

Welcome aboard,
The Team

------------------------------
## 2. Setting Up Ticket Priorities
With a team of 4, keeping your queue organized by urgency prevents designers from getting overwhelmed by technical issues, and ensures system admins drop everything for critical outages.
To adjust your priorities, navigate to Plugins > Support Manager > Priorities. We recommend editing your default options to match this clean 4-tier system:

├── 🚨 Emergency (System Down)
├── ⚠️ High (Hosting Issues / Broken Elements)
├── 📅 Standard (Design Revisions / Project Updates)
└── 💬 Low (General Inquiries / Pre-Sales Quotes)

## How to Assign Priorities Effectively:

* Emergency (System Down): Reserve this strictly for server-wide outages, massive packet loss, or core merchant gateway failures. Configure Blesta to trigger immediate staff mobile or third-party messenger notifications (like Slack or Telegram) for your System Administrators, regardless of their shift schedules.
* High (Hosting Issues / Broken Elements): Use this for individual client issues, such as a website throwing a 500 error, an email inbox being blocked, or an accidental IP ban. These require same-day resolution but don't threaten the entire network infrastructure.
* Standard (Design Revisions / Project Updates): The default tier for all Web Design & Development tasks. Design projects operate on milestone schedules rather than minutes, so keeping them at "Standard" ensures they don't trigger intrusive notifications while the tech team is troubleshooting server stability.
* Low (General Inquiries / Pre-Sales Quotes): Perfect for feature requests, sales questions, or non-urgent adjustments. Your team can tackle these when the main support and design queues are completely cleared.

------------------------------
Would you like help connecting your Emergency ticket priority to an external notification channel like Slack, Discord, or Telegram so your system admins get alerted instantly, or should we look at setting up Ticket Statuses (like "Awaiting Client Review") to keep design projects moving?

# Q. Emergency ticket priority

To connect Emergency tickets directly to chat platforms like Slack, Discord, or Telegram, you have two excellent choices depending on your preferred approach: using Blesta’s official [Webhooks Plugin](https://docs.blesta.com/category/plugins/) for native flexibility, or a dedicated Messenger addon for a quick setup. [1, 2] 
Here is how to set up instant alerts for your systems administrators:
## Method A: The Webhooks Plugin (Native & Flexible)
Blesta features a core Webhooks plugin that listens to backend system events (like a ticket opening) and sends data to external URLs. [3] 
## 1. Activate the Webhooks Plugin

   1. Navigate to Settings > Company > Plugins > Available.
   2. Locate the Webhooks plugin and click Install. [3] 

## 2. Get Your Chat Webhook URL

* 
* Slack: Create an app in your workspace, enable Incoming Webhooks, and copy the URL.
* Discord: Go to Channel Settings > Integrations > Webhooks > Create Webhook and copy the URL.
* 

## 3. Define the Webhook in Blesta

   1. Go to Settings > Company > Plugins > Webhooks (or via the link on your dashboard).
   2. Click Add Webhook.
   3. Event: Select SupportManager.ticketAdd (this triggers the webhook whenever a ticket is created).
   4. URL: Paste your Slack or Discord webhook URL.
   5. Filters & Logic: You can set a conditional filter rule so it only fires when {ticket.priority} matches your designated emergency value. [4] 

------------------------------
## Method B: Using Messenger Integrations (Simplest Way)
If you prefer a direct plugin option that handles the payload logic automatically, you can utilize Messenger plugins from the [Blesta Add-ons Marketplace](https://marketplace.blesta.com/).
## 1. Connect the Webhook to the Messenger
Once you install a compatible messenger addon (such as the popular Simple Discord Messenger or third-party Slack tools), navigate to its plugin configuration menu and paste your chat room webhook URL. [1] 
## 2. Lock Down to Emergency Priority
To avoid notification fatigue, restrict alerts so they do not trigger for routine web design tickets: [5, 6] 

   1. Navigate to Support > Staff.
   2. Click Edit next to your System Administrator profiles.
   3. Scroll down to the Ticket Notifications / Messenger Settings section.
   4. Check the box only for your Emergency priority tier, leaving Standard and Low unchecked. [1] 

Now, if a server goes down, Blesta will instantaneously push a structured card directly into your team's chat group. [2] 
------------------------------
Would you like to build out the JSON payload structure for your webhook so the chat notification includes a clickable direct link back to the Blesta admin panel? [7] 

[1] [https://marketplace.blesta.com](https://marketplace.blesta.com/category/5)
[2] [https://ohdear.app](https://ohdear.app/features/notifications)
[3] [https://docs.blesta.com](https://docs.blesta.com/category/plugins/)
[4] [https://docs.blesta.com](https://docs.blesta.com/integrations/plugins/support-manager/)
[5] [https://pluno.ai](https://pluno.ai/blog/zendesk-slack-integration-2026-guide)
[6] [https://clearfeed.ai](https://clearfeed.ai/blogs/slack-zendesk-integration-to-streamline-customer-support)
[7] [https://community.atlassian.com](https://community.atlassian.com/forums/Jira-questions/How-do-I-post-tickets-with-escalated-priority-to-a-Slack-channel/qaq-p/2815522)

# Q. Yes

To format your webhook notifications beautifully, you will need to construct a JSON payload. This payload tells Slack or Discord exactly how to display the ticket details, including a direct link back to your Blesta admin panel so your team can respond instantly.
Here are the optimized JSON payloads for both platforms:
## 1. The Blesta Callback URL Structure
Before setting up the payload, locate your exact admin URL prefix. For all payloads below, replace https://yourbillingportal.com with your actual Blesta admin URL.
The direct link variable to view a specific ticket in Blesta's Support Manager is:

https://yourbillingportal.com{ticket.id}/

------------------------------
## 2. For Discord (Rich Embed Template)
Discord supports rich "Embed" cards with colored sidebars, which are excellent for highlighted Emergency alerts.
Paste this structure into your Blesta Webhook payload data field:

{
  "username": "Blesta Alert Bot",
  "avatar_url": "https://blesta.com",
  "embeds": [
    {
      "title": "🚨 EMERGENCY TICKET OPENED",
      "description": "**Subject:** {ticket.summary}\n**Department:** {ticket.department_name}",
      "url": "https://yourbillingportal.com{ticket.id}/",
      "color": 15158332,
      "fields": [
        {
          "name": "Ticket Code",
          "value": "`{ticket.code}`",
          "inline": true
        },
        {
          "name": "Client ID",
          "value": "#{client.id}",
          "inline": true
        }
      ],
      "footer": {
        "text": "Action required immediately by on-duty Systems Administrator."
      }
    }
  ]
}

(Note: 15158332 is the decimal code for bright red, ensuring it jumps out visually in the channel).
------------------------------
## 3. For Slack (Block Kit Template)
Slack uses a layout framework called "Blocks" to create clean, readable notification feeds.
Paste this structure into your Blesta Webhook payload data field:

{
  "text": "🚨 Emergency Ticket Opened: {ticket.code}",
  "blocks": [
    {
      "type": "header",
      "text": {
        "type": "plain_text",
        "text": "🚨 CRITICAL: Emergency Ticket Created",
        "emoji": true
      }
    },
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "*Subject:* {ticket.summary}\n*Department:* {ticket.department_name}\n*Ticket Code:* `{ticket.code}`"
      }
    },
    {
      "type": "actions",
      "elements": [
        {
          "type": "button",
          "text": {
            "type": "plain_text",
            "text": "View Ticket in Blesta",
            "emoji": true
          },
          "style": "danger",
          "url": "https://yourbillingportal.com{ticket.id}/"
        }
      ]
    }
  ]
}

(Note: Setting the button style to "danger" colors it red in Slack, matching the emergency protocol).
------------------------------
Would you like to test this payload structure with a dummy ticket submission, or should we transition to configuring Ticket Statuses (like Awaiting Client Feedback) to manage the lifecycle of your web design revisions?

# Q. dummy ticket submission and configuring Ticket Statuses

To test your new webhook notification and organize your web design workflow, you can perform a test submission and then expand Blesta's default ticket states to match an agency environment.
## 1. Performing a Dummy Ticket Submission
Testing ensures your JSON payloads are formatted correctly and that your chat channels receive the alerts instantly.

   1. Log in to your Admin Interface.
   2. Navigate to Support > Tickets and click Open Ticket in the top right.
   3. Select a test client account (or create a dummy client named "Test Client").
   4. Choose your Support & Hosting Maintenance department.
   5. Set the Priority explicitly to 🚨 Emergency (System Down).
   6. Enter a sample subject line like CRITICAL: Database Connection Failure - Server 04 and write a brief description.
   7. Click Open Ticket.

Check your Slack or Discord channel immediately. If configured correctly, your webhooks should fire instantly, posting your custom red embed card with the clickable link back to Blesta. If it does not appear, verify that your base admin URL matches exactly and check the Blesta logs under Tools > Logs > Webhooks to view any transmission error messages.
------------------------------
## 2. Configuring Ticket Statuses for Web Design Revisions
Blesta comes out of the box with standard hosting statuses like Open, In Progress, and Closed. However, custom web design projects require iterative loops where the ball is frequently in the client's court.
To manage your project lifecycle smoothly across your 4 staff members, navigate to Plugins > Support Manager > Statuses (or Settings > Company > Plugins > Support Manager depending on your exact version) and customize your workflow statuses.
## Recommended Agency Status Setup:

* Open: The default status for newly arrived tickets or hosting alerts that haven't been reviewed yet.
* In Progress (or "Designing"): The staff member has claimed the ticket and is actively working on coding, layout design, or server optimization.
* Awaiting Client Feedback / Review: Use this when your designer sends over a Figma link or a staging URL. It signals to your internal team that no action is required on your end until the client responds.
* On Hold (Internal Dependency): Perfect for when a design element is stuck waiting on a third-party asset, API approval, or domain transfer clearance.
* Closed: The project milestone is complete, or the technical issue is fully resolved.

## Pro-Tip: Automated Reminders (The Cron Benefit)
By leveraging the Awaiting Client Feedback status, you can configure Blesta's automation criteria to systematically ping forgetful design clients. If a ticket sits in this status for more than 3 to 5 business days, Blesta can automatically send a polite reminder email asking them if they've had a chance to review the design mockups, helping keep your project timelines on track without manual follow-up from your designers.
------------------------------
Would you like to look at setting up the automated closure rules for stale "Awaiting Feedback" tickets, or should we examine how your 4 staff members can add internal private notes to a ticket that the client will never see?










