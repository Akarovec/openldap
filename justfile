set shell := ["bash", "-uc"]
minor  := shell('expr ' + `cat "version"` + ' + 1')

build:
    docker buildx build \
      --progress plain \
      --push \
      --tag arti.etl.emias.ru/mkomlev/openldap:2.6.9-0.0.{{minor}} \
      --tag maxname/openldap:2.6.9-0.0.{{minor}} \
      --build-arg ENABLE_MEMBEROF=no \
      --platform=linux/amd64 openldap
    docker buildx build \
      --progress plain \
      --push \
      --tag arti.etl.emias.ru/mkomlev/openldap:2.6.9-0.0.{{minor}}-overlay \
      --tag maxname/openldap:2.6.9-0.0.{{minor}} \
      --build-arg ENABLE_MEMBEROF=yes \
      --platform=linux/amd64 openldap
    echo {{minor}} > version