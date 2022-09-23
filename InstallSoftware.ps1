$SoftwareListFile = ".\software_list.txt"
[string[]]$SoftwareList = Get-Content $SoftwareListFile

<#
.SYNOPSIS
    Checks if a Command is currently available on Powershell
#>
function Test-CommandExists {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [string]$testCommand
  )

  try {
    Get-Command $testCommand -ErrorAction Stop
    return $true
  }
  catch {
    return $false
  }
}

if (!(Test-CommandExists winget)) {
  Write-Host "Winget not found, unable to continue"
  Write-Host "Check on https://github.com/microsoft/winget-cli for instructions"
  return -1
}

Write-Output "This script will attempt to install multiple softwares on your system"
$DoInstall = Read-Host -Prompt "Are you sure you want to install? If so, type 'install' bellow."
$WingetCommandParam = ($DoInstall -eq "install") ? $DoInstall : "search";

$SoftwareList
| ForEach-Object -Process {
  &winget $WingetCommandParam -e --id $_
}

Write-Output "Done!"
if (!(Test-Path "${PSScriptRoot}\bootstrap.ps1" -PathType Leaf)) {
  return;
}

$DoBootstrap = Read-Host -Prompt "Type 'bootstrap' bellow if you want to run dotfiles' bootstrap as well"
if ($DoBootstrap -eq "bootstrap") {
  . "${PSScriptRoot}\bootstrap.ps1"
}

# Busca o serviço do windows chamado ssh-agent
$sshAgentService = Get-Service -Name "ssh-agent"
# Se o serviço não estiver iniciando com delay...
if ($sshAgentService.StartType -ne "AutomaticDelayedStart") {
  Write-Warning "Setting SSH Agent to DelayedStart"
  # Mande ele iniciar com delay!
  Set-Service -Name "ssh-agent" -StartupType AutomaticDelayedStart
}