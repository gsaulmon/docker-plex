FROM fedora:20

ENV PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR /config/Library/Application Support
ENV PLEX_MEDIA_SERVER_HOME /usr/lib/plexmediaserver
ENV PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS 6
ENV PLEX_MEDIA_SERVER_TMPDIR /tmp
ENV LD_LIBRARY_PATH /usr/lib/plexmediaserver
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN yum update -y \
        && yum clean all \
	&& /bin/mkdir -p "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}" \
        && yum localinstall -y https://downloads.plex.tv/plex-media-server/0.9.15.6.1714-7be11e1/plexmediaserver-0.9.15.6.1714-7be11e1.x86_64.rpm || :

VOLUME /config
VOLUME /data

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 32400

ENTRYPOINT ["/start.sh"]
