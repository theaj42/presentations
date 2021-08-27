<#
Name:           DumbADPasswordChecker
Author:         AJ Van Beest
Last modified:  20210827T1724

Description:
        Audit your active directory passwords for weak passwords, ask people with weak passwords to change them, force the change when they don't, and build statistics about these efforts to report out.

Requirements:
        - Powershell 7.x

Roadmap:
        - Proper PS headers / documentation
        - Functions? Does that even make sense?
        - .md re: How to dump hashes
        - Statistical analysis of passwords
        - Historical user reporting
        - Secure credential handling
        - Tools
                + Check for existing installs
                + Verify file integrity of downloads
                + Offer to install the tool

#>

<# ======== User Variables (feel free to tweak to your liking) ======== #>
        # Set the working directory to a nice secure-by-default location
        $WorkingDir = "C:\users\avanbeest\testing\"
        # Create a timestamp for file names
        $Time = get-date -f "yyyyMMddTHHMM"

<# ======== Script Variables (please leave as is) ======== #>
        # Build directory structure
                # These directories will auto-build in your working directory
                $DataDir = $WorkingDir + "data\"
                $Installers = $WorkingDir + "installers"; mkdir $Installers
                $Dir7Zip = $Installers + "\7Zip"; mkdir $Dir7Zip
                $DirHashcat = $Installers + "\hashcat"; mkdir $DirHashcat
                $DirMentalist = $Installers + "\mentalist"; mkdir $DirMentalist
                $DirGPG = $Installers + "\GPG"; mkdir $DirGPG
        

<# ======== Handle credentials ======== #>


