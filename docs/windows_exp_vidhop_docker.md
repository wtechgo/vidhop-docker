# Getting started with vidhop-docker on Windows

- Installed Alpine WSL from Microsoft Store.
- Start Alpine WSL session with `alpine` in Powershell.
	- In Powershell because e.g. this command did not work in command prompt:  
	  `docker stop $(docker ps -a -q); docker rm $(docker ps -a -q);`
- docker build -t vidhop-docker .
- docker run --name vidhop-docker -v $PWD/media:/vidhop -it vidhop-docker /bin/bash

Color schemes for Windows prompt.
https://gist.github.com/P4/4245793

Color scheme for Powershell ?
