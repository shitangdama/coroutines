
# 生成证书：生成ca.pem和ca-key.pem文件
cfssl gencert -initca ca-csr.json | cfssljson -bare ca -



# 生成 
server-csr.json

cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes server-csr.json | cfssljson -bare server