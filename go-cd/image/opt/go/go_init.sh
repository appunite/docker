#!/bin/bash

set -x

if [ ! -e /var/go/docker_bootstrapped ]; then
  echo "configuring go"
  cp /opt/go/admins.properties /etc/go/admins.properties
  
  
  cat<<EOF > /etc/go/cruise-config.xml
<?xml version="1.0" encoding="utf-8"?>
<cruise xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="cruise-config.xsd" schemaVersion="74">
  <server artifactsdir="/data/artifacts" commandRepositoryLocation="default">
    <security>
      <ldap uri="ldap://127.0.0.1" managerDn="cn=admin,$LDAP_DC" encryptedManagerPassword="JEBZYqCBCz4EJba+D7IXOCAJBsnUp6VVjshzbe/4jcYBa0vneJXw1M2urkN4ek9l" searchFilter="(uid={0})">
        <bases>
          <base value="ou=People,$LDAP_DC" />
        </bases>
      </ldap>
      <passwordFile path="/etc/go/admins.properties" />
    </security>
  </server>
</cruise>
EOF
  chown go:go /etc/go/cruise-config.xml
  chown go:go /etc/go/admins.properties
  
  touch /var/go/docker_bootstrapped
else
  echo "found already-configured go"
fi
