oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/easy-term.omp.json" | Invoke-Expression
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

if ((Get-module "git-aliases")) {
  Import-Module git-aliases -DisableNameChecking
} else {
  Install-Module -Name git-aliases -AllowClobber
}

New-Alias vim nvim
New-Alias vi nvim
New-Alias g git

# Winget aliases
function wu {
  winget update
}

function wid([string]$softwareId) {
  winget install --id $softwareId
}

function wi {
  winget install
}

function wfu {
  winget upgrade --all
}

function wiu([string]$softwareId) {
  winget upgrade --id $softwareId
}

# System aliases
function poweroff {
  shutdown /s
}

function reboot {
  shutdown /r
}
