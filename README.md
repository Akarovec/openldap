# OpenLDAP

## Docker Compose Example

```yaml
name: openldap

services:
  openldap:
    image: arti.etl.emias.ru/mkomlev/openldap:2.6.9-0.0.1
    container_name: openldap
    ports:
      - "389:389"
    volumes:
      - ./data:/var/openldap-data
    environment:
      - "see below"
```

## Environment Variables

| Env Variable Name | Description                                      | Default Value                  | Example                                                                                                               |
|-------------------|--------------------------------------------------|--------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| `LDAP_SUFFIX`     | Default LDAP Suffix for current LDAP Catalog     | `dc=example,dc=com`            | `LDAP_SUFFIX="dc=google,dc=com"`                                                                                      |
| `LDAP_ROOT_DN`    | Default admin DN                                 | `cn=Manager,dc=example,dc=com` | `LDAP_ROOT_DN="cn=admin,dc=google,dc=com"`                                                                            |
| `LDAP_ROOT_PW`    | Default admin password                           | `secret`                       | `LDAP_ROOT_PW=«Z3xz2hNQjkgMmzPrUaVn"`                                                                                 |
| `LDAP_INCLUDE`    | Names of files of schemas to include to settings | _Not Set_                      | `LDAP_INCLUDE="core msuser"`                                                                                          |
| `LDAP_ACCESS_<N>` | Rules of Access to LDAP Catalogs                 | _Not Set_                      | `LDAP_ACCESS_1="to attrs=userPassword by self write by anonymous auth by * none"`<br>`LDAP_ACCESS_2="to * by * read"` |