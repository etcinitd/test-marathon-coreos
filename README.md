Project Layout
--------------

    .
    +-- coreos-box/                        CoreOS box defintion (master and worker are the same box)
    |   +-- files/                         Files to copy or run on the CoreOS box
    |   +-- scripts/                       Scripts to run to provision the coreos box
    |   +-- build_box.sh                   Builds the box and registers it with vagrant
    |   +-- coreos.json                    Defines how to build the box
    |
    +-- Vagrantfile                        Defines how to start the cluster locally
    +-- user-data                          Cloud-init configuration - tells CoreOS how to load our services

Required Software
-----------------
0. Packer - https://www.packer.io/
1. Virtual Box - https://www.virtualbox.org/
2. Vagrant - https://vagrantup.com - **Make sure to install to a path without spaces!**
3. A UNIX capable shell.

Getting Started (Local Edition)
-------------------------------
**IMPORTANT**: Unless otherwise specified all commands must be run from the root directory.

Build the coreos image (will take 10-15 minutes):

    cd coreos-box
    ./build_box.sh

Install:

* MacOSX: `install_on_mac.sh`
* Manual: Create the `NCP_INFRASTRUCTURE_HOME` environment variable and set it to the absolute path of the root folder.

Install required vagrant plugins:

    vagrant plugin install vagrant-reload

Spin up the cluster:

    vagrant up

You're good to go!

CoreOS Box Environment Variables
--------------------------------
The CoreOS host image expects the following environment variables to be written to /etc/ncp_environment on each host

* NCP_UNIQUE_CLOUD_ID (master only): A unique integer between 1-255. Should correspond to the order the machines are listed in NCP_MASTERS.
* NCP_IP: The IP to use for communication between services. Typically this is the internal private-network IP (example: 172.17.8.100).
* NCP_MASTERS: A space-seperated list of IPs containing all master IPs.
* NCP_NUM_MASTERS: The number of masters that are being provisioned. Should correspond to the number of IPs in NCP_MASTERS

Useful URLs
-----------
Mesos UI: http://172.17.8.100:5050/
Marathon UI: http://172.17.8.100:8080/
Consul UI: http://172.17.8.100:8500/ui/

Troubleshooting
---------------
If 'could not open a connection to your authentication agent':

    eval $(ssh-agent)

If 'Authentication failure. Retrying...':

    ssh-add ~/.vagrant.d/insecure_private_key

If 'An error occured while installing json-1.8.2 and bundler cannot continue...':

    Uninstall and Reinstall vagrant to a path without spaces and try again.
