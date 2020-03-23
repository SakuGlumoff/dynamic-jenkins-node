# Jenkins-Agent service controller

In here, create a file *Jenkins-Agent.sh* which will implement the systemd service API.

The APIs we're interested are:

1. start
    * Initializes and starts the service
2. stop
    * Kills the processes and deinitializes the service
2. status
    * Shows the current status of the service
3. restart
    * Stops and kills the old process, and creates and starts a new one

**Remember to start your controller script file with `#!/bin/sh`**

Add support for each API cases and save the file.
Remember to add the execute rights to all users, which can be done with
```bash
sudo chmod +x Jenkins-Agent.sh
```
