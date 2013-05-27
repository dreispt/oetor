OpenERP-inator
==============

Dominate the entire ERP tri-state area by easilly installing and creating an army of OpenERP server instances in your server. The self-destruct button is intended only for test databases.

Main features:

* Easy full installation command, to get you an up an running instance in a blink.
* Download sources from Launchpad or nightly builds.
* Verify Source code version/revision numbers and retrieve updates.
* Create new server instances.
* Run tests for a server instance or modified version of it.
* Add a modules directory to an intance by simply copying it into a directory.
* List running instances with info on the xmlrpc ports used.


Installation
------------

To install in an Ubuntu system:

```bash
wget https://raw.github.com/dreispt/master/oetor  # download oetor script
sudo bash oetor install                           # run install command
rm oetor                                          # cleanup
```


Quickstart full installation
---------------------------

For a simple and quick installation of an OpenERP server, use the `quickstart`:

    /opt/openerp/oetor quickstart 

This will install the system dependencies needed, including PostgreSQL, download v7 latest nightly build and create an OpenERP instance named `server1`. 
To start the server type:

    /opt/openerp/server1/normbot start


Tutorial
--------

This will make you familiar with OpenERP-inator's operation. You can follow it either after or instead of the quickstart.


##### Prepararation
 
For convenience, let's position in the home directory and confirm that all system dependecies are installed:

    cd /opt/openerp
    ./oetor get-dependencies

##### Create servers using nightly builds

Download latest nightly build and create two server instances, running on ports 8070 and 8071:

    ./oetor get-nightly 7.0

    ./oetor create prod7 nightly-7.0 8070
    prod7/main/start &

    ./oetor create dev7 nightly-7.0 8071
    dev7/main/start &

This is very similar to what is done by the `quickstart` command.


##### Create a server using Launchpad sources

Let's create another server instance using Launchpad sources instead, using default port 8069:

    ./oetor get-sources trunk
    ./oetor create test-trunk sources-trunk
    ./test-trunk/main/start 

Oetor uses lighweight checkouts to get the sources from Launchpad, but even so this might take a while. If you wiah, you can continue with the tutorial without performing this step.
If you completed this, now press CTRL+C to stop the server and get back to the terminal prompt, so we can go on.


##### Create a custom server instance

     ./oetor create deptm7 nightly-7.0
     bzr branch lp:deptm-management 


What's in the box?
------------------

Here is how source code directories and server instances are organized:

                                   ###$ ./install.sh
        /opt/openerp               # HOME directory
          |- oetor                 # oetor script
          |- /src                  # shared SOURCE REPOSITORY
          |    |- /nightly-7.0       # a SOURCE DIR, from nightly builds
          |    |    |- /server
          |    |                     ###$ `oetor setup sources 7.0`
          |    |- /sources-7.0       # a source dir (Launchpad checkout)
          |    |    |- /server       #    (/repos contains addons and web)
          |    |    |- /addons
          |    |    |- /web
          |    |                     ###$ `oetor setup sources trunk`
          |    |- /sources-trunk     # ...another version source dir
          |    |    |- ...
          |    ...                   # ...add other shared sources as needed
          |
          |                          ###$ ./oetor create server1 sources-7.0 
          |- /server1                # an OpenERP server instance
          |    |- openerp-server.conf 
          |    |- /main
          |    |    |- start         # script to start this server
          |    |    |- /server       # server sources: symlinked to dir in /opt/openerp/src
          |    |    |- /addons 
          |    |    |- /web
          |    |    |- /projx
          |    |    ... 
          |    |
          |    |- /branchz           # instance source code (version z)
          |    |    |- start         # script to start this server
          |    |    |- /server       # server sources: symlinked to dir in /opt/openerp/src
          |    |    |- /addons 
          |    |    |- /web
          |    |    |- /projxz
          |    |    ... 
          |    |
          |    ...                 # ...add as many branches as needed
          |
          ...                      # ...create as many instances as you need
                                   # for help run:  `oetor create --help`


