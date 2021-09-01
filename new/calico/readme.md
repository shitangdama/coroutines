A：指定域名对应的IP地址
AAAA：将域名解析到指定的IPv6的IP地址上
CNAME：别名解析。将注册的不同域名转到同一个域名记录上，由这个域名进行统一解析管理。
NS：域名服务器记录，用来指定该域名由哪个DNS服务器进行解析。
PTR：反向DNS，用于将IP地址映射到对应主机名。即通过IP查询对应的域名。

sudo vi /etc/systemd/resolved.conf


sudo systemctl restart systemd-resolved
sudo systemctl enable systemd-resolved
sudo mv /etc/resolv.conf  /etc/resolv.conf.bak
sudo ln -s /run/systemd/resolve/resolv.conf /etc/


sudo cat /etc/resolv.conf 


开始要用 ip +host 设置etcd/host

tx yun 8.8.8.8 访问不到