echo -e "\n==== test install ===="
./oetor install /opt/oetest/

echo -e "\n==== test quickstart: get-deps, get-nig and create ===="
./oetor quickstart /opt/oetest/

echo -e "\n====  test get command ===="
rm -rf /opt/oetest/src/oetortest-dptm
/opt/oetest/oetor get oetortest-dptm https://launchpad.net/~department-core-editors/department-mgmt/7.0 department-mgmt

echo -e "\n====  test create, no addons case ===="
rm -rf /opt/oetest/oetortest
/opt/oetest/oetor create oetortest /opt/oetest/src/nightly-7.0/
/opt/oetest/oetortest/main/start --stop-after-init

echo -e "\n====  test create, has addons case ===="
/opt/oetest/oetor create oetortest /opt/oetest/src/oetortest-dptm/
/opt/oetest/oetortest/main/start --stop-after-init

echo -e "\n==== DONE ===="
echo "Source list:"
ls -l /opt/oetest/src/oetortest-dptm
echo "Instance main list:"
ls -l /opt/oetest/oetortest/main
