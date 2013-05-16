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


Getting the code
----------------

Install git and get the code:

    sudo apt-get install git                        # install git in a Debian/Ubuntu OS
    git clone https://github.com/dreispt/oetor.git  # get the code


Quickstart full installation
---------------------------

For an easy and quick start run:

    ./oetor auto-install

The `auto-install` command will install PostgreSQL and other system dependencies, setup the `/opt/oerp/7.0` home, download v7 sources and configure an initial `demo` instance. It can be started with:

    /opt/openerp/demo/norm-bot start


Step-by-step installation
-------------------------

Instead of using the auto-install, the same result can be achieved using the following commands:
  
    ./oetor setup dependencies        # Install system dependencies
    ./oetor setup sources 7.0         # Download (v7) sources from Launchpad
    ./oetor create demo sources-7.0   # Create demo instance (on port 8069)
    ./oetor start demo                # Start a demo instance server


More commands
-------------

By default, `oetor` will install itself in `/opt/openerp`. Try:

    cd /opt/openerp                 # Go to home directory
    ./oetor                         # Display basic usage help
    ./oetor setup update sources    # Update sources to latest Launchpad versions
    ./oetor version sources         # Display source revision numbers
    ./oetor create test 8070        # Create test instance on port 8070
    test/start -i crm --debug       # Start test in debug mode and install crm module
    

Anatomy of a server instance
----------------------------

OpenERP instances are hosted under `/opt/openerp`.
An OpenERP instance is a directory inside `oetor`'s home directory, and can be started using the included `start` script. Example:

    ls /opt/Launchpad/7.0/demo

The directory contains:

* `start`: Script to start the instance. If called with additional parameters, these will be passed to the openerp-server.
* `openerp-server.conf`: Configuration file used by the instance.
* The contained directories are automatically added to the `addons_path` upon server start. By default these are symlinked to the official addons sources in the `shared` directory. 


To-do list
----------

* command to run tests on throw-away databases [DONE]
* command to list running instances (`start`already does a gob job when you `ps aux|grep openerp`)
* command to list databases
* commands to start in background, see instances running, and stop instances
* command to set instance to autostart on boot
* provide better configuration file template (?)
* command to remove an instance (?)
