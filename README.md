# LocomotiveCMS Backup Script
This script will backup all of your sites off of engine and optionally sends a status update via pushbullet everytime it's run. Ideally you'd want to set up a cronjon for this.

### Installation
Clone this repo and set the required environment variables in a .env file. Then set up a job in you crontab using

#### Required environment variables
```
ENGINE_URL=https://myengine.com
ENGINE_EMAIL=nice@email.net
ENGINE_API_KEY=verycoolapikey
```

#### Optional environment variables
```
FILE_DEST=/home/myuser/backups/
```
Full url to where the backups should be saved. If this is not set, backups will saved in the root directory of the script.
IMPORTANT: THE SCRIPT WILL NEED SUDO PRIVILEGES TO USE THE MV COMMAND>

#### Push notifications
Optionally, a PUSHBULLET_ACCES_TOKEN can be set in the .env file. This will push a status
