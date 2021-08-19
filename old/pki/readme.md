

cat > token.csv << EOF
    $(head -c 16 /dev/urandom | od -An -t x | tr -d ' '),kubelet-bootstrap,10001,"system:kubelet-bootstrap"
EOF 

cfssl gencert -initca ca-csr.json | cfssljson -bare ca
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kubernetes-csr.json | cfssljson -bare kubernetes

cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes admin-csr.json | cfssljson -bare admin


CN：Common Name，用于从中提取该字段作为请求的用户名
C：Country， 国家
ST: State，州，省
L: Locality，地区，城市
O: Organization Name， 用于从中提前该字段作为请求用户所属的组
OU: Organization Unit Name，组织单位名称，公司部门




https://www.runoob.com/linux/linux-comm-lsmod.html

wget https://dl.k8s.io/v1.18.18/kubernetes-server-linux-amd64.tar.gz

tar -xzvf kubernetes-server-linux-amd64.tar.gz
cp kubernetes/server/bin/kube* /usr/bin/
chmod a+x /usr/bin/kube*

关于生成


