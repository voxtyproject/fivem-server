FROM alpine

ENV FIVEM_DATA="https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/5104-5ebb6dfe826667c841027d6dbc7390e42abfb196/fx.tar.xz"

ENV SERVER_DATA="/usr/share/voxtyproject/fivem-server"

WORKDIR ${SERVER_DATA}

RUN apk upgrade \
    && apk add --no-cache ca-certificates curl git yarn

RUN git clone https://github.com/citizenfx/cfx-server-data . \
    && curl ${FIVEM_DATA} --output fx.tar.xz \
    && tar -xf fx.tar.xz 

COPY . .

EXPOSE 30120/tcp 30120/udp

#ENTRYPOINT [ ]

CMD [ "sh", "run.sh", "+exec", "server.cfg" ]