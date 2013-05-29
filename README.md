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


Release notes:

* Installation, including mutiple homes, source code download and instance creation are properly handled.
* Passing a `--xmprpc-port` option to the `start` script works as expected, but reading this option from the `ps ax|grep openerp` outpout will be misleading, so this need to be fixed.
* The branch/copy feature (to create severall versions inside an instance) is yet to be finalized and documented.
* The `test` feature is yet to be finalized and may change in how the `start`script works.


Installation
------------

To install in an Ubuntu system:

```bash
wget https://raw.github.com/dreispt/master/oetor  # download oetor script
bash oetor install                                # run install command
rm oetor                                          # cleanup
```


Quickstart full installation
---------------------------

For a simple and quick installation of an OpenERP server, use the `quickstart`:

    /opt/openerp/oetor quickstart 

This will install the system dependencies needed, including PostgreSQL, download v7 latest nightly build and create an OpenERP instance named `v7`. 
To start the server type:

    /opt/openerp/v7/main/start


Tutorial
--------

This will make you familiar with OpenERP-inator's operation. You can follow it either after or instead of the quickstart.


### Preparation
 
For convenience, let's position in the home directory and confirm that all system dependecies are installed:

    cd /opt/openerp           # position at oetor home
    ./oetor get-dependencies  # install missing system dependencies


### Create servers using nightly builds

To create two server instances, running on ports 8070 and 8071, using the latest nightly build:

    ./oetor get-nightly 7.0                # download latest nighlty build
    ./oetor create prod7 nightly-7.0 8070  # create prod7 instance on port 8070
    prod7/main/start &                     # start prod7 instance in the background
    ./oetor create dev7 nightly-7.0 8071   # create dev7 instance on port 8071
    dev7/main/start &                      # start dev7 instance in the  background

The `quickstart` command performs a similar task on a single `v7` instance.


### Create a server using Launchpad sources

Let's create another server instance using Launchpad sources instead, using default port 8069:

    ./oetor get-sources trunk                # download trunk sources from Launchpad
    ./oetor create test-trunk sources-trunk  # create test-trunk instance (on port 8069)
    ./test-trunk/main/start                  # start the server instance

Oetor uses lighweight checkouts to get the sources from Launchpad, but even so this might take a while.
If you wish, you may continue the tutorial without performing this step.
If you completed it, now press `<CTRL+C>` to stop the server to get back to the terminal prompt.


### Create a custom server instance

Create an instance for the Department Management project, including it's modules in the addons path:

     ./oetor create deptm7 nightly-7.0     # create instance
     bzr branch lp:department-mgmt/7.0 \ 
           deptm7/main/department-mgmt     # download project source code into instance
     dptm7/main/start                      # start the instance

Notice that the `department-mgmt` is automatically added to the server's addons path.


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


