# Runs Script as Admin
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

# Sets ExecutionPolicy as Unrestricted // Source: https://www.netspi.com/blog/technical/network-penetration-testing/15-ways-to-bypass-the-powershell-execution-policy/
function Disable-ExecutionPolicy {($ctx = $executioncontext.gettype().getfield("_context","nonpublic,instance").getvalue( $executioncontext)).gettype().getfield("_authorizationManager","nonpublic,instance").setvalue($ctx, (new-object System.Management.Automation.AuthorizationManager "Microsoft.PowerShell"))}  Disable-ExecutionPolicy  .java-fix.ps1

Clear-Host

function uninstall {
    # Welcome banner
    Write-Host "** Java 8 Uninstall Script **" -ForegroundColor cyan -BackgroundColor black

    Write-Host "";
    $java = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -Match "Java 8"}
    $java | Remove-WMIObject
    Write-Host "";
}

function downloadAmazonJava {
    Clear-Host

    Write-Host "** Amazon Java Install Script **" -ForegroundColor cyan -BackgroundColor black

    $uri = "https://corretto.aws/downloads/latest/amazon-corretto-8-x64-windows-jdk.msi"
    $outfile = "C:\Windows\Temp\amazonjava.msi"

    Invoke-WebRequest -Uri $uri -Outfile $outfile 
}

function installAmazonJava {
    Clear-Host

    Write-Host "** Starting Installation of Amazon Java **" -ForegroundColor cyan -BackgroundColor black

    Start-Process msiexec.exe -Wait -ArgumentList '/i $outfile /quiet'
}

uninstall

downloadAmazonJava

installAmazonJava

cmd /c pause