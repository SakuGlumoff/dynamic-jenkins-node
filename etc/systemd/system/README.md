# Jenkins-Agent service definition

This file is for creating a service to run the agent as a service (as opposed to a terminal session).

Create a file called `Jenkins-Agent.service` to this location.

The service file will consist of three different sections:

0. Unit
    * Description
    * What does the service require
    * When should the service be started and so on
1. Service
    * The type of the service
    * API links to their fulfilling scripts
    * Should the service restart and so on
2. Install
    * Should other services require this service or not

See `man systemd`, `man systemd.unit` and `man systemd.service` for more detailed info.
