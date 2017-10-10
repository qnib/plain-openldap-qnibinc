# plain-openldap-qnibinc
OpenLDAP server holding examplary QNIB Inc organization (do not use in PROD!)

## Fire up

```bash
$ docker stack deploy -c docker-compose.yml openldap
Creating network openldap_default
Creating service openldap_slapd
```

### Query User/Admins

```bash
$ docker exec -ti $(docker ps -qf label=com.docker.swarm.service.name=openldap_slapd) ldapsearch -H ldap://localhost -LL -b ou=Users,dc=qnib,dc=inc -x
version: 1

dn: ou=Users,dc=qnib,dc=inc
objectClass: organizationalUnit
ou: Users

dn: cn=Bob Developer,ou=Users,dc=qnib,dc=inc
objectClass: inetOrgPerson
cn: Bob Developer
sn: Bob
uid: bdev
mail: bob.developer@qnib.inc
description: frontend developer
ou: Dev
$ docker exec -ti $(docker ps -qf label=com.docker.swarm.service.name=openldap_slapd) ldapsearch -H ldap://localhost -LL -b ou=Admins,dc=qnib,dc=inc -x
version: 1

dn: ou=Admins,dc=qnib,dc=inc
objectClass: organizationalUnit
ou: Admins

dn: cn=Alice Operation,ou=Admins,dc=qnib,dc=inc
objectClass: inetOrgPerson
cn: Alice Operation
sn: Alice
uid: aops
mail: alice.ops@qnib.inc
description: Administrator
ou: Ops
```
