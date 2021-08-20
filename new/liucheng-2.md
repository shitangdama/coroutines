

docker

chmod +x cfssl_linux-amd64 cfssljson_linux-amd64 cfssl-certinfo_linux-amd64
mv cfssl_linux-amd64 /usr/local/bin/cfssl
mv cfssljson_linux-amd64 /usr/local/bin/cfssljson
mv cfssl-certinfo_linux-amd64 /usr/bin/cfssl-certinfo

sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo service docker restart

sudo systemctl restart docker

签证书




# 生成证书：生成ca.pem和ca-key.pem文件
cfssl gencert -initca ca-csr.json | cfssljson -bare ca -

# 使用自签CA签发kube-apiserver HTTPS证书
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes server-csr.json | cfssljson -bare server


sudo vi /usr/lib/systemd/system/kube-apiserver.service