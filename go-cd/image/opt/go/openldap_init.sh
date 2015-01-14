#!/bin/bash

set -x

if [ ! -e /var/lib/ldap/docker_bootstrapped ]; then
  echo "configuring slapd for first run"
  
  LDAP_ROOTPASS=$(openssl rand -base64 32)
  echo $LDAP_ROOTPASS >> /etc/go/ldap_pass
  
  cat <<EOF | debconf-set-selections
slapd slapd/internal/generated_adminpw password ${LDAP_ROOTPASS}
slapd slapd/internal/adminpw password ${LDAP_ROOTPASS}
slapd slapd/password2 password ${LDAP_ROOTPASS}
slapd slapd/password1 password ${LDAP_ROOTPASS}
slapd slapd/dump_database_destdir string /var/backups/slapd-VERSION
slapd slapd/domain string ${LDAP_DOMAIN}
slapd shared/organization string ${LDAP_ORGANISATION}
slapd slapd/backend string HDB
slapd slapd/purge_database boolean true
slapd slapd/move_old_database boolean true
slapd slapd/allow_ldap_v2 boolean false
slapd slapd/no_configuration boolean false
slapd slapd/dump_database select when needed
EOF
   
  dpkg-reconfigure -f noninteractive slapd
  
  service slapd restart
  
  cat <<EOF | ldapadd -x -w "$LDAP_ROOTPASS" -D cn=admin,$LDAP_DC
dn: ou=People,$LDAP_DC
objectClass: organizationalUnit
ou: People

dn: ou=Groups,$LDAP_DC
objectClass: organizationalUnit
ou: Groups

dn: uid=john,ou=People,$LDAP_DC
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: john
sn: Doe
givenName: John
cn: John Doe
displayName: John Doe
uidNumber: 10000
gidNumber: 5000
userPassword: johnldap
gecos: John Doe
loginShell: /bin/bash
homeDirectory: /home/john
EOF
  

  touch /var/lib/ldap/docker_bootstrapped
else
  echo "found already-configured slapd"
  service slapd start 
fi

