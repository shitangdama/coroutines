
/etc/docker/daemon.json

{
  "exec-opts": ["native.cgroupdriver=systemd"]
}

systemctl restart docker
systemctl status docker