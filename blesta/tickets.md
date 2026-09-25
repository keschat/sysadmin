# Blesta how tickets are assigned

In Blesta, support tickets are assigned and routed through its core [Support Manager](https://docs.blesta.com/5/integrations/plugins/support-manager) plugin using a combination of departments, staff access levels, automated schedules, and (in Blesta 6.0+) AI plain-English logic. [1](https://docs.blesta.com/5/integrations/plugins/support-manager),[2](https://www.blesta.com/2026/08/04/blesta-6.0-released/)

Here is how tickets find their way to the right staff member:
## 1. Department Assignment (The First Layer)
Every ticket belongs to a specific Support Department (e.g., Billing, Technical Support, Sales). [3] 

* Client Selection: When clients open a ticket via the client portal, they choose which department to submit it to.
* Email Piping/IMAP: If an email is sent to billing@yourdomain.com, Blesta's email parser automatically assigns that incoming ticket to the Billing department.
* Staff Access: Staff members can only view, interact with, or be assigned tickets within departments they have explicitly been granted access to. [1, 4, 5, 6] 

## 2. Manual and Re-assignment
Once a ticket is inside a department, any staff member with access to that department can manually manage its assignment: [7] 

* Self-Assignment / Escalation: A staff member can pick up an unassigned ticket, change its assigned staff member, or escalate it to another department entirely if it requires a different team's expertise. [3] 

## 3. Automated Routing & AI (Blesta 6.0+)
If you are running Blesta 6.0 or newer, the [Blesta AI](https://www.blesta.com/2026/08/04/blesta-6.0-released/) engine can handle ticket routing automatically based on natural language rules: [2] 

* You can write plain-English guardrails without needing to build complex workflows or scripts.
* For example, you can set a rule like: "Assign billing questions to Jane, and abuse reports to John or Dave."
* The AI will read the incoming ticket contents and adjust the priority or assign staff automatically matching your instructions. [2, 8, 9] 

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
