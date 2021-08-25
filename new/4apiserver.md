sudo vi /usr/lib/systemd/system/kube-apiserver.service

sudo systemctl daemon-reload
sudo systemctl start --now kube-apiserver
sudo systemctl enable kube-apiserver
sudo systemctl status kube-apiserver
sudo systemctl restart kube-apiserver

curl --insecure https://localhost:6443/

curl --insecure https://10.206.16.11:6443/
curl --insecure https://localhost:6443/readyz?verbose&exclude=etcd

curl -v --cacert ./ca.csr --key ./ca-key.pem --cert ./ ca.pem https://10.206.16.11:6443/