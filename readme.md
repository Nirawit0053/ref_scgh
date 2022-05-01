# SCGH automation

This is SCGH project repository, the following document will have an guideline on how the page be separate

## [Configuration Overview]
Installation Library as follow belows:
- DobbyCommonLibrary

&nbsp;
###  Preconditions
Install Robot Framework

The simplest way is using pip package manager:
```sh
pip install -r requirements.txt
 ```
####  [Command Line to run testcases]
**Example for WEB Run on Local**
```sh
robot -d ./log -v run_on:local /scgh/testcases/test.robot
 ```
 **Example for  WEB Run on Jenkisn**
```sh
COMMAND_ROBOT='robot --loglevel DEBUG -d ./log -v run_on:docker /scgh/testcases/test.robot' docker-compose -f ./cicd/docker/docker-compose.yaml up -d --build
 ```