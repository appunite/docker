mkdir /usr/share/go-agent/config

eval `ssh-agent -s`

  cat<<EOF > /usr/share/go-agent/config/autoregister.properties
agent.auto.register.key=$AGENT_KEY
agent.auto.register.resources=$AGENT_RESOURCES
agent.auto.register.environments=$AGENT_ENV
EOF

chown go /usr/share/go-agent/config/autoregister.properties

/usr/share/go-agent/agent.sh