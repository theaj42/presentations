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
                - Validate downloads
                - Offer to install tools automatically
        #>

        # Build directory structure
        $Installers = $WorkingDir + "installers"; mkdir $Installers
        $Dir7Zip = $Installers + "\7Zip"; mkdir $Dir7Zip
        $DirHashcat = $Installers + "\hashcat"; mkdir $DirHashcat
        $DirMentalist = $Installers + "\mentalist"; mkdir $DirMentalist
        $DirGPG = $Installers + "\GPG"; mkdir $DirGPG
        
        #7zip
        $Installer7Zip = $Dir7Zip + "\7z1900-x64.msi"; 
        Invoke-WebRequest "https://www.7-zip.org/a/7z1900-x64.msi" -OutFile $Installer7Zip

        #GnuPG
        <# ==== Don't have trust-worthy file hash for the latest version of the installer :( ====

        $InstallerGPG = $DirGPG + "\gnupg-2.3.2.tar.bz2"
        Invoke-WebRequest "https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-2.3.2.tar.bz2" -OutFile $InstallerGPG
        $HashGPGWeb = -split ((Invoke-webrequest https://gnupg.org/download/integrity_check.html).tostring() -split "[`r`n]" | select-string '[\d\D]{40}\s{2}gnupg-2\.2\.29\.tar.bz2') | Select-Object -first 1
        $HashGPGCalc = Get-FileHash -Algorithm SHA1 $InstallerGPG |select-object -ExpandProperty Hash
        if ($HashGPGWeb -eq $HashGPGCalc) {Write-Host "Hey, good news: The GPG hashes match, so the file's legit!"} else {Write-Host "Yo. There seems to be a mismatch with the hash values for GPG. Check that out, will ya?"}
        #>

        
        # Hashcat
        $InstallerHashcat = $DirHashcat + "\hashcat-6.2.3.7z"
        $HashHashcat = $DirHashcat + "\hashcat-6.2.3.7z.asc"
        Invoke-WebRequest "https://hashcat.net/files/hashcat-6.2.3.7z" -OutFile $InstallerHashcat
        Invoke-WebRequest "https://hashcat.net/files/hashcat-6.2.3.7z.asc" -OutFile $HashHashcat
        Expand-7Zip $InstallerHashcat $DirHashcat
        

        #Python
        # >> Check for python installation; if not installed, do it.
        $VersionPython = python --version
        if ($VersionPython -match '.*not found.*'){<# INSTALL THE THING #>} else {write-host "`n==========`n`nPython should be good to go:" $VersionPython"`n`n=========="}

        #Mentalist
        $InstallerMentalist = $DirMentalist + "\Mentalist-v1.0-Win.zip"
        Invoke-WebRequest "https://github.com/sc0tfree/mentalist/releases/download/v1.0/Mentalist-v1.0-Win.zip" -OutFile $InstallerMentalist
        #Invoke-WebRequest "https://github.com/sc0tfree/mentalist/archive/refs/heads/master.zip" -OutFile $InstallerMentalist
        Expand-Archive $InstallerMentalist $DirMentalist




<# ======== Build a "Dictionary of Dumb" ======== #>
        # Run mentalist to build a wordlist
        write-host "`n==========`n`nStarting Mentalist for wordlist creation`n`n==========";
        cd $DirMentalist; .\Mentalist.exe

<# ======== Dump you some hashes ======== #>


<# ======== Crack you some hashes ======== #>
        # Run Hashcat against the hashes using the Mentalist wordlist
        # Remove the hashes; delete the .pot file! 

<# ======== Send nice emails ======== #>


<# ======== Initial reporting ======== #>


<# ======== Send "Now it's gettin' real emais" ======== #>


<# ======== Send sorry/not-sorry emails ======== #>


<# ======== Final reporting ======== #>