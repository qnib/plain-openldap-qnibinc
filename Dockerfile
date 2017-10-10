# inspired by https://github.com/larrycai/docker-openldap
# it is based on https://github.com/rackerlabs/dockerstack/blob/master/keystone/openldap/Dockerfile
# also the files/more.ldif from http://www.zytrax.com/books/ldap/ch14/#ldapsearch
ARG DOCKER_REGISTRY=docker.io
FROM ${DOCKER_REGISTRY}/qnib/plain-openldap@sha256:ed3bcf8045dbc22207d7b521b446cd2b5f035e39ee02bacedb0f75b90f967ec7

COPY files /ldap

RUN service slapd start \
 && cd /ldap \
 && ldapadd -Y EXTERNAL -H ldapi:/// -f back.ldif \
 && ldapadd -Y EXTERNAL -H ldapi:/// -f sssvlv_load.ldif \
 && ldapadd -Y EXTERNAL -H ldapi:/// -f sssvlv_config.ldif \
 && ldapadd -x -D cn=admin,dc=qnib,dc=inc -w password -c -f front.ldif \
 && ldapadd -x -D cn=admin,dc=qnib,dc=inc -w password -c -f users.ldif
