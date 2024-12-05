#!/bin/sh

set -e
trap 'kill -INT $(cat /run/slapd.pid)' TERM
/usr/bin/esh -o /etc/openldap/slapd.ldif /etc/openldap/slapd.ldif.esh
/sbin/slapadd -n 0 -F /etc/slapd.d -l /etc/openldap/slapd.ldif
/libexec/slapd -F /etc/slapd.d -d -1 -h "ldaps:/// ldap:/// ldapi:///" &
wait