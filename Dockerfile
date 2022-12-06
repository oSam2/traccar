FROM openjdk:8-jre-alpine

ENV TRACCAR_VERSION 3.16

WORKDIR /opt/traccar

ADD ./setup/traccar.xml conf/traccar1.xml

RUN set -ex && \
    apk add --no-cache wget && \
    \
    wget -qO /tmp/traccar.zip https://github.com/tananaev/traccar/releases/download/v$TRACCAR_VERSION/traccar-other-$TRACCAR_VERSION.zip && \
    unzip -qo /tmp/traccar.zip -d /opt/traccar && \
    rm /tmp/traccar.zip && \
    \
    apk del wget

EXPOSE 8082
# EXPOSE 6543:5432

ENTRYPOINT ["java"]

CMD ["-Djava.net.preferIPv4Stack=true", "-Xms512m", "-jar", "tracker-server.jar", "conf/traccar1.xml"]

