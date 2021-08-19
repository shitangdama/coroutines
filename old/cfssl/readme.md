    # 根据config.json文件的格式创建如下的ca-config.json文件
    # 过期时间设置成了 87600h
 
    cat > ca-config.json <<EOF
    {
      "signing": {
        "default": {
          "expiry": "87600h"
        },
        "profiles": {
          "kubernetes": {
            "usages": [
                "signing",
                "key encipherment",
                "server auth",
                "client auth"
            ],
            "expiry": "87600h"
          }
        }
      }
    }
    EOF
 
        知识点：
            ca-config.json：可以定义多个 profiles，分别指定不同的过期时间、使用场景等参数；后续在签名证书时使用某个 profile；此实例只有一个kubernetes模板。
            signing：表示该证书可用于签名其它证书；生成的 ca.pem 证书中 CA=TRUE；
            server auth：表示client可以用该 CA 对server提供的证书进行验证；
            client auth：表示server可以用该CA对client提供的证书进行验证；
        知识点：
            "CN"：Common Name，kube-apiserver 从证书中提取该字段作为请求的用户名 (User Name)
            "O"：Organization，kube-apiserver 从证书中提取该字段作为请求用户所属的组 (Group)
 
4 生成CA证书和私钥
    cfssl gencert -initca ca-csr.json | cfssljson -bare ca
    将会生成 ca-key.pem（私钥）  ca.pem（公钥）
    知识点： cfssljson只是整理json格式，-bare主要的意义在于命名 （个人见解，以便理解，勿喷）




    创建CA配置文件
    vim /opt/ssl/k8sca/ca-config.json
{
  "signing": {
    "default": {
      "expiry": "87600h"
    },
    "profiles": {
      "kubernetes": {
        "usages": [
            "signing",
            "key encipherment",
            "server auth",
            "client auth"
        ],
        "expiry": "87600h"
      }
    }
  }
}

创建CA证书签名请求
vim /opt/ssl/k8sca/ ca-csr.json

{
"CN": "kubernetes",
"key": {
    "algo": "rsa",
    "size": 2048
},
"names": [
    {
        "C": "CN",
        "L": "BeiJing",
        "O": "Ctyun",
        "ST": "BeiJing",            
        "OU": "ops"
    }    ]
}


生成CA所必需的文件ca-key.pem（私钥）和ca.pem（证书），还会生成ca.csr（证书签名请求），用于交叉签名或重新签名。

$ cd /opt/ssl/k8sca/
$ cfssl gencert -initca ca-csr.json | cfssljson -bare ca
$ ls
ca-config.json  ca.csr  ca-csr.json  ca-key.pem  ca.pem



cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kubernetes-csr.json | cfssljson -bare kubernetes


        知识点： -config 引用的是模板中的默认配置文件，-profiles是指定特定的使用场景，比如ca-config.json中的kubernetes区域

cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kubernetes-csr.json | cfssljson -bare kubernetes

cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes admin-csr.json | cfssljson -bare admin