FROM alpine AS builder

RUN apk update && \
    apk --no-cache --update add build-base

RUN apk add git automake autoconf libtool unbound-dev

#.clone source and build binary file
RUN git clone git://github.com/handshake-org/hnsd.git && \
    cd hnsd && \
    ./autogen.sh && ./configure && make

#.hnsd image
FROM alpine:latest

# Install Certificates to establish SSL/TLS communication
RUN apk update && apk upgrade && \
    apk --no-cache add ca-certificates

#.required dependencis
RUN apk add unbound-libs

#.copy binaries files

COPY --from=builder /hnsd/hnsd /usr/local/bin/hnsd

#.start hnsd

ENTRYPOINT ["/usr/local/bin/hnsd"]

CMD []