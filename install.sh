# Home directory can be changed by passing it as an argument
OEUSER="`who am i|awk '{print $1}'`"
OEHOME="/opt/openerp"
if [ "$1" ] ; then OEHOME="$1" ; fi

echo "* Setting up $OEHOME for user $OEUSER..."
mkdir -p $OEHOME/src
chown -R "$OEUSER" $OEHOME

if [ ! `command -v git` ] ; then
    echo "* Installing git"
    apt-get install git
fi

echo "* Cloning oetor from Github..."
git clone https://github.com/dreispt/oetor $OEHOME/src/oetor
ln -s $OEHOME/src/oetor/oetor $OEHOME/oetor

echo "* Done.
For more help type: $OEHOME/oetor --help"
