OpenERP-inator
==============

Dominate the entire ERP tri-state area by easilly installing and creating an army of OpenERP server instances in your server. The self-destruct button is intended only for test databases. And beware of failed tests and Agent P!

Main features:
* One-line no-brains full installation command, to get you an up an running instance in a blink.
* One-line Launchpad sources download, update and version revision numbers check.
* One-line creation of new server instances.
* One-line to run tests for a server instance.
* Easily add addons projects - just add the directory with it's sources inside the instance's `addons-repo` directory and restart the server.
* Easily list running instances and respective listening ports.


Installing oetor
----------------

To install `oetor` in your Ubuntu system:

    wget https://raw.github.com/dreispt/master/install.sh
    sudo bash install.sh


Quickstart full installation
---------------------------

For an easy and quick start run:

    /opt/openerp/oetor quickstart 

This will install all system dependencies needed, including a PostgreSQL server, download v7 latest nightly build and create a `server1` OpenERP instance. It can be started with:

    /opt/openerp/server1/normbot start


Tutorial
--------

Before we can start, make sure OpenERP-inator is installed. You don't need to run the quickstart, but there's no problem if you did.
Verify that it's installed typing:

   cd /opt/openerp
   ./oetor --help
   ./oetor get-dependencies
   ./oetor addsrc sources 7.0
   ./oetor addsrc sources trunk

   ./oetor create test-trunk sources-trunk 8070
   ./test-trunk/normbot start &

   ./oetor create test-v7 sources-7.0 8071
   ./oetor addcommon 


What's in the box?
------------------

Here is how source code directories and server instances are organized:

                                   ###$ ./install.sh
        /opt/openerp               # HOME directory
          |- oetor                 # oetor script (symlinked to ./src/oetor/oetor)
          |- /src                  # shared SOURCE REPOSITORY
          |    |- /oetor             # oetor script source (cloned form GitHub)
          |    |                     ###$ `oetor setup nightly 7.0`
          |    |- /nightly-7.0       # a SOURCE DIR, from nightly builds
          |    |    |- /server
          |    |                     ###$ `oetor setup sources 7.0`
          |    |- /sources-7.0       # a source dir (Launchpad checkout)
          |    |    |- /server       #    (/repos contains addons and web)
          |    |    |- /repos
          |    |                     ###$ `oetor setup sources trunk`
          |    |- /sources-trunk     # ...another version source dir
          |    |    |- ...
          |    ...                   # ...add other shared sources as needed
          |
          |                          ###$ ./oetor create server1 sources-7.0 
          |- /server1                # an OpenERP server instance
          |    |- openerp-server.conf 
          |    |- normbot-main       # script to help operate the vanilla server 
          |    |                     # (addons_path=./src/repos/*,./common/*)
          |    |- /main
          |    |    |- /server       # server sources: symlinked to dir in /opt/openerp/src
          |    |    |- /addons 
          |    |    |- /web
          |    |    |- /projx
          |    |    ... 
          |    |
          |    |                     ###$ ./oetor branch server -projx +projxz lp:branchxz
          |    |- normbot-branchz    # server to work on a specific branch/version
          |    |- /branchz           # instance source code (version z)
          |    |    |- /server       # server sources: symlinked to dir in /opt/openerp/src
          |    |    |- /addons 
          |    |    |- /web
          |    |    |- /projxz
          |    |    ... 
          |    |
          |    ...                 # ...add as many branches as needed
          |                        # for help run:  `oetor addto --help`
          |
          ...                      # ...create as many instances as you need
                                   # for help run:  `oetor create --help`


Step-by-step installation
-------------------------

Instead of using the auto-install, the same result can be achieved using the following commands:
  
    ./oetor setup dependencies         # Install system dependencies
    ./oetor setup sources 7.0          # Download (v7) sources from Launchpad
    ./oetor create erver1 sources-7.0  # Create demo instance (on port 8069)
    ./oetor start demo                 # Start a demo instance server


More commands
-------------

By default, `oetor` will install itself in `/opt/openerp`. Try:

    cd /opt/openerp                 # Go to home directory
    ./oetor --help                  # Display usage help
    ./oetor update sources-7.0      # Update sources to latest Launchpad versions
    ./oetor version sources-7.0     # Display source revision numbers
    ./oetor create test 8070        # Create test instance on port 8070
    test/normbot -i crm --debug     # Start test in debug mode and install crm module
    

Anatomy of a server instance
----------------------------

OpenERP instances are hosted under `/opt/openerp`.
An OpenERP instance is a directory inside `oetor`'s home directory, and can be started using the included `start` script. Example:

    ls /opt/Launchpad/7.0/demo

The directory contains:

* `start`: Script to start the instance. If called with additional parameters, these will be passed to the openerp-server.
* `openerp-server.conf`: Configuration file used by the instance.
* The contained directories are automatically added to the `addons_path` upon server start. By default these are symlinked to the official addons sources in the `shared` directory. 


Features
----------

* command to run tests on throw-away databases


To-do list
----------

* command to list running instances (`start`already does a good job with: ps aux|grep openerp`)
* command to list databases
* commands to start in background, see instances running, and stop instances
* command to set instance to autostart on boot
* provide better configuration file template (?)
* command to remove an instance (?)
