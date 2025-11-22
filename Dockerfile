FROM ubuntu:18.04 as builder

WORKDIR /ntripcaster

RUN apt-get update && apt-get install -y \
    build-essential \
    autoconf \
    automake \
    libtool

# Copiar solo la carpeta con el código fuente
COPY ntripcaster /ntripcaster

RUN ./configure
RUN make
RUN make install

# Imagen final
FROM ubuntu:18.04

COPY --from=builder /usr/local/ntripcaster/ /usr/local/ntripcaster/

EXPOSE 2101
WORKDIR /usr/local/ntripcaster/logs

CMD ["/usr/local/ntripcaster/bin/ntripcaster"]
