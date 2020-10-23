FROM cm2network/steamcmd:latest

# Zomboid Server AppID
ARG APPID=380870
ARG INSTALL_DIR=/home/steam/projectzomboid

# User Settings
ENV GAMEPORT        16261
ENV SERVER_NAME     "CHANGE-ME!"
ENV ADMIN_PASSWORD  "CHANGE-ME!"

USER root

COPY start.sh /home/steam/start.sh
RUN chmod +x /home/steam/start.sh

# Zomboid
RUN mkdir -p /home/steam/Zomboid && chown -R steam /home/steam/Zomboid
RUN ln -s /home/steam/Zomboid /server-data && chown -R steam /server-data

# Steam Docker Common
RUN mkdir -p ${INSTALL_DIR} && chown -R steam ${INSTALL_DIR}
RUN ln -s ${INSTALL_DIR} /server-files && chown -R steam /server-files

USER steam
RUN /home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir ${INSTALL_DIR} +app_update ${APPID} +quit

# steam ports
EXPOSE 8766/udp
EXPOSE 8767/udp

EXPOSE ${GAMEPORT}/udp

VOLUME /server-files
VOLUME /server-data

ENTRYPOINT ["/home/steam/start.sh"]