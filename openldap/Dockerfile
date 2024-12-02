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
        --prefix="" \
        --enable-debug \
        --enable-dynamic \
        --disable-syslog \
        --disable-ipv6 \
        --disable-local \
        --enable-slapd \
        --disable-dynacl \
        --disable-aci \
        --enable-cleartext \
        --disable-modules \
        --disable-rlookups \
        --disable-slapi \
        --disable-slp \
        --disable-wrappers \
        --disable-dnssrv \
        --enable-ldap \
        --enable-mdb \
        --enable-meta \
        --disable-asyncmeta \
        --disable-null \
        --disable-passwd \
        --disable-perl \
        --disable-relay \
        --disable-sock \
        --disable-sql \
        --disable-wt \
        --disable-accesslog \
        --disable-auditlog \
        --disable-autoca \
        --disable-collect \
        --disable-constraint \
        --disable-dds \
        --disable-deref \
        --disable-dyngroup \
        --disable-dynlist \
        --disable-homedir \
        --disable-memberof \
        --disable-nestgroup \
        --disable-ppolicy \
        --enable-proxycache \
        --disable-refint \
        --disable-remoteauth \
        --disable-retcode \
        --disable-rwm \
        --disable-seqmod \
        --disable-sssvlv \
        --disable-syncprov \
        --enable-translucent \
        --disable-unique \
        --disable-valsort \
        --disable-argon2 \
        --disable-balancer \
        --disable-harness \
        --disable-static \
        --enable-shared \
        --disable-versioning \
        --enable-fast-install \
        --with-cyrus-sasl=no \
        --with-odbc=unixodbc \
        --with-systemd=no \
        CFLAGS="-Os -ffunction-sections -fdata-sections" \
        LDFLAGS="-Wl,--gc-sections -s -static" && \
    make depend build install && \
    apk del build-dependencies && \
    rm -rf /app && \
    rm -f /etc/openldap/*.conf /etc/openldap/*.default
COPY ./*.ldif /etc/openldap/
COPY --chmod=07777 run.sh /
STOPSIGNAL SIGTERM
CMD ["/run.sh"]