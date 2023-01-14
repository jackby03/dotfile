Import-Module posh-git
oh-my-posh init pwsh | Invoke-Expression
oh-my-posh init pwsh --config 'C:\User\jackd\AppData\Local\Programs\oh-my-posh\themes\peru.omp.json' | Invoke-Expression
Import-Module -Name Terminal-Icons

Set-Alias vim nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findtr

function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
  Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
