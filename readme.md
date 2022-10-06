# VidHop Docker

*An Alpine Linux Docker image with VidHop installed for Windows and other.*

## Functional Information

VidHop enables Linux users to download videos, songs, thumbnails, complete channels and playlists from popular video
platforms to their workstation.

Each download also saves the video **metadata** and its thumbnail (video banner image). When users download a channel or
playlist, the same happens for each video while also saving channel metadata. It's also possible to fetch **only** the
metadata of a video, channel or playlist.

**The metadata is what makes application powerful** as VidHop provides functions for users to query their collected metadata
using search words or sentences. Effectively, VidHop will look for the search word in video titles and descriptions
though the metadata contains other useful data like video, channel and thumbnail URLs. File extensions include mp4 (
video), json (metadata) and jpg (thumbnails).

Finally, VidHop provides many utilities for day-to-day use such as keeping a history, renaming of downloaded files,
inspect video specs of files and URLs, remove the last download or play it...

### Videos

- [VidHop Docker on Windows](https://odysee.com/@WTechGo:e/VidHop-for-Docker-Install-demo-extra-information:a)
- [An Introduction to VidHop](https://odysee.com/@WTechGo:e/Introduction-to-VidHop:0)
- [Installing VidHop from Scratch](https://odysee.com/@WTechGo:e/Install-VidHop-from-Scratch:c)
- [Sync VidHop between laptop and phone](https://odysee.com/@WTechGo:e/sync-vidhop-between-laptop-and-phone:1)

## Installation

### Prerequisites

You have `Docker` installed. If you haven't, [download Docker](https://docs.docker.com/get-docker/) 
for your operating system and install it.

Having [Git](https://git-scm.com/downloads) installed is 
recommended to download (`git clone`) now and to pull in updates (`git pull`) later on.

---

1. Copy the project to your computer.  
   ```
   # HTTPS
   git clone https://github.com/wtechgo/vidhop-docker.git && cd vidhop-docker
   
   # SSH
   git clone git@github.com:wtechgo/vidhop-docker.git && cd vidhop-docker
   ```  
   If you don't have `Git` installed, you can simply download the [zip file from GitHub](https://github.com/wtechgo/vidhop-docker/archive/refs/heads/master.zip).
2. Navigate into the project with your terminal. `Dockerfile` should be in your present working directory.
3. Build the VidHop Docker image.  
   `docker build -t vidhop-docker .`
4. Extra: A oneliner command in case you're rebuilding the Docker image a lot.  
```
# Build with cache.
docker stop $(docker ps -a -q); docker rm $(docker ps -a -q); docker build -t vidhop-docker . ; docker run --name vidhop-docker -v $PWD/media:/vidhop -v $PWD/vidhop/.bash_history:/root/.bash_history -it vidhop-docker /bin/bash

# Build without cache.
docker stop $(docker ps -a -q); docker rm $(docker ps -a -q); docker build --no-cache -t vidhop-docker . ; docker run --name vidhop-docker -v $PWD/media:/vidhop -v $PWD/vidhop/.bash_history:/root/.bash_history -it vidhop-docker /bin/bash
```

## Usage

1. Run the Docker container that we have just built.
   ```
   docker run --name vidhop-docker -v $PWD/media:/vidhop -v $PWD/vidhop/.bash_history:/root/.bash_history -it vidhop-docker /bin/bash
   ```
2. You are now in an Alpine Linux with VidHop pre-installed.  
   **Try a VidHop command !**  

   `dlv https://www.youtube.com/watch?v=-DT7bX-B1Mg`
   

3. Extra.
   - When you run into this Docker error:  
   `docker: Error response from daemon: Conflict. The container name "/vidhop-docker" is already in use`
   - You can stop and remove all Docker containers with this command:  
   `docker stop $(docker ps -a -q); docker rm $(docker ps -a -q)`
   - To alleviate this workflow check sections 
     [Configure Powershell Windows](#configure-powershell-windows) and 
     [Configure .bashrc Linux](#configure-bashrc-linux). 
   
A complete list of the commands is available in the [commands section](https://github.com/wtechgo/vidhop-docker#commands). 

### Media directory file permissions in Linux

Downloading with VidHop generates files in `$PWD/media` on the host computer (pwd is present working directory).

Those files however, are created by user `root` inside the Docker container.

Your user on host is not `root` in all likelihood, hence an error about permissions.  
For that scenario, run:    
`sudo chown -R $USER:$USER .`  
And if you want to delete VidHop data:  
`rm -rf media`

## Configure Powershell Windows

### Install VidHop scripts into Powershell

The file `Microsoft.PowerShell_profile.ps1` in this project, needs to be in one of these two locations.

```
C:\Users\<username>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
C:\Users\<username>\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1  # PS versions < 5
```

A `Microsoft.PowerShell_profile.ps1` file will be created in one of the above locations with command.  
``New-item –type file –force $profile``

`Microsoft.PowerShell_profile.ps1` is very similar to the `.bashrc` concept in Linux. It is a profile for all terminal 
sessions thereafter and ideal for declaring persistent custom variables and functions.

    ~/.bashrc <===> `%userprofile%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

*Source: [https://superuser.com/a/1009553/633101](https://superuser.com/a/1009553/633101).*

### Startup scripts inside `Microsoft.PowerShell_profile.ps1`

```
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
```

### Result

After you open a new Powershell terminal, you should be able to call `Vidhop-Start`, `Vidhop-Stop` etc.

### A suggestion for a better Powershell experience

Install `Windows Terminal` from the `Microsoft Store` and tune the appearance to your liking.

[Tutorial Free Code Camp: How to customize Windows Terminal appearance](https://www.freecodecamp.org/news/windows-terminal-themes-color-schemes-powershell-customize/).

[Windows Terminal themes](https://windowsterminalthemes.dev/).

The color scheme I used in the Docker video is `Dark Pastel` from [windowsterminalthemes.dev](https://windowsterminalthemes.dev).

## Configure .bashrc Linux

VidHop functions for a better terminal experience are in project file `.bashrc`. You can copy the content intro `~/.bashrc` 
or copy the file over `~/.bashrc`.

## Commands

Output from command `vidhophelp`

To see some of these commands in action, watch [An Introduction to VidHop](https://odysee.com/@WTechGo:e/Introduction-to-VidHop:0).

```
 Title: dlv
 Description: Download video(s) and channels.
 Commands:
    dlv <URL>     => download video at <URL> plus information (metadata, thumbnail)
    dlvi <URL>    => download video information only at <URL>, no mp4 download
    dlvpl <URL>   => download video playlist
    dlvpli <URL>  => download video playlist information
    dlc <URL>     => download channel, all videos, metadata and thumbnails
    dlci <URL>    => download channel information, same as dlc but no video downloads
    dla <URL>     => download audio, as mp3 from music videos
    dlalbum <URL> => download a music album as mp3
    dlapl <URL>   => download audio playlist
    dlapli <URL>  => download audio playlist information
    dlpod <URL>   => download podcast, technically also audio but we differentiate podcasts from music
    dlt <URL>     => download thumbnail, as jpg

 Title: fvid
 Description: Searches for <SEARCH_WORD> in all videos and channels metadata.
 Commands:
    fvid <SEARCH_TEXT>  => find videos where title or description matches <SEARCH_TEXT> in all videos and channels metadata
    fvidv <SEARCH_TEXT> => find videos where title or description matches <SEARCH_TEXT> in all videos metadata (shorter search time)
    fvidf <SEARCH_TEXT> => find videos where title or description matches <SEARCH_TEXT> in all video files on disk
    fvidc <SEARCH_TEXT> => find videos where title or description matches <SEARCH_TEXT> in all channels metadata
    fvidcv <CHANNEL_NAME> <SEARCH_TEXT> => find videos where title or description matches <SEARCH_TEXT> in channel with a name that matches <CHANNEL_NAME in a channels metadata
    fvidcv <CHANNEL_NAME> <SEARCH_TEXT> <PLATFORM> => find videos where title or description matches <SEARCH_TEXT> in channel with a name that matches <CHANNEL_NAME in a channels metadata for <PLATFORM> e.g youtube
    fvidusermeta <SEARCH_TEXT>  => find videos where user added metadata contains <SEARCH_TEXT>, execute 'metadata_help' for more information.
    chani <CHANNEL_NAME> => channel information, lists all videos of a channel with name matching <CHANNEL_NAME>
    chani <CHANNEL_NAME> <PLATFORM> => channel information, lists all videos of a channel with name matching <CHANNEL_NAME> with platform matching <PLATFORM>

 Title: files
 Description: Manage VidHop files.
 Commands:
    play                            => play last downloaded video in default media player (MPV recommended)
    play <PARTIAL_FILENAME>         => play video with filename that matches <PARTIAL_FILENAME> in default media player (MPV recommended)
    renvid <PARTIAL_OLD_FILENAME> <NEW_FILENAME>  => rename all files of a video that matches <PARTIAL_OLD_FILENAME>
    renlast <NEW_FILENAME>          => rename all files of last downloaded video to <NEW_FILENAME>
    rmvid <PARTIAL_FILENAME>        => remove all files of a video who's name matches <PARTIAL_FILENAME>
    rmlast                          => remove all files of last downloaded video
    rmchan <PARTIAL_CHANNEL_NAME>   => remove all files of a channel that matches <PARTIAL_CHANNEL_NAME>
    metadata                        => remove all files of a channel that matches <PARTIAL_CHANNEL_NAME>
    metadata <FILE_ABS_PATH>        => remove all files of a channel that matches <PARTIAL_CHANNEL_NAME>
    metadata <PARTIAL_CHANNEL_NAME> => remove all files of a channel that matches <PARTIAL_CHANNEL_NAME>
    specs                           => shows technical video information like codecs, resolution...of last downloaded video
    specs <URL>                     => shows technical video information like codecs, resolution...of a video at <URL>
    specs <PARTIAL_FILENAME>        => shows technical video information like codecs, resolution...of a video who's filename matches <PARTIAL_FILENAME>

 Title: metadata
 Description: Edit the metadata of downloads.
 Commands:
    setdescription <your_description> => Set a description in the metadata JSON file.
    setsummary <your_summary>         => Set a summary in the metadata JSON file.
    setcategories <your_categories>   => Set categories in the metadata JSON file.
    settopics <your_topics>           => Set topics in the metadata JSON file.
    setspeakers <your_speakers>       => Set speakers in the metadata JSON file.
    setcreators <your_creators>       => Set creators in the metadata JSON file.
    rmdescription <your_description>  => Remove a description in the metadata JSON file.
    rmsummary <your_summary>          => Remove a summary in the metadata JSON file.
    rmcategories <your_categories>    => Remove categories in the metadata JSON file.
    rmtopics <your_topics>            => Remove topics in the metadata JSON file.
    rmspeakers <your_speakers>        => Remove speakers in the metadata JSON file.
    rmcreators <your_creators>        => Remove creators in the metadata JSON file.

 Title: history
 Description: Show history of actions in VidHop.
 Commands:
    vhistory => shows the history of the videos you or metadata download
    chistory => shows the history of the channels you or metadata download
    ahistory => shows the history of the audio you or metadata download
    phistory => shows the history of the podcasts you or metadata download
    thistory => shows the history of the thumbnails you or metadata download

 Title: sync
 Description: Sync files between phone and workstation.
 Commands:
    syncvidhop  => fetch VidHop files from phone to workstation and send files from workstation to phone
    sendvidhop  => send files from workstation to phone
    fetchvidhop => fetch VidHop files from phone to workstation
```

## Technical Information

VidHop is in essence a collection of bash scripts users load in terminal via `.bashrc` or by calling the loader
`. vidhop` or `source vidhop` or another shell (also tested on zsh).

VidHop uses [YT-DLP](https://github.com/yt-dlp/yt-dlp) (written in Python) for downloading videos and metadata.
`install.sh` also installs FFmpeg for converting YT-DLP downloads when necessary.

Handling metadata JSON files happens with [JQ](https://github.com/stedolan/jq).

Finally, VidHop (`install.sh`) installs a bunch of useful packages
like `openssh, rsync, mediainfo, selenium and beautifulsoup4 (for scraping channel avatar images) and tor, proxychains-ng (for dealing with censored videos)`
.

## Other repositories

The `readme.md` in the [Vidhop Android](https://github.com/wtechgo/vidhop-android) 
and [VidHop Linux](https://github.com/wtechgo/vidhop-linux) repositories contains extra information 
for configuring `Sync` and `SSH`.


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
   