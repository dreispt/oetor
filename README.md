OpenERP-inator
==============

*Dominate the entire ERP tri-state area by easilly installing and creating an army of OpenERP server instances in your server. The self-destruct button is intended only for test databases.*

OpenERP-inator is an utility script to manage a server with multiple OpenERP server instances and variants.
The motivation behind `oetor` was to make it easy to branch, develop and test OpenERP branches, and avoid the chaos that quickly piles up when working on multiple projects.

Features:

 - One line OpenERP server full installation, through the 'quickstart' command.
 - Simple download of OpenERP sources, either from nightly builds or Launchpad (official and OCB branches).
 - Check source code versions and update to latest version.
 - Create and organize multiple server instances, running in isolated environments.
 - Addons path automatically generated: just add a new directory and it will be added on next start.
 - Create server instance "branches" - modified versions for development and tests.
 - Run automatic tests for all modules in a specific directory.
 - List running instances and know their listening port just by using the 'ps' command.
 - Support for multiple instance homes (default is /opt/openerp).



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

The `quickstart` command provides a one line full installation of the latest stable version of OpenERP:

```bash
    /opt/openerp/oetor quickstart  # OpenERP dependencies and server isntallation 
    /opt/openerp/v7/main/start     # Start the 'v7' server instance
```

All needed dependencies are installed, including the PostgreSQL server.
The installed instance, `v7`, is built using the latest nightly build. 


Usage
-----

A step-by-step guide on OpenERP-inator's main features.
These steps can be followed either you used the `quickstart` or not.


### Preparation
 
For convenience, let's position in the home directory and confirm that all system dependencies are installed.

```bash
    cd /opt/openerp           # position at oetor home
    ./oetor get-dependencies  # install missing system dependencies
```


### Create server instances

Create two server instances, one using nightly build and running on port 8070,
and another using Launchpad sources and listening on 8071:

```bash
    ./oetor get nightly-7.0                # download latest 7.0 nighlty build
    ./oetor create prod7 nightly-7.0 8070  # create prod7 instance on port 8070
    ./prod7/main/start &                   # start prod7 instance in the background
    
    ./oetor get openerp-7.0                # download Launchpad 7.0 source code
    ./oetor create test7 openerp-7.0 8071  # create test7 instance on port 8071
    ./test7/main/start &                   # start test7 instance in the background

    ps aux | grep openerp                  # list running instances and listening ports
```


### Chek versions and update sources

```bash
    ./oetor version ./src/nightly-7.0      # version of a shared source
    ./oetor version ./test7/main/server    # version of an instance source code

    ./oetor get openerp-7.0 --update       # update source code from Launchpad
    ./oetor get nightly-7.0 --update       # update source code from nightly builds
```


### Work on a project and test branches

Create an instance for the Department Management project, including it's modules in the addons path:

```bash
    ./oetor create dev7 nightly-7.0                                       # create "dev7" server instance 
    bzr branch lp:department-mgmt/7.0 ./dev7/main/deptm                   # add specific code
    ./dev7/main/start --stop-sfter-init                                   # new code branch automatically added to addons
    
    cp ./dev7/main ./dptm7/featX                                          # create "featX" work copy from branch "main"
    ./dev7/featX/start -i crm_department --test-enable --stop-after-init  # test one module
    ./dev7/featX/start -I dptm7 --test-enable --stop-after-init           # test all modules
    
    rm ./deptm7/featX -R && dropdb deptm7-featX                           # Remove an obsolete instance branch
```


What's in the box?
------------------

Here is how source code directories and server instances are organized:


        /opt/openerp               # HOME directory
          +- oetor                   # oetor script
          +- /env                    # shared virtualenv (optional)
          |
          +- /src                  # shared source repository
          |    |
          |    +- /nightly-7.0       # a nightly build source directory
          |    |    +- /server
          |    |
          |    +- /openerp-7.0       # a Launchpad official source directory
          |    |    +- /server
          |    |    +- /addons
          |    |    +- /web
          |    |
          |    +- /openerp-trunk     # a Launchpad trunk official source directory
          |    |    +- ...           # ... module directories
          |    ...                 # ... more shared sources
          |
          |
          +- /server1              # an OpenERP server instance
          |    |
          |    +- /main              # the main branch
          |    |    +- start.sh        # server start script
          |    |    +- /env            # python virtualenv to use (symlinked, optional)
          |    |    +- /server         # server source code (symlinked to dir in <home>/src)
          |    |    +- /addons         # other module directories ...
          |    |    +- /web
          |    |    +- /projx          # an additional modules directory
          |    |
          |    +- /branchA           # an instance server branch
          |    |    +- start.sh
          |    |    +- /env      
          |    |    +- /server       
          |    |    +- /addons 
          |    |    +- /web
          |    |    +- /projx-z        # working with version z of the projx modules
          |    |    ...                # ... more module directories
          |    ...                   # ... more server branches
          ...                      # ... more server instances


Development guidelines and roadmap
----------------------------------

Planned features:

* Producion environments support:
  - Register in init.d for autostart on boot
  - Database backup and restore
* Support for other VCS
  - git
  - hg


Other ideas that could go into the roadmap:

* Support for other Unix OS, such as CentOS


Project directives to keep in mind:

* Usable: the UI should be simple and intuitive. Write docs first, code later.
* Simple: commands should wrap annoying tasks, and no more than that.
* Safe: repeating or misusing commands must de safe - no data is destroyed.
* Readable: reding the script code should allow to quickly understand what a command will do.

