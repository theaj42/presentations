<#
Name:           DumbADPasswordChecker
Author:         AJ Van Beest
Last modified:  20210824T1834

Description:
        Audit your active directory passwords for weak passwords, ask people with weak passwords to change them, force the change when they don't, and build statistics about these efforts to report out.

#>

<# ======== Set Variables ======== #>
$HashcatURI = "https://hashcat.net/files/hashcat-6.2.3.7z"
$HashcatFile = ".\"
$HashcatHash = "Invoke-WebRequest -URI https://hashcat.net/files/hashcat-6.2.3.7z.asc"


<# ======== Handle credentials ======== #>


<# ======== Install tools ======== #>
        # Hashcat
        # >> Check for hashcat installation; If not installed, do it.
        Invoke-WebRequest -URI $HashcatURI -OutFile $HashcatFile
        # >> Check the hash and install

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