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


## Documentation

There is better documentation available in the [Vidhop Android](https://github.com/wtechgo/vidhop-android) 
and [VidHop Linux](https://github.com/wtechgo/vidhop-linux) repositories.


## Credits

Special thanks to the incredibly awesome projects [YT-DLP](https://github.com/yt-dlp/yt-dlp),
[JQ](https://github.com/stedolan/jq) and [Termux](https://f-droid.org/en/packages/com.termux/).

## Support

<h3>Buy Me A Coffee</h3>
<a href="https://www.buymeacoffee.com/wtechgo">
<img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee - WTechGO" width="150" />
</a>
<h3>Bitcoin</h3>
<a href="https://github.com/wtechgo/vidhop-android/blob/master/img/qr_bitcoin_wtechgo.png?raw=true">
<img src="https://github.com/wtechgo/vidhop-android/blob/master/img/qr_bitcoin_wtechgo.png?raw=true" alt="Bitcoin" width="100"/>
</a>
<pre>bc1qkxqz0frjhx6gshm0uc668zx6686xtfsxdm67u3</pre>
<h3>Monero</h3>
<a href="https://github.com/wtechgo/vidhop-android/blob/master/img/qr_monero_wtechgo.png?raw=true">
<img src="https://github.com/wtechgo/vidhop-android/blob/master/img/qr_monero_wtechgo.png?raw=true" alt="Monero" width="100" />
</a>
<pre>8BNDojnvwYkacFwztY3XsjefCr28zTDraTgzdFLH8JiL5W4eMjTuHCu57LkCy9UHKHZfGzWDo6ErDYDP4jBK814aG2T8z8c</pre>
   