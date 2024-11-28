FROM alpine:3.20.3
ARG VERSION=openldap-2.6.9
RUN mkdir -p /app /var/openldap-data /etc/slapd.d && \
    apk --update-cache update && \
    apk --update-cache add openssl ca-certificates unixodbc && \
    apk --update-cache add --virtual build-dependencies wget build-base openssl-dev unixodbc-dev groff && \
    wget -O /app/${VERSION}.tgz https://mirror.eu.oneandone.net/software/openldap/openldap-release/${VERSION}.tgz && \
    tar -xvf /app/${VERSION}.tgz -C /app && \
    rm -f /app/${VERSION}.tgz && \
    cd /app/${VERSION} && \
    ./configure \
        --prefix="/" \
        --enable-debug=yes \
        --enable-dynamic=no \
        --enable-ipv6=no \
        --enable-backends=yes \
        --enable-overlays=yes \
        --enable-static=yes \
        --with-systemd=no \
        --enable-wt=no \
        --enable-perl=no && \
    make depend build install && \
    apk del build-dependencies && \
    rm -rf /app && \
    rm -f /etc/openldap/*.conf /etc/openldap/*.default
COPY ./*.ldif /etc/openldap/
COPY ./run.sh /
STOPSIGNAL SIGTERM
CMD ["/run.sh"]