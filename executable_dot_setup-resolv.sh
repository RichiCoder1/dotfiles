if ! grep -q "Custom" /etc/resolv.conf ; then
    echo "# Custom Nameservers" > /tmp/resolv.conf
    cat ~/resolv.conf.add >> /tmp/resolv.conf
    echo "\n" >> /tmp/resolv.conf
    cat /etc/resolv.conf > /tmp/resolv.conf
    mv /tmp/resolv.conf /etc/resolv.conf
fi
