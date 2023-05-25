### THEMES ###
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/zash.omp.json" | Invoke-Expression

# Use UTF-8 encoding for CJK support
$env:LC_ALL='C.UTF-8'
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

### MODULES ###
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile))
{
	Import-Module "$ChocolateyProfile"
}

if (Get-Module -ListAvailable -Name Terminal-Icons)
{
	Import-Module -Name Terminal-Icons
}

if (Get-Module -ListAvailable -Name PSFzf)
{
	Import-Module -Name PSFzf
	Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
} 

Function emacs
{
	Invoke-Expression "& 'C:\Program Files\Emacs\emacs-28.2\bin\emacs.exe' -nw"
}
