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
/opt/oetest/oetor get-src bzr oetortest-dptm https://launchpad.net/~department-core-editors/department-mgmt/7.0 dptm-mgmt

echo -e "\n==== create command, with no extra addons ====\n"
sudo rm -rf /opt/oetest/oetortest
/opt/oetest/oetor create oetortest /opt/oetest/src/nightly-7.0/
/opt/oetest/oetor create oetortest /opt/oetest/src/oetortest-dptm/

echo -e "\n==== start oetortest (with extra addons) ====\n"
/opt/oetest/oetortest/main/start 8080 --stop-after-init

echo -e "\n==== start oetortest and test all ====\n"
/opt/oetest/oetor fake-smtp & P=$! > /opt/oetest/oetortest/main/smtp-output.log
/opt/oetest/oetortest/main/start 8080 -I dptm-mgmt --test-enable --stop-after-init

echo -e "\n==== start oetortest and test one ====\n"
/opt/oetest/oetortest/main/start -i crm --test-enable --stop-after-init --log-level=warn
echo "Kill smtp process $P"
sudo kill -9 $P

echo -e "\n==== check versions ====\n"
/opt/oetest/oetor version /opt/oetest/src/nightly-7.0
echo
/opt/oetest/oetor version /opt/oetest/oetortest/main/

echo -e "\n==== update versions ====\n"
/opt/oetest/oetor update /opt/oetest/src/nightly-7.0/
echo
/opt/oetest/oetor update /opt/oetest/src/oetortest-deptm/

echo -e "\n==== DONE ====\n"
echo -e "\nSource list at /opt/oetest/src/oetortest-dptm:\n"
ls -l /opt/oetest/src/oetortest-dptm
echo -e "Instance main list:\n"
ls -l /opt/oetest/oetortest/main
