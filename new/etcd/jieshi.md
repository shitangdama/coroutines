https://www.cnblogs.com/lowezheng/p/10307592.html
--name 节点名称
default: "default"
env variable: ETCD_NAME

这个值和--initial-cluster flag (e.g., default=http://localhost:2380)中的key值一一对应，如果在集群环境中，name必须是唯一的，建议用主机名称或者机器ID。\

--data-dir 数据存储目录
default: "${name}.etcd"
env variable: ETCD_DATA_DIR

--wal-dir
default: ""
env variable: ETCD_WAL_DIR

存放预写式日志,最大的作用是记录了整个数据变化的全部历程。未设置，共用--data-dir文件所在目录。

--snapshot-count
default: "100000"
env variable: ETCD_SNAPSHOT_COUNT

数据快照触发数量，etcd处理指定的次数的事务提交后，生产数据快照

--heartbeat-interval 客户端连接后的心跳间隔（毫秒）
default: "100"
env variable: ETCD_HEARTBEAT_INTERVAL

--election-timeout 集群选举的超时时间
default: "1000"
env variable: ETCD_ELECTION_TIMEOUT

--listen-peer-urls
本节点与其他节点进行数据交换(选举，数据同步)的监听地址，地址写法是 scheme://IP:port，可以多个并用逗号隔开，如果配置是http://0.0.0.0:2379,将不限制node访问地址

default: "http://localhost:2380"
env variable: ETCD_LISTEN_PEER_URLS
example: "http://10.0.0.1:2380"
invalid example: "http://example.com:2380" (domain name is invalid for binding)

--listen-client-urls
本节点访问地址，地址写法是 scheme://IP:port，可以多个并用逗号隔开，如果配置是http://0.0.0.0:2379,将不限制node访问地址

default: "http://localhost:2379"
env variable: ETCD_LISTEN_CLIENT_URLS
example: "http://10.0.0.1:2379"
invalid example: "http://example.com:2379" (domain name is invalid for binding)

--max-snapshots
最大快照数量 0表示不限制,在window平台设置无效。

default: 5
env variable: ETCD_MAX_SNAPSHOTS

--max-wals
最大预写日志数量 0表示不限制,在window平台设置无效。

default: 5
env variable: ETCD_MAX_WALS

--cors
Comma-separated white list of origins for CORS (cross-origin resource sharing).

default: none
env variable: ETCD_CORS

集群配置

--initial-advertise-peer-urls
通知其他节点与本节点进行数据交换（选举，同步）的地址，URL可以使用domain地址。

与--listener-peer-urls不同在于listener-peer-urls用于请求客户端的接入控制，initial-advertise-peer-urls是告知其他集群节点访问哪个URL，一般来说，initial-advertise-peer-urlsl将是istener-peer-urls的子集

default: "http://localhost:2380"
env variable: ETCD_INITIAL_ADVERTISE_PEER_URLS
example: "http://example.com:2380, http://10.0.0.1:2380"

--initial-cluster
集群所有节点配置，多个用逗号隔开。

default: "default=http://localhost:2380"
env variable: ETCD_INITIAL_CLUSTER
The key is the value of the --name flag for each node provided. The default uses default for the key because this is the default for the --name flag.

--initial-cluster-state
节点初始化方式，new 表示如果没有集群不存在，创建新集群，existing表示如果集群不存在，节点将处于加入集群失败状态。

default: "new"
env variable: ETCD_INITIAL_CLUSTER_STATE

--initial-cluster-token
集群唯一标识，相同标识的节点将视为在一个集群内。

default: "etcd-cluster"
env variable: ETCD_INITIAL_CLUSTER_TOKEN

--advertise-client-urls
用于通知其他ETCD节点，客户端接入本节点的监听地址，一般来说advertise-client-urls是listen-client-urls子集

default: "http://localhost:2379"
env variable: ETCD_ADVERTISE_CLIENT_URLS
example: "http://example.com:2379, http://10.0.0.1:2379"

注意，不能写http://localhost:237，这样就是通知其他节点，可以用localhost访问，将导致ectd的客户端用localhost访问本地,导致访问不通。还有一个更可怕情况，ectd布置了代理层，代理层将一直通过locahost访问自己的代理接口，导致无限循环。

--discovery
集群发现服务地址

default: none
env variable: ETCD_DISCOVERY

--discovery-srv
DNS发现服务地址

default: none
env variable: ETCD_DISCOVERY_SRV

--discovery-fallback
Expected behavior ("exit" or "proxy") when discovery services fails. "proxy" supports v2 API only.

default: "proxy"
env variable: ETCD_DISCOVERY_FALLBACK

--discovery-proxy
HTTP proxy to use for traffic to discovery service.

default: none
env variable: ETCD_DISCOVERY_PROXY

--strict-reconfig-check
Reject reconfiguration requests that would cause quorum loss.

default: false
env variable: ETCD_STRICT_RECONFIG_CHECK

--auto-compaction-retention
Auto compaction retention for mvcc key value store in hour. 0 means disable auto compaction.

default: 0
env variable: ETCD_AUTO_COMPACTION_RETENTION

--enable-v2 是否接受V2的API访问
default: true
env variable: ETCD_ENABLE_V2



代理
--proxy
Proxy mode setting ("off", "readonly" or "on").

default: "off"
env variable: ETCD_PROXY

--proxy-failure-wait
Time (in milliseconds) an endpoint will be held in a failed state before being reconsidered for proxied requests.

default: 5000
env variable: ETCD_PROXY_FAILURE_WAIT

--proxy-refresh-interval
代理节点刷新时间间隔（毫秒）
Time (in milliseconds) of the endpoints refresh interval.

default: 30000
env variable: ETCD_PROXY_REFRESH_INTERVAL

--proxy-dial-timeout
Time (in milliseconds) for a dial to timeout or 0 to disable the timeout

default: 1000
env variable: ETCD_PROXY_DIAL_TIMEOUT

--proxy-write-timeout
Time (in milliseconds) for a write to timeout or 0 to disable the timeout.

default: 5000
env variable: ETCD_PROXY_WRITE_TIMEOUT

--proxy-read-timeout
Time (in milliseconds) for a read to timeout or 0 to disable the timeout.
Don't change this value if using watches because use long polling requests.

default: 0
env variable: ETCD_PROXY_READ_TIMEOUT

安全
--cert-file
Path to the client server TLS cert file.

default: none
env variable: ETCD_CERT_FILE

--key-file
Path to the client server TLS key file.

default: none
env variable: ETCD_KEY_FILE

--client-cert-auth
Enable client cert authentication.

default: false
env variable: ETCD_CLIENT_CERT_AUTH

--trusted-ca-file
Path to the client server TLS trusted CA key file.

default: none
env variable: ETCD_TRUSTED_CA_FILE

--auto-tls
Client TLS using generated certificates

default: false
env variable: ETCD_AUTO_TLS

--peer-cert-file
Path to the peer server TLS cert file.

default: none
env variable: ETCD_PEER_CERT_FILE

--peer-key-file
Path to the peer server TLS key file.

default: none
env variable: ETCD_PEER_KEY_FILE

--peer-client-cert-auth
Enable peer client cert authentication.

default: false
env variable: ETCD_PEER_CLIENT_CERT_AUTH

--peer-trusted-ca-file
Path to the peer server TLS trusted CA file.

default: none
env variable: ETCD_PEER_TRUSTED_CA_FILE

--peer-auto-tls
Peer TLS using generated certificates

default: false
env variable: ETCD_PEER_AUTO_TLS

日志
--debug
Drop the default log level to DEBUG for all subpackages.

default: false (INFO for all packages)
env variable: ETCD_DEBUG

--log-package-levels
Set individual etcd subpackages to specific log levels. An example being etcdserver=WARNING,security=DEBUG

default: none (INFO for all packages)
env variable: ETCD_LOG_PACKAGE_LEVELS

不安全配置
--force-new-cluster
Force to create a new one-member cluster. It commits configuration changes forcing to remove all existing members in the cluster and add itself. It needs to be set to restore a backup.

default: false
env variable: ETCD_FORCE_NEW_CLUSTER

其他配置
--version
Print the version and exit.

default: false

--config-file
Load server configuration from a file.

default: none
Profiling flags

--enable-pprof
Enable runtime profiling data via HTTP server. Address is at client URL + "/debug/pprof/"

default: false

--metrics
Set level of detail for exported metrics, specify 'extensive' to include histogram metrics.

default: basic

认证
--auth-token
Specify a token type and token specific options, especially for JWT. Its format is "type,var1=val1,var2=val2,…". Possible type is 'simple' or 'jwt'. Possible variables are 'sign-method' for specifying a sign method of jwt (its possible values are 'ES256', 'ES384', 'ES512', 'HS256', 'HS384', 'HS512', 'RS256', 'RS384', 'RS512', 'PS256', 'PS384', or 'PS512'), 'pub-key' for specifying a path to a public key for verifying jwt, and 'priv-key' for specifying a path to a private key for signing jwt.