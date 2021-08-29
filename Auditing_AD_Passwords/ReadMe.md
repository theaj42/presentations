# "Find Easy-to-Guess Passwords in Your Active Directory," he said.

## "It'll be fun," he said.

**Get the Google slide deck:** [https://docs.google.com/presentation/d/14rw4tLiVrDzuWUMbtwyxtE2iy2hHnUT8N8RdxkZFgds/edit?usp=sharing](https://docs.google.com/presentation/d/14rw4tLiVrDzuWUMbtwyxtE2iy2hHnUT8N8RdxkZFgds/edit?usp=sharing)

**Get NtdsAudit:** [https://github.com/Dionach/NtdsAudit/](https://github.com/Dionach/NtdsAudit/).


### Wordlist resources
* The Mentalist repo: [https://github.com/sc0tfree/mentalist/releases](https://github.com/sc0tfree/mentalist/releases). (Old but good!)
* Want to target your wordlist at one person?: [https://github.com/Mebus/cupp](https://github.com/Mebus/cupp).
* Daniel Miessler's list of password lists: [https://github.com/danielmiessler/SecLists/tree/master/Passwords](https://github.com/danielmiessler/SecLists/tree/master/Passwords).
* Troy Hunt's list of already-breached password hashes. Use this to see if any of your people are currently rocking a p0wned password. Also use this to dial in your hash cracking setup: [https://haveibeenpwned.com/Passwords](https://haveibeenpwned.com/Passwords)

### Hashcat resources
* The official Hashcat site:[https://hashcat.net/hashcat/](https://hashcat.net/hashcat/).
* Here's a great tutorial: [https://laconicwolf.com/2018/09/29/hashcat-tutorial-the-basics-of-cracking-passwords-with-hashcat/](https://laconicwolf.com/2018/09/29/hashcat-tutorial-the-basics-of-cracking-passwords-with-hashcat/).
* Hashcat cheet sheet:[https://github.com/frizb/Hashcat-Cheatsheet](https://github.com/frizb/Hashcat-Cheatsheet).

### Hash-dumping resources
* A tutorial from the creators of NtdsAudit: [https://www.dionach.com/blog/active-directory-password-auditing-part-1-dumping-the-hashes/](https://www.dionach.com/blog/active-directory-password-auditing-part-1-dumping-the-hashes/).
* Dump hashes with Mimikatz / Empire / Nishang / etc: [https://www.ivoidwarranties.tech/posts/pentesting-tuts/ad/dc-hashdump/](https://www.ivoidwarranties.tech/posts/pentesting-tuts/ad/dc-hashdump/)

### Other potentially useful resources
* Get a nice view of the domain password policy: [https://devblogs.microsoft.com/scripting/use-powershell-to-get-account-lockout-and-password-policy/](https://devblogs.microsoft.com/scripting/use-powershell-to-get-account-lockout-and-password-policy/).
* Tips for sending email with PowerShell: [https://mailtrap.io/blog/powershell-send-email/](https://mailtrap.io/blog/powershell-send-email/).
* Get deeper into auditing with PowerShell: [https://www.sans.org/blog/powershell-tools-i-use-audit-and-compliance-measurement/](https://www.sans.org/blog/powershell-tools-i-use-audit-and-compliance-measurement/).
* Another ready-to-go project to audit your AD passwords: [https://github.com/MichaelGrafnetter/DSInternals](https://github.com/MichaelGrafnetter/DSInternals).
* Prefer spraying instead of dumping/cracking?: [https://github.com/dafthack/MSOLSpray](https://github.com/dafthack/MSOLSpray)
