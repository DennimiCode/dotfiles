oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/easy-term.omp.json" | Invoke-Expression
New-Alias vim nvim
New-Alias vi nvim
New-Alias g git
function gst
{
  git status
}
function wu
{
  winget update
}
function wid([string]$softwareId)
{
  winget install --id $softwareId
}
function wi
{
  winget install
}
function wfu
{
  winget upgrade --all
}
function wiu([string]$softwareId)
{
  winget upgrade --id $softwareId
}
function poweroff
{
  shutdown /s
}
function reboot
{
  shutdown /r
}
function gcl([string]$repoUrl)
{
  git clone $repoUrl
}
function ga([string]$file)
{
  git add $file
}