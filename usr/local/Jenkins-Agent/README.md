# `/usr/local/Jenkins-Agent`

Create this directory, which holds the Jenkins node related stuff.
```bash
mkdir -p /usr/local/Jenkins-Agent
```

Create a node on the Jenkins host with the launch method set as *Launch agent by connecting it to
the master*, configure it, and press *Save*. Go to the create node's status page by clicking on it,
and copy the *secret* shown to this directory.
```bash
echo <secret> > secret-file
```

Next, acquire the `agent.jar` from the Jenkins host, move it to here and rename it to
`Jenkins-Agent.jar`.
```bash
wget -O /usr/local/Jenkins-Agent/Jenking-Agent.jar https://<your Jenkins host>/jnlpJars/agent.jar
```

Finally, download the encrypted `slave-agent.jnlp` file from the host.
```bash
curl -o slave-agent.jnlp -X GET "https://<your Jenkins host>/computer/<name of the node>/slave-agent.jnlp?encrypted=true"
```

