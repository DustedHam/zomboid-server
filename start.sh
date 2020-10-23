#!/bin/bash

/home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/steam/projectzomboid +app_update 380870 +quit
/home/steam/projectzomboid/start-server.sh -SERVER_NAME ${SERVER_NAME} -adminpassword ${ADMIN_PASSWORD} 
