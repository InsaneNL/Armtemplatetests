####################################
#    Install PowerShell Modules    # 
####################################
   param 
   ( 
        [Parameter(Mandatory)]
        [String]$adjoinuser,

        [Parameter(Mandatory)]
        [String]$adjoinpass,

        [Int]$RetryCount=20,
        [Int]$RetryIntervalSec=30
    )

Find-Module -Name AzureAD | Install-Module -Force -AllowClobber -Verbose 
Find-Module -Name AZ | Install-Module -Force -AllowClobber -Verbose 
Find-Module -Name AzureRM | Install-Module -Force -AllowClobber -Verbose 
Find-Module -Name MSonline | Install-Module -Force -AllowClobber -Verbose 



################################
#    Authenticate to Azure     #
################################

$Creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $adjoinuser, $adjoinpass

Login-AzAccount -Credential $creds
#Login-AzureRmAccount -Credential $creds
Connect-AzureAD -Credential $creds
connect-msolservice -credential $creds


###################################
#    Azure AD Connect Commands    #
###################################
Import-Module ADSync -Force
Start-ADSyncSyncCycle -PolicyType Initial
Start-ADSyncSyncCycle -PolicyType Delta