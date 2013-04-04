OpenERP-inator
==============

Dominate the entire ERP tri-state area by easilly installing and creating an 
army of OpenERP server instances in your server. The self-descruct button is 
intended only for test databases. Beware of Agent P.

For an easy and  quick start run: `./oetor auto-install`
This will make an automatic full installation, including the creation of an
initial `demov7` OpenERP instance. It's equivalent to running the sequence of
commands: `get-dependencies`; `init`; `get-source`; `create demov7`.

Commands Available:

    version           Display script's version info.
    get-dependencies  Install system dependencies and also tries to install the 
                      PostgreSQL database. Requires sudoer privilege.
    init              Creates db role for current user and the directory 
                      structure. Requires sudoer privilege.
    get-latest        Retrieves source code from nightly builds repository, into
                      the 'shared' directory.
    get-source        Retrieves source code from Lanchpad repositories, into 
                      the 'shared' directory.
    update-source     Updates the sources with later commits.
    version-source    Displays the sources revision numbers.
    create NAME [PORT] [FIXED_OPTIONS]
                      Create an OpenERP 7 database and instance named "NAME" and 
                      listening at port "PORT". If additional "FIXED_OPTIONS" are 
                      provided, they will be included in the generated 'start.sh' 
                      script.
                   
An OpenERP instance is a directory inside `oetor`'s home directory, and can be 
started using the included `start` script. 

The directory contains:

    server/           The server source code. By default it's a symlink to the 
                      sources in the 'shared' directory.
    addons-repo/      Contains the addons directories to use. These directories are
                      automatically added to the addons_path upon server start.
                      By default includes symlinks to the official addons sources 
                      in the 'shared' directory.
    start             Script to start the instance. If called with additional 
                      parameters, these will be passed to the openerp-server.
                      For example: ./start.sh -u all --stop-after-init    
    openerp-server.conf
                      Configuration file used by the instance.
