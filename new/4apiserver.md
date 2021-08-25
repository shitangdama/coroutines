sudo vi /usr/lib/systemd/system/kube-apiserver.service

sudo systemctl daemon-reload
sudo systemctl start --now kube-apiserver
sudo systemctl enable kube-apiserver
sudo systemctl status kube-apiserver

curl --insecure https://localhost:6443/