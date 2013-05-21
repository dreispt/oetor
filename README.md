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


Installation
------------

To install in an Ubuntu system:

    wget https://raw.github.com/dreispt/master/oetor  # download oetor script
    sudo bash oetor install                           # run install command
    rm oetor                                          # cleanup


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

   ./oetor get nightly 7.0

   ./oetor create prod7 nightly-7.0 8070
   prod7/normbot start &

   ./oetor create dev7 nightly-7.0 8071
   dev7/normbot start &

This is very similar to what is done by the `quickstart` command.


##### Create a server using Launchpad sources

Let's create another server instance using Launchpad sources instead, using default port 8069:

   ./oetor get source trunk
   ./oetor create test-trunk source-trunk
   ./test-trunk/normbot start 

Oetor uses lighweight checkouts to get the sources from Launchpad, but even so this might take a while. If you wiah, you can continue with the tutorial without performing this step.
If you completed it, now press CTRL+C to stop the server and get back to the terminal prompt, so we can go on.


##### Create a custom server instance

    ./oetor create deptm7 nightly-7.0
    bzr branch lp:deptm-management 

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
