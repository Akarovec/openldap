set shell := ["bash", "-uc"]
minor  := shell('expr ' + `cat "version"` + ' + 1')

build:
    docker buildx build \
      --progress plain \
      --push \
      --tag arti.etl.emias.ru/mkomlev/openldap:2.6.9-0.0.{{minor}} \
      --platform=linux/amd64,linux/arm64 openldap
    echo {{minor}} > version