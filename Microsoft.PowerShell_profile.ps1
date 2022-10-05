# Type the following command to create the file:  
# `New-item –type file –force $profile`
#
# A file Microsoft.PowerShell_profile.ps1 will be created in 
# %userprofile%\Documents\WindowsPowerShell\ for PowerShell 5 and older or
# %userprofile%\Documents\PowerShell\ for PowerShell 6 Core (this folder will be automatically created).
#
# Then edit this file and you can add personalized PowerShell functions or load modules or snap-ins...
#
# Now when you run your powershell console, Microsoft.PowerShell_profile.ps1 will be triggered.


Function Prompt {"$(Get-Location) $ "}

Function Remove-Directory([string]$path) {
     if ($path -eq ""){
          Write-Output "usage:`n  Remove-Directory <PATH>"
          return
     }
     Remove-Item $path -Force  -Recurse -ErrorAction SilentlyContinue
}

Function Start-Vidhop() {
     if (-Not (Test-Path $PWD/media) -And -Not (Test-Path $PWD/vidhop/.bash_history)) {
          Write-Output "could not find /media and vidhop/.bash_history"
          Write-Output "you are not inside the vidhop-docker directory"
          Write-Output "navigate to the vidhop-docker directory and try again"
          return
     }
     echo "clearing running instances of vidhop-docker..."
     docker stop "$(docker ps -a -q)"
     docker rm "$(docker ps -a -q)"
     clear
     docker run --name vidhop-docker -v $PWD/media:/vidhop -v $PWD/vidhop/.bash_history:/root/.bash_history -it vidhop-docker /bin/bash
}

Function Stop-Vidhop() {
     docker stop "$(docker ps -a -q)"
     docker rm "$(docker ps -a -q)"
}

Function Build-Vidhop() {
     if ( -Not (Test-Path Dockerfile)){
          Write-Output "no Dockerfile in this directory, abort"
          return
     }
     docker build -t vidhop-docker .
}

Function BuildNoCache-Vidhop() {
     if ( -Not (Test-Path Dockerfile)){
          Write-Output "no Dockerfile in this directory, abort"
          return
     }
     docker build --no-cache -t vidhop-docker .
}

Function Clear-DockerContainers {
     docker stop $(docker ps -a -q)
     docker rm $(docker ps -a -q)
}
