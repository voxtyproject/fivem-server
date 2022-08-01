FROM alpine

ENV FIVEM_ARTIFACT="https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/5774-7dd991582b990411930c2a452265c9b2144ae576/fx.tar.xz"

ENV SERVER_DATA="/usr/share/voxtyproject/fivem-server"

WORKDIR ${SERVER_DATA}

RUN apk upgrade \
    && apk add --no-cache ca-certificates curl git yarn

RUN git clone https://github.com/citizenfx/cfx-server-data . \
    && curl ${FIVEM_ARTIFACT} --output fx.tar.xz \
    && tar -xf fx.tar.xz 

COPY . .

EXPOSE 30120/tcp 30120/udp

ENTRYPOINT [ "sh", "run.sh" ]

CMD [ "+exec", "server.cfg" ]
