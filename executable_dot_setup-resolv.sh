cat /etc/resolv.conf | head -n -1 > /tmp/resolv.conf
cat ~/resolv.conf.add >> /tmp/resolv.conf
mv /tmp/resolv.conf /etc/resolv.conf
