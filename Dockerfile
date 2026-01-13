ARG JAVA_VERSION=17.0.10-tem
ARG MAVEN_VERSION=3.9.6

FROM lscr.io/linuxserver/openvscode-server:latest

ENV SDKMAN_DIR /app/.sdkman
ENV JAVA_VERSION ${JAVA_VERSION}
ENV JAVA_HOME $SDKMAN_DIR/candidates/java/current
ENV MAVEN_VERSION ${MAVEN_VERSION}
ENV MAVEN_HOME $SDKMAN_DIR/candidates/maven/current
ENV PATH=${PATH}:$JAVA_HOME/bin:$MAVEN_HOME/bin

RUN apt-get update && apt-get install -y zip curl
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN curl -s "https://get.sdkman.io" | bash
RUN chmod a+x "$SDKMAN_DIR/bin/sdkman-init.sh"
RUN set -x \
    && echo "sdkman_auto_answer=true" > $SDKMAN_DIR/etc/config \
    && echo "sdkman_auto_selfupdate=false" >> $SDKMAN_DIR/etc/config \
    && echo "sdkman_insecure_ssl=false" >> $SDKMAN_DIR/etc/config

WORKDIR $SDKMAN_DIR
RUN [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh" && exec "$@"
RUN source "$SDKMAN_DIR/bin/sdkman-init.sh" && sdk install java $JAVA_VERSION
RUN source "$SDKMAN_DIR/bin/sdkman-init.sh" && sdk install maven $MAVEN_VERSION

RUN /app/openvscode-server/bin/openvscode-server --install-extension vscjava.vscode-java-pack
RUN /app/openvscode-server/bin/openvscode-server --install-extension vscjava.vscode-maven
RUN /app/openvscode-server/bin/openvscode-server --install-extension vmware.vscode-boot-dev-pack
RUN /app/openvscode-server/bin/openvscode-server --install-extension mblode.pretty-formatter
RUN /app/openvscode-server/bin/openvscode-server --install-extension pkief.material-icon-theme


WORKDIR /code
RUN chmod -R 777 /code
