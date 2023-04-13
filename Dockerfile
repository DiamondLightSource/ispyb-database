FROM docker.io/library/mariadb:10.10.3

WORKDIR /ispyb

COPY . /ispyb

RUN mv build.sh /docker-entrypoint-initdb.d/ \
    && mv .my.example.cnf .my.cnf \
    && sed -i "s/^host.*/host = localhost/g" .my.cnf
