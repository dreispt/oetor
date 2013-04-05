OpenERP-inator
==============

Dominate the entire ERP tri-state area by easilly installing and creating an army of OpenERP server instances in your server. The self-destruct button is intended only for test databases. And beware of failed tests and Agent P!

Main features:
* One-line no-brains full installation command, to get you an up an running instance in a blink.
* One-line Launchpad sources download, update and version revision numbers check.
* One-line creation of new server instances.
* One-line testing of a server instance. [TODO] 
* Easily add addons projects - just add the directory with it's sources inside the instance's `addons-repo` directory and restart the server.
* Easily list running instances and respective listening ports. [IN PROGRESS]


Getting the code
----------------

Install git and get the code:

    sudo apt-get install git                        # install git in a Debian/Ubuntu OS
    git clone https://github.com/dreispt/oetor.git  # get the code
    oetor/oetor init                                # install code in /opt/openerp


Quickstart full installation
---------------------------

For an easy and quick start in run:

    /opt/openerp/oetor auto-install 

The `auto-install` command will install PostgreSQL and other system dependencies, setup the `/opt/openerp/` home, download v7 sources and configure an initial `demov7` instance. It can be started with:

    /opt/openerp/demov7/start


Step-by-step installation
-------------------------

Instead of using the auto-install, the same result can be achieved using the following commands:
  
    cd /opt/openerp                 # Go to home directory
    ./oetor get-dependencies        # Install system dependencies
    ./oetor get-source              # Download (v7) sources from Launchpad
    ./oetor create demov7           # Create instance demov7 (on port 8069)


More commands
-------------

By default, `oetor` will install itself in `/opt/openerp`. Try:

    cd /opt/openerp                 # Go to home directory
    ./oetor                         # Display included documentation
    ./oetor update-source           # Update sources from Launchpad
    ./oetor version-source          # Display source version revision numbers
    ./oetor create testv7 8070      # Create testv7 instance on port 8070
    testv7/start -i crm --debug     # Start testv7 in debug mode and install crm module
    

Anatomy of a server instance
----------------------------
                   
An OpenERP instance is a directory inside `oetor`'s home directory, and can be started using the included `start` script. Example:

    ls /opt/openerp/demov7

The directory contains:

* `server/`: The server source code. By default it's a symlink to the sources in the 'shared' directory.
* `addons-repo/`: Contains the addons directories to use. These directories are automatically added to the `addons_path` upon server start. By default includes symlinks to the official addons sources in the `shared` directory.
* `start`: Script to start the instance. If called with additional parameters, these will be passed to the openerp-server.
* `openerp-server.conf`: Configuration file used by the instance.


To-do list
----------

* command to run tests on throw-away databases
* command to list running instances (`start`already does a gob job when you `ps aux|grep openerp`)
* command to list databases
* commands to start in background, see instances running, and stop instances
* command to set instance to autostart on boot
* provide better configuration file template (?)
* command to remove an instance (?)
