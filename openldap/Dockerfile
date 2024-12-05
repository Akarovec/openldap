FROM alpine:3.20.3
ARG VERSION=openldap-2.6.9
ARG SASL=cyrus-sasl-2.1.28
ARG ENABLE_MEMBEROF=no
RUN mkdir -p /app /var/openldap-data /etc/slapd.d && \
    apk --update-cache update && \
    apk --update-cache add ca-certificates unixodbc esh openssl-libs-static libsasl && \
    apk --update-cache add --virtual build-dependencies wget build-base openssl-dev cyrus-sasl-dev unixodbc-dev groff upx && \
    wget -O /app/${VERSION}.tgz https://mirror.eu.oneandone.net/software/openldap/openldap-release/${VERSION}.tgz && \
    wget -O /app/${SASL}.tar.gz https://github.com/cyrusimap/cyrus-sasl/releases/download/${SASL}/${SASL}.tar.gz && \
    tar -xvf /app/${SASL}.tar.gz -C /app && \
    tar -xvf /app/${VERSION}.tgz -C /app && \
    rm -f /app/${VERSION}.tgz && \
    cd /app/${VERSION} && \
    ln -s /usr/lib/sasl2 /usr/local/lib/sasl2 && \
    env ./configure \
        --prefix="" \
        --enable-debug \
        --disable-ipv6 \
        --enable-ldap \
        --enable-meta \
        --enable-memberof=${ENABLE_MEMBEROF} \
        --enable-proxycache \
        --enable-translucent \
        --disable-static \
        --enable-shared \
        --disable-versioning \
        --with-cyrus-sasl \
        --with-odbc=unixodbc \
        --with-systemd=no \
        --with-tls=openssl \
        CFLAGS="-Os -ffunction-sections -fdata-sections" \
        CPPFLAGS="-I/include -I/usr/include/openssl -I/app/${SASL}/include" \
        LDFLAGS="-L/usr/lib -L/usr/lib/sasl2" && \
    make depend build install && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /bin/busybox && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /bin/ldapcompare && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /bin/ldapmodrdn && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /bin/ldapwhoami && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /bin/ldapvc && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /bin/ldappasswd && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /bin/ldapurl && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /bin/ldapexop && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /bin/ldapsearch && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /bin/ldapdelete && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /bin/ldapmodify && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /usr/bin/scanelf && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /usr/bin/getconf && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /usr/bin/iconv && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /usr/bin/ssl_client && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /usr/bin/getent && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /usr/bin/dltest && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /usr/bin/slencheck && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /usr/bin/odbcinst && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /usr/bin/c_rehash && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /usr/bin/iusql && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /usr/bin/odbc_config && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /usr/bin/isql && \
    upx --best --overlay=strip --all-methods --no-lzma --ultra-brute /libexec/slapd && \
    apk del build-dependencies && \
    rm -rf /app /var/cache /share/man /include /etc/openldap/schema && \
    rm -f /etc/openldap/*.conf /etc/openldap/*.default
COPY slapd.ldif.esh /etc/openldap/
COPY schema /etc/openldap/schema
COPY ssl /ssl
COPY --chmod=07777 run.sh /
STOPSIGNAL SIGTERM
CMD ["/run.sh"]