echo "Open Firewalld ports for rancher script"
for i in 80 443 6443 2376 2379 2380 10250
do
  firewall-cmd --permanent --add-port=${i}/tcp
done