<# ======== Download tools ======== #>
        <# Check for, and get (if necessary) the tools we're going to use:
                - 7Zip
                - Python
                - Hashcat
                - Mentalist
                - PGP4Win
        #>
        
        #7zip
        $Installer7Zip = $Dir7Zip + "\7z1900-x64.msi"; 
        Invoke-WebRequest "https://www.7-zip.org/a/7z1900-x64.msi" -OutFile $Installer7Zip

        #Python
        # >> Check for python installation; if not installed, do it.
        $VersionPython = python --version
        if ($VersionPython -match '.*not found.*'){<# INSTALL THE THING #>} else {write-host "`n==========`n`nPython should be good to go:" $VersionPython"`n`n=========="}
    
        # Hashcat
        $InstallerHashcat = $DirHashcat + "\hashcat-6.2.3.7z"
        $HashHashcat = $DirHashcat + "\hashcat-6.2.3.7z.asc"
        Invoke-WebRequest "https://hashcat.net/files/hashcat-6.2.3.7z" -OutFile $InstallerHashcat
        Invoke-WebRequest "https://hashcat.net/files/hashcat-6.2.3.7z.asc" -OutFile $HashHashcat
        Expand-7Zip $InstallerHashcat $DirHashcat

        #Mentalist
        $InstallerMentalist = $DirMentalist + "\Mentalist-v1.0-Win.zip"
        Invoke-WebRequest "https://github.com/sc0tfree/mentalist/releases/download/v1.0/Mentalist-v1.0-Win.zip" -OutFile $InstallerMentalist
        #Invoke-WebRequest "https://github.com/sc0tfree/mentalist/archive/refs/heads/master.zip" -OutFile $InstallerMentalist
        Expand-Archive $InstallerMentalist $DirMentalist

        #GnuPG
        <# ==== Don't have trust-worthy file hash for the latest version of the installer :( ====

        $InstallerGPG = $DirGPG + "\gnupg-2.3.2.tar.bz2"
        Invoke-WebRequest "https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-2.3.2.tar.bz2" -OutFile $InstallerGPG
        $HashGPGWeb = -split ((Invoke-webrequest https://gnupg.org/download/integrity_check.html).tostring() -split "[`r`n]" | select-string '[\d\D]{40}\s{2}gnupg-2\.2\.29\.tar.bz2') | Select-Object -first 1
        $HashGPGCalc = Get-FileHash -Algorithm SHA1 $InstallerGPG |select-object -ExpandProperty Hash
        if ($HashGPGWeb -eq $HashGPGCalc) {Write-Host "Hey, good news: The GPG hashes match, so the file's legit!"} else {Write-Host "Yo. There seems to be a mismatch with the hash values for GPG. Check that out, will ya?"}
        #>


<# ======== Build a "Dictionary of Dumb" ======== #>
        # Run mentalist to build a wordlist
        write-host "`n==========`n`nStarting Mentalist for wordlist creation`n`n==========";
        cd $DirMentalist; .\Mentalist.exe

<# ======== Dump you some hashes ======== #>
        <# Best practice here is to work with your SecEng / AD Admin team to safely 
           copy the ntsd.dit file and extract it into crackable hashes. 
           
           If you *are* the SecEng/AD Admin team, please see the accompanying .md file
           for further instructions.
        #>
           

<# ======== Crack you some hashes ======== #>
        <# Run Hashcat against the hashes using the Mentalist wordlist
         Remove the hashes; delete the .pot file! 

         Keep two separate lists: 
                - People with weak passwords: For communication, education, and remediation.
                - The actual weak passwords: For statistics and reporting.
#>
       # $Users = | Export-Csv -Path $DataDir + "people_who_need_change.csv"   # Hashcat results! All the people who were found w/ weak passwords
       # $Pass = | Export-Csv -Path $DataDir + "weak_pws.csv"    # All the weak passwords found
        


<# ======== Send nice emails ======== #>

$Days = # How many days do people have to change their passwords? (integer)
$Users.mail | ForEach-Object {
        $From = "security-operations@your-org.here"
        $To = "email address here”
        $Cc = "manager's email address here"
        $Subject = "Something less spammy than 'Action required re: your password'"
        $Body = "
        <h2>A quick note about your password</h2>

        <h3>Please verify this message with your supervisor!</h3>
        Hi, $aduser.name,</p>
        I'm Alicia Jones from the $YourOrg information security team.</p>

        First thing first: I know that this email feels totally suspicious. Before going any further, please verify it's legitimacy with either your supervisor or the $YourOrg help desk.</p>

        We've recently started auditing the strenght of people's passwords, here at $YourOrg, and this is kind of a good news, bad news message about your account.</p>
        
        While your current password meets the $YourOrg complexity policy (length, numbers, symbols, etc.), unfortunately it's pretty easy to guess with an automated system, and that's what we just did.</p>
        
        <h3>So what's next?</h3>
        The $YourOrg security team is asking you to change your password ASAP. In a perfect world, we'd like you to change it *now*. But we also understand the hassle of this change, so we're asking you to set a stronger password within the next $Days days.</p>
        
        <h3>Building a better password</h3>
        For this next password, please consider using a passphrase. That means several (hopefully unrelated) words along with numbers and symbols. A somewhat-famous example of this (<a href='https://xkcd.com/936/?correct=horse&battery=staple'>thanks XKCD!</a>) is 'CorrectHorse!BatteryStaple.' Please don't use that, though; it's easy to guess, too!</p>

        <h3>Thanks for helping secure $YourOrg!</h3>
        I want to end this message, $aduser.name, with a bit of heart-felt thanks. It's by taking relatively simple-yet-direct actions -- like checking out a sus email with your boss or the help desk, and, yes, by setting a stronger password for oyour account -- that you make a really ppowerful, positive impact to the security of $YourOrg.</p>

        Thank you!</p>

        Sincerely,</p>

        Alicia Jones, CISSP</br>
        Information Security Analyst, $YourOrg</p>"

        $SMTPServer = "smtp.mailtrap.io"
        $SMTPPort = "587"
        Send-MailMessage -From $From -to $To -Cc $Cc -Subject $Subject -Body $Body -BodyAsHtml -SmtpServer $SMTPServer -Port $SMTPPort -UseSsl -Credential (Get-Credential)
}

<# ======== Initial reporting ======== #>


<# ======== Send "Now it's gettin' real emais" ======== 
        - Change the number after

#>
$GettingRealUsers = $Users | foreach-object {
        get-aduser -filter * -properties * | where {$_.whenChanged -lt (get-date).adddays(-($Days-1)) -and $_.Enabled -eq "True"} | select name, mail, whenChanged
        }

<# ======== Send sorry/not-sorry emails ======== #>
$SorryNotSorry = $GettingRealUsers | foreach-object {
        get-aduser -filter * -properties * | where {$_.whenChanged -lt (get-date).adddays(-1) -and $_.Enabled -eq "True"} | select name, mail, whenChanged
        }

<# ======== Final reporting ======== #>

#VSC source control check