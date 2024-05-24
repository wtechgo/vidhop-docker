# VidHop Docker

*An Alpine Linux Docker image with VidHop installed for Windows and other operating systems.*

## Functional Information

VidHop enables users to download videos, songs, thumbnails, complete channels and playlists from popular video
platforms to their workstation.

Each download also saves the video **metadata** and its thumbnail (video banner image). When users download a channel or
playlist, the same happens for each video while also saving channel metadata. It's also possible to fetch **only** the
metadata of a video, channel or playlist.

**The metadata is what makes the application powerful** as VidHop provides functions for users to query their collected metadata
using search words or sentences. Effectively, VidHop will look for the search word in video titles and descriptions
though the metadata contains other useful data like video, channel and thumbnail URLs. File extensions include mp4 (
video), json (metadata) and jpg (thumbnails).

Finally, VidHop provides many utilities for day-to-day use such as keeping a history, renaming of downloaded files,
inspect video specs of files and URLs, remove the last download or play it... Read the 
[commands section](https://github.com/wtechgo/vidhop-docker#commands) for more information.

### Videos

- [VidHop Docker on Windows](https://odysee.com/@WTechGo:e/VidHop-for-Docker-Install-demo-extra-information:a)
- [An Introduction to VidHop](https://odysee.com/@WTechGo:e/Introduction-to-VidHop:0)
- [Installing VidHop from Scratch](https://odysee.com/@WTechGo:e/Install-VidHop-from-Scratch:c)
- [Sync VidHop between laptop and phone](https://odysee.com/@WTechGo:e/sync-vidhop-between-laptop-and-phone:1)
- [Explanation project module, config.ini, batch download and switch environment](https://odysee.com/@WTechGo:e/VidHop---Project-module,-config.ini,-batch-import,-switch-env:a)

## Prerequisites

### Docker

You have `Docker` installed. If you haven't, [download Docker](https://docs.docker.com/get-docker/) 
for your operating system and install it.

### Git

It's highly recommended you install [Git](https://git-scm.com/downloads).  
With Git, you can do the initial VidHop software download and more importantly, easily download updates in the future.

### No fear of the command prompt

The `command prompt` (aka terminal) is a program that allows you to type and execute commands. All computers have a command prompt.

On **Windows**, hit Windows key, type "powershell" and hit enter.  

On **MAC**, hit command+space keys (at the same time) to bring up Apple’s Spotlight universal search, then
type “terminal” so “Terminal.app” appears.  

On **Linux** it varies. On Gnome, hit super key and type "terminal" or look for Terminal in your application overview.

## Installation

1. Copy the VidHop software to your computer, in a location (directory) where you want VidHop, 
   and all the videos you download with it, to be.  
   <br>
   These instructions will use the default `Videos` directory as home for VidHop.  
   Remember when you see `Videos` in this document, that is what we're talking about.  
   <br>
   Default `Videos` directory by operating system (OS):  
   
   | OS      | Path                              |
   | ------- | --------------------------------- |
   | Windows | `C:\Users\<YOUR_USERNAME>\Videos` |
   | Linux   | `/home/<YOUR_USERNAME>/Videos`    |
   | MAC     | `/Users/<YOUR_USERNAME>/Videos`   |

   **Option 1**: **Copy files with Git** (recommended).  
   1. Open a `command prompt` and navigate to `Videos`.  
      ```
      cd Videos
      ```
   2. Copy the command below, paste it in `command prompt` (with right-mouse-click) and hit enter.

      ```
      git clone https://github.com/wtechgo/vidhop-docker.git
      ```
   
   **Option 2**: **Download [VidHop software ZIP file](https://github.com/wtechgo/vidhop-docker/archive/refs/heads/master.zip)** from GitHub.  
   1. Rename the downloaded file from `vidhop-docker-master.zip` to `vidhop-docker.zip`
   2. Unzip `vidhop-docker.zip`, when done you should have a directory `vidhop-docker`.
   3. Move the unzipped directory `vidhop-docker` to `Videos`.  
   4. Open a `command prompt` and navigate to `Videos` (required for the next step, 2.).  
   

2. Navigate the `command prompt` into the VidHop directory `vidhop-docker` with command:  
   ```
   cd vidhop-docker
   ```  
   You should be able to see `Dockerfile` when you are in the correct directory.  
   You can list the contents of your current directory with these commands.
   ```
   # In Windows
   dir
   
   # In MAC & Linux
   ls
   ```  

3. Build the VidHop Docker image.  
   `docker build -t vidhop-docker .`  
   This can take a few minutes, but we only have to do this once.
4. Awesome! Now we can start using VidHop.

## Usage

1. **Start VidHop**.  
   Copy the command below, paste it in the command prompt and hit enter.
   ```
   # Linux & macOS
   docker run --name vidhop-docker -v ${PWD}/media:/vidhop -v ${PWD}/vidhop/config/.bash_history:/root/.bash_history -it vidhop-docker /bin/bash
   
   # Windows (replaced `${PWD}` with `%cd%`)
   docker run --name vidhop-docker -v %cd%/media:/vidhop -v %cd%/vidhop/config/.bash_history:/root/.bash_history -it vidhop-docker /bin/bash
   ```
2. The terminal changes its label to `root@vidhop8>`, congratulations!    
   You are now in a running Alpine Linux with VidHop pre-installed.  
   **Try a VidHop command !**  
   ```
   dlv https://www.youtube.com/watch?v=-DT7bX-B1Mg`
   ```
3. See the files `dlv` downloaded with `ls`.    
   <br>
   Extra: Windows users might be confused at this point.  
   Why not `dir` as we did before?  
   When you are using VidHop, `command prompt` is inside a Linux operating system, not Windows.  
   More precisely, inside an Alpine Linux that is running inside a Docker container.

A complete list of the VidHop commands is available in the [commands section](https://github.com/wtechgo/vidhop-docker#commands) 
and you can get up to speed by watching the [video links at the top of this page](https://github.com/wtechgo/vidhop-docker#Videos).  

## Troubleshooting

- When you run into this Docker error:  
`docker: Error response from daemon: Conflict. The container name "/vidhop-docker" is already in use`
- You can stop and remove all Docker containers with this command:  
`docker stop $(docker ps -a -q); docker rm $(docker ps -a -q)`
- To alleviate this workflow check sections 
  [Configure Powershell Windows](#configure-powershell-windows) and 
  [Configure .bashrc Linux](#configure-bashrc-linux). 
  
### Media directory file permissions in Linux

Downloading with VidHop generates files in `${PWD}/media` on the host computer (pwd is present working directory).

Those files however, are created by user `root` inside the Docker container.

Your user on host is not `root` in all likelihood, hence an error about permissions.  
For that scenario, run:    
`sudo chown -R $USER:$USER .`  
And if you want to delete VidHop data:  
`rm -rf media`

## Update VidHop

1. Start VidHop.
2. Inside Vidhop, run:  
`updatevidhop`
   
## Update Docker container

Rarely required, though when there are changes in `Dockerfile`, for example after adding or removing system packages 
(inside Alpine Docker), then the container has to be rebuilt.

Steps:

1. Navigate to the `vidhop-docker` project root directory. You should see at least these files and directories.
   ```angular2html
   media (dir)
   vidhop  (dir)
   .bashrc
   .gitignore
   Dockerfile
   Microsoft.PowerShell_profile.ps1
   readme.md
   ```
2. Execute `git pull`
3. Execute `docker build --no-cache -t vidhop-docker .`
4. Start VidHop.  
   `docker run --name vidhop-docker -v ${PWD}/media:/vidhop -v ${PWD}/vidhop/config/.bash_history:/root/.bash_history -it vidhop-docker /bin/bash`  
   or, use the shortcuts from .bashrc or Microsoft.PowerShell_profile.ps1

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

    ~/.bashrc <=> `%userprofile%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

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
     if (-Not (Test-Path ${PWD}/media) -And -Not (Test-Path ${PWD}/vidhop/config/.bash_history)) {
          Write-Output "could not find /media and vidhop/.bash_history"
          Write-Output "you are not inside the vidhop-docker directory"
          Write-Output "navigate to the vidhop-docker directory and try again"
          return
     }
     echo "clearing running instances of vidhop-docker..."
     docker stop "$(docker ps -a -q)"
     docker rm "$(docker ps -a -q)"
     clear
     docker run --name vidhop-docker -v ${PWD}/media:/vidhop -v ${PWD}/vidhop/config/.bash_history:/root/.bash_history -it vidhop-docker /bin/bash
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

After you open a new Powershell terminal, you should be able to call `Start-Vidhop`, `Stop-Vidhop` etc.

### A suggestion for a better Powershell experience

Install `Windows Terminal` from the `Microsoft Store` and tune the appearance to your liking.

[Tutorial Free Code Camp: How to customize Windows Terminal appearance](https://www.freecodecamp.org/news/windows-terminal-themes-color-schemes-powershell-customize/).

[Windows Terminal themes](https://windowsterminalthemes.dev/).

The color scheme I used in the Docker video is `Dark Pastel` from [windowsterminalthemes.dev](https://windowsterminalthemes.dev).

## Configure .bashrc Linux

VidHop functions for a better terminal experience are in project file `.bashrc`. You can copy the content into `~/.bashrc` 
or copy the file over `~/.bashrc`.

## Commands

Output from command `vidhophelp`

To see some of these commands in action, watch [An Introduction to VidHop](https://odysee.com/@WTechGo:e/Introduction-to-VidHop:0).

```
 Title: dlv
 Description: Download video(s) and channels.
 Commands:
    dlv <URL>     => download video at <URL> plus information (metadata, thumbnail) into /VidHop/videos
    dlv -c <URL>  => download comments while doing dlv, appended to metadata.json into /VidHop/videos
    dlvi <URL>    => download video information only at <URL>, no mp4 download into /VidHop/metadata/videos
    dlvi -c <URL> => download comments while doing dlvi, appended to metadata.json into /VidHop/metadata/videos
    dlvpl <URL>   => download video playlist into /VidHop/channels/<CHANNEL_NAME>/<PLAYLIST_NAME>
    dlvpli <URL>  => download video playlist information into /VidHop/metadata/channels/<CHANNEL_NAME>/<PLAYLIST_NAME>
    dlc <URL>     => download channel, all videos, metadata and thumbnails into /VidHop/channels
    dlci <URL>    => download channel information, same as dlc but no video downloads into /VidHop/metadata/channels
    dla <URL>     => download audio, as m4a from music videos into /VidHop/music
    dlalbum <URL> => download a music album as m4a into /VidHop/music/<ALBUM_NAME>
    dlapl <URL>   => download audio playlist into /VidHop/music/<CHANNEL_NAME>/<PLAYLIST_NAME>
    dlapli <URL>  => download audio playlist information into /VidHop/metadata/music/<CHANNEL_NAME>/<PLAYLIST_NAME>
    dlpod <URL>   => download podcast or audio tape into /VidHop/podcasts
    dlt <URL>     => download thumbnail and metadata as jpg into /VidHop/thumbnails
    dlfbpost <URL>  => download facebook post metadata, no images into /VidHop/social_media
    dltweet <URL>   => download twitter tweet metadata, no images into /VidHop/social_media
    dlwebsite <URL> => download page or complete website with images into /VidHop/website
    dlw <URL>       => alias for dlwebsite

 Title: fvid
 Description: Find videos for <SEARCH_TEXT> in all videos and channels metadata.
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
    play                            => play last downloaded video in default media player e.g. MPV or VLC
    play <PARTIAL_FILENAME>         => play video with filename that matches <PARTIAL_FILENAME> in default media player e.g. MPV or VLC
    renvid <PARTIAL_OLD_FILENAME> <NEW_FILENAME>  => rename all files of a video that matches <PARTIAL_OLD_FILENAME>
    renlast <NEW_FILENAME>          => rename all files of last downloaded video to <NEW_FILENAME>
    rmvid <PARTIAL_FILENAME>        => remove all files of a video who's name matches <PARTIAL_FILENAME>
    rmlast                          => remove all files of last downloaded video
    rmchan <PARTIAL_CHANNEL_NAME>   => remove all files of a channel that matches <PARTIAL_CHANNEL_NAME>
    specs                           => shows technical video information like codecs, resolution...of last downloaded video
    specs <URL>                     => shows technical video information like codecs, resolution...of a video at <URL>
    specs <PARTIAL_FILENAME>        => shows technical video information like codecs, resolution...of a video who's filename matches <PARTIAL_FILENAME>

 Title: metadata
 Description: Edit the metadata of downloads.
 Commands:
    metadata                     => show metadata of last download
    metadata <FILE_ABS_PATH>     => show metadata for file with absolute path
    setdescription <DESCRIPTION> => set a description in the metadata JSON file of the last download
    setsummary <SUMMARY>         => set a summary in the metadata JSON file of the last download
    setcategories <CATEGORIES>   => set categories in the metadata JSON file of the last download
    settopics <TOPICS>           => set topics in the metadata JSON file of the last download
    setspeakers <SPEAKERS>       => set speakers in the metadata JSON file of the last download
    setcreators <CREATORS>       => set creators in the metadata JSON file of the last download
    settimestamps <CREATORS>     => set timestamps in the metadata JSON file of the last download
    addtimestamps <CREATORS>     => add (append) timestamps in the metadata JSON file of the last download
    rmdescription <DESCRIPTION>  => remove a description in the metadata JSON file of the last download
    rmsummary <SUMMARY>          => remove a summary in the metadata JSON file of the last download
    rmcategories <CATEGORIES>    => remove categories in the metadata JSON file of the last download
    rmtopics <TOPICS>            => remove topics in the metadata JSON file of the last download
    rmspeakers <SPEAKERS>        => remove speakers in the metadata JSON file of the last download
    rmcreators <CREATORS>        => remove creators in the metadata JSON file of the last download
    rmtimestamps <CREATORS>      => remove timestamps in the metadata JSON file of the last download
    setdescription <DESCRIPTION> [<PARTIAL_FILENAME>] => set a description in the metadata file that matches the partial filename
    rmdescription <DESCRIPTION> [<PARTIAL_FILENAME>]  => remove a description in the metadata file that matches the partial filename
                                                note  => the two previous examples including [<PARTIAL_FILENAME>]
                                                         expose the mechanism applicable to all other 'set' and 'rm' metadata methods

 Title: history
 Description: Show history of actions in VidHop.
 Commands:
    vhistory => shows the history of the videos you downloaded
    chistory => shows the history of the channels you downloaded
    ahistory => shows the history of the audio you downloaded
    phistory => shows the history of the podcasts you downloaded
    thistory => shows the history of the thumbnails you downloaded
    
 Title: batch
 Description: Do work in bulk aka batch processing.
 Commands:
    dlalist [<LIST_FILE_PATH>]     => download all URLs in list file at /VidHop/import/list/dla.list
    dlaclist [<LIST_FILE_PATH>]RL> => download all URLs in list file at /VidHop/import/list/dlac.list
    dlacilist [<LIST_FILE_PATH>]   => download all URLs in list file at /VidHop/import/list/dlaci.list
    dlalbumlist [<LIST_FILE_PATH>> => download all URLs in list file at /VidHop/import/list/dlalbum.list
    dlapllist [<LIST_FILE_PATH>]   => download all URLs in list file at /VidHop/import/list/dlapl.list
    dlaplilist [<LIST_FILE_PATH>]  => download all URLs in list file at /VidHop/import/list/dlapli.list
    dlclist [<LIST_FILE_PATH>]     => download all URLs in list file at /VidHop/import/list/dlc.list
    dlcilist [<LIST_FILE_PATH>]    => download all URLs in list file at /VidHop/import/list/dlci.list
    dlpodlist [<LIST_FILE_PATH>]   => download all URLs in list file at /VidHop/import/list/dlpod.list
    dltlist [<LIST_FILE_PATH>]     => download all URLs in list file at /VidHop/import/list/dlt.list
    dlvlist [<LIST_FILE_PATH>]     => download all URLs in list file at /VidHop/import/list/dlv.list
    dlvilist [<LIST_FILE_PATH>]    => download all URLs in list file at /VidHop/import/list/dlvi.list
    dlvpllist [<LIST_FILE_PATH>]   => download all URLs in list file at /VidHop/import/list/dlvpl.list

 Title: sync
 Description: Sync files between phone and workstation.
 Commands:
   syncvidhop  => fetch VidHop files from phone to workstation and send files from workstation to phone
               => syncvidhop executes sendvidhop and fetchvidhop
   sendvidhop  => send files from workstation to phone
   fetchvidhop => fetch VidHop files from phone to workstation
 Prerequisites:
   1. the IP-address and user have to be known in the 'sync' file, optionally via config.ini
   2. passwordless public SSH keys should be configured on phone and workstation (or you'll have to type passwords)
   3. start sshd on workstation and phone (Termux)
 Notes:
   sendvidhop sends all VidHop files, keeps the metadata files and deletes media files to not clog up the phone
   fetchvidhop fetches only metadata files to enable video searches in Termux via the fvid command
 Troubleshoot:
   No permissions error was solved by disabling the firewall on the workstation.
    
 Title: project
 Description: Create projects scaffolding and link VidHop video files.
 Commands:
    project <PROJECT_NAME> => Create new project with <PROJECT_NAME> in $projects_dir.
    subproject <PROJECT_NAME> <SUBPROJECT_NAME>      => Create new subproject in <PROJECT_NAME> as <SUBPROJECT_NAME>.
    linkvid4project <VIDEO_FILE> <PROJECT_NAME>      => Creates a symbolic link of given <VIDEO_FILE> in project with name <PROJECT_NAME>.
    link-videos4project <SEARCH_TEXT> <PROJECT_NAME> => Creates symbolic links in <PROJECT_NAME> for all video files found by fvidf <SEARCH_TEXT> (happens in the background).
    fproj <SEARCH_TEXT>      => Find files whose name match <SEARCH_TEXT> in all projects.
    absfproj <SEARCH_TEXT>   => Identical to fproj but results are displayed as absolute paths.
    rmproject <PROJECT_NAME> => Remove the project with as name <PROJECT_NAME>.

 Title: loader
 Description: VidHop management functions.
 Commands:
    updatevidhop    => default update
    uninstallvidhop => remove all VidHop executables, downloaded data in the VidHop directory will NOT be deleted
    installloader   => alias for install_loader
    install_loader  => enables users to reload with '. vidhop
    fetch_github    => download the newest VidHop code from GitHub
    update_python_packages => updates Python packages with pip (package manager)
```

## `config.ini` for user-specific settings

The variables defined in `config.ini` will overwrite VidHop defaults defined in `/vidhop/bin/vars`.

VidHop will look for `config.ini` at `/vidhop/config/config.ini`.

You can copy and, or rename `config.ini.template` to `config.ini` and customize it to match your needs. 

Configurations defined in `config.ini` will "survive" updates which would otherwise overwrite `sync` and `vars` files.

## Technical Information

VidHop is in essence a collection of bash scripts users load in terminal via `.bashrc` or by calling the loader
`. vidhop` or `source vidhop`.

VidHop uses [YT-DLP](https://github.com/yt-dlp/yt-dlp) (written in Python) for downloading videos and metadata.
`install.sh` also installs FFmpeg for converting YT-DLP downloads when necessary.

Handling metadata JSON files happens with [JQ](https://github.com/stedolan/jq).

Finally, VidHop (`install.sh`) installs a bunch of useful packages
like `openssh, rsync, mediainfo, selenium and beautifulsoup4 (for scraping channel avatar images) and tor, proxychains-ng (for dealing with censored videos)`
.

## Other repositories

The `readme.md` in the [Vidhop Android](https://github.com/wtechgo/vidhop-android) 
and [VidHop Linux](https://github.com/wtechgo/vidhop-linux) repositories contain extra information 
for configuring `vidhopsync` and `SSH`.

## Credits

Special thanks to the incredibly awesome projects [YT-DLP](https://github.com/yt-dlp/yt-dlp),
[JQ](https://github.com/stedolan/jq) and [Termux](https://f-droid.org/en/packages/com.termux/).

## Rebuilding the Docker image

A oneliner command in case you're rebuilding the Docker image a lot.  

```
# Build with cache.
docker stop $(docker ps -a -q); docker rm $(docker ps -a -q); docker build -t vidhop-docker . ; docker run --name vidhop-docker -v ${PWD}/media:/vidhop -v ${PWD}/vidhop/config/.bash_history:/root/.bash_history -it vidhop-docker /bin/bash

# Build without cache.
docker stop $(docker ps -a -q); docker rm $(docker ps -a -q); docker build --no-cache -t vidhop-docker . ; docker run --name vidhop-docker -v ${PWD}/media:/vidhop -v ${PWD}/vidhop/config/.bash_history:/root/.bash_history -it vidhop-docker /bin/bash
```

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
<a href="https://github.com/wtechgo/vidhop-linux/blob/master/img/qr_monero_wtechgo.png?raw=true">
    <img src="https://github.com/wtechgo/vidhop-linux/blob/master/img/qr_monero_wtechgo.png?raw=true" alt="Monero" width="100" />
</a>
<pre>82VmqH7HPAaDMHvGQhS9jze2Gorjkd5xAdnvpsEGyAJu8oGcxRHqErpgZobCFGT4F5CUmEcwCm79zMdXH7FTinpbVi7bTcn</pre>
