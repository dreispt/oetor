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

If you just want to quickly install OpenERP in your system, use the quickinstall feature:

    /opt/openerp/oetor quickstart 

This will install the system dependencies needed, including PostgreSQL, download v7 latest nightly build and create an OpenERP instance named `server1`. 

To start the server type:

    /opt/openerp/server1/normbot start


Tutorial
--------

This will make you familiar with OpenERP-inator's operation. You can follow it either after or instead of the quickstart.

If OpenERP-inator is correctly installed, the following commands should execute without error:

   cd /opt/openerp
   ./oetor --help

First, let's make sure deprendencies are installed and download OpenERP sources:

   ./oetor get-dependencies
   ./oetor get nightly 7.0

Let's create and start our first server instance, running on port 8070:

   ./oetor create test1 nightly-7.0 8070
   ./test1/normbot start 

That covers the basics, and does the same as the quickstart command.
Stop the server with CTRL+C to return to the terminal prompt, and let's create another server instance using Launchpad sources instead, on port 8071:

   ./oetor get source 7.0
   ./oetor create test2 source-7.0 8070
   ./test2/normbot start 


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
