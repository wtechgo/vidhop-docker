# VidHop Docker

Alpine with bash and VidHop installed.

## Installation

1. Copy the project to your computer.  
   `git clone https://github.com/wtechgo/vidhop-docker.git && cd vidhop-docker` 
2. Build the VidHop Docker image.  
`docker build -t vidhop-docker .`
   
## Usage

1. Run the Docker container that we have just built.  
`docker run --name vidhop-docker -it vidhop-docker /bin/bash`

2. If that worked, expand the previous command with your VidHop media directory (where VidHop saves your downloads).
`docker run --name vidhop-docker -v "YOUR/PATH/TO/VIDHOP/MEDIA":/root/VidHop -it vidhop-docker /bin/bash`

3. You are now in an Alpine Linux with VidHop pre-installed.  
   Try a VidHop command!  
`dlv https://www.youtube.com/watch?v=-DT7bX-B1Mg`
   