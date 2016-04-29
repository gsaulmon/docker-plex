FROM fedora:23

ENV PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR /config/Library/Application Support
ENV PLEX_MEDIA_SERVER_HOME /usr/lib/plexmediaserver
ENV PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS 6
ENV PLEX_MEDIA_SERVER_TMPDIR /tmp
ENV LD_LIBRARY_PATH /usr/lib/plexmediaserver
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN dnf update -y \
        && dnf install -y nodejs wget tar \
        && dnf clean all \
	      && /bin/mkdir -p "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}" \
        && dnf install -y https://downloads.plex.tv/plex-media-server/0.9.16.6.1993-5089475/plexmediaserver-0.9.16.6.1993-5089475.x86_64.rpm || :

VOLUME /config
VOLUME /data

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 32400

ENTRYPOINT ["/start.sh"]
