# Docker commands

## Building a Docker image

Build image.  
`docker build -t vidhop-docker .`

Start a container and enter bash interactively.  
`docker run --name vidhop-docker -it vidhop-docker /bin/bash`

Start a bash session in a container that's already running.  
The 'name' directive also matches partial names.  
`docker exec -it $(cddocker ps -aqf "name=vidhop-docker") bash`

Repeated builds require a oneliner.  
`dclear; docker build -t vidhop-docker . && docker run --name vidhop-docker -it vidhop-docker /bin/bash`

Logs of the vidhop-docker container.
```
docker logs $(docker ps -aqf "name=vidhop-docker")
docker logs vidhop-docker   # I think this works too.
```

## Manage containers

Stop running containers and remove the containers (not the images).
```shell
function dclear () {
  docker stop $(docker ps -a -q)
  docker rm $(docker ps -a -q)
}
```
