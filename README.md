# Dynamic Jenkins Node

Sometimes you have a node, a machine or a device that should be a node to Jenkins but its IP
address keeps changing or it can be behind a NAT gateway, meaning that you hardly have any
access to it from the outside network.

For these cases, this repository serves as an example of how to set up a *dynamic* Jenkins node.

## Node requirements

Now, the requirements for making all this work aren't very difficult. All your node needs to run
are:
  * Java 8 or higher (depending on current [Jenkins version recommendations][])
  * More than 512 Mb of RAM (depending of your usage of the node)
  * Some hard drive space (depending on your usage of course)
  * Latest version of *curl* and *wget*

## Jenkins configuration

For all of this to work, you need to have your Jenkins host confiured in such a way that it allows
machines on the internet/intranet to connect to the host using a specific port.
To accomplish that, go to *Manage Jenkins* -> *Confgiure Global Security* and in there, you should
find a section called *Agents*. Set the *TCP port for inbound agents* to *Fixed* and set the value to a port you have opened in your firewall settings for inbound traffic of nodes to the host.
For example, I am using the Amazon Web Services EC2-platform and in there, I have an inbound rule
for the host server to accept all traffic to port `2000`. And so, I set my fixed port to `2000`.

## Adding a dynamic node to the host's agent pool

Firstly, you need to create and new node on the host dashboard and proceed with the guidelines
spread out in the [Jenkins Agent settings][].

After you have installed the agent stuff, it's time to make a service to run the jar file.
To do that, we should start by creating a [Jenkins Agent service controller][].

When the controller is done, all we have to do is create a custom service with our own
[Jenkins Agent service settings][].

Now, we should reboot our device and see that it has indeed made a connection to the node we created
on the Jenkins host dashboard. If everything went like in the Strömsö, then the agent should be
shown as connected and ready to execute commands.

---

Saku Rautio, 2020

[Jenkins version recommendations]: https://jenkins.io/doc/pipeline/tour/getting-started/#prerequisites
[Jenkins Agent settings]: usr/local/Jenkins-Agent/README.md
[Jenkins Agent service controller]: usr/local/bin/README.md
[Jenkins Agent service settings]: etc/systemd/system/README.md
