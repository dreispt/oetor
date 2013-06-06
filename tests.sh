echo -e "\n==== CLEANUP ====\n"
sudo userdel oetortest
sudo -u postgres dropdb main-oetortest
sudo -u postgres dropdb oetortest-main
sudo -u postgres dropdb v7-oetortest
sudo -u postgres dropuser oetortest

echo -e "\n==== install command ====\n"
./oetor install /opt/oetest/

echo -e "\n==== quickstart command (get-deps, get-nig and create) ====\n"
sudo rm -rf /opt/oetest/v7
./oetor quickstart /opt/oetest/

echo -e "\n==== start default instance (v7) ====\n"
/opt/oetest/v7/main/start --stop-after-init

echo -e "\n==== get command (using lp:department-mgmt) ====\n"
rm -rf /opt/oetest/src/oetortest-dptm
/opt/oetest/oetor get-src bzr oetortest-dptm https://launchpad.net/~department-core-editors/department-mgmt/7.0 department-mgmt

echo -e "\n==== create command, with no extra addons ====\n"
sudo rm -rf /opt/oetest/oetortest
/opt/oetest/oetor create oetortest /opt/oetest/src/nightly-7.0/

echo -e "\n==== start oetortest (with no extra addons) ====\n"
/opt/oetest/oetortest/main/start --stop-after-init

echo -e "\n==== create command, with extra addons ====\n"
/opt/oetest/oetor create oetortest /opt/oetest/src/oetortest-dptm/

echo -e "\n==== start oetortest (with extra addons) ====\n"
/opt/oetest/oetortest/main/start 8080 --stop-after-init

echo -e "\n==== DONE ====\n"
echo -e "\nSource list:\n"
ls -l /opt/oetest/src/oetortest-dptm
echo -e "\nInstance main list:\n"
ls -l /opt/oetest/oetortest/main
