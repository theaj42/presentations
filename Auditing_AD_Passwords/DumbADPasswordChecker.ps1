<#
Name:           DumbADPasswordChecker
Author:         AJ Van Beest
Last modified:  20210824T1834

Description:
        Audit your active directory passwords for weak passwords, ask people with weak passwords to change them, force the change when they don't, and build statistics about these efforts to report out.

#>

<# ======== Set Variables ======== #>
$WorkingDir = "C:\users\avanbeest\testing\"

<# ======== Handle credentials ======== #>


<# ======== Download tools ======== #>
        <#
                TO-DO:
                - Checks to see if tools exist
                - Offer to install tools automatically
        #>

        # Build directory structure
        $Installers = $WorkingDir + "installers"; mkdir $Installers
        $Dir7Zip = $Installers + "\7Zip"; mkdir $Dir7Zip
        $DirHashcat = $Installers + "\hashcat"; mkdir $DirHashcat
        $DirMentalist = $Installers + "\mentalist"; mkdir $DirMentalist
        
        #7zip
                # TO-DO: Check to see if 7zip is installed
        $Installer7Zip = $Dir7Zip+ "installers\7z1900-x64.msi"; 
        Invoke-WebRequest "https://www.7-zip.org/a/7z1900-x64.msi" -OutFile $Installer7Zip
        
        # Hashcat
        $InstallerHashcat = $DirHashcat + "\hashcat-6.2.3.7z"
        $HashHashcat = $DirHashcat + "\hashcat-6.2.3.7z.asc"
        Invoke-WebRequest "https://hashcat.net/files/hashcat-6.2.3.7z" -OutFile $InstallerHashcat
        Invoke-WebRequest "https://hashcat.net/files/hashcat-6.2.3.7z.asc" -OutFile $HashHashcat
        Expand-7Zip $InstallerHashcat $DirHashcat

        #Mentalist
        $InstallerMentalist = $DirMentalist + "\master.zip"
        Invoke-WebRequest "https://github.com/sc0tfree/mentalist/archive/refs/heads/master.zip" -OutFile $InstallerMentalist
        Expand-Archive $InstallerMentalist $DirMentalist
        

        #Python
        # >> Check for python installation; if not installed, do it.

        #Mentalist
        # >> Check for mentalist; if not installed do it.


<# ======== Build a "Dictionary of Dumb" ======== #>
        # Run mentalist to build a wordlist

<# ======== Dump you some hashes ======== #>


<# ======== Crack you some hashes ======== #>
        # Run Hashcat against the hashes using the Mentalist wordlist

<# ======== Send nice emails ======== #>


<# ======== Initial reporting ======== #>


<# ======== Send "Now it's gettin' real emais" ======== #>


<# ======== Send sorry/not-sorry emails ======== #>


<# ======== Final reporting ======== #>