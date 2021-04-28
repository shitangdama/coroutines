KUBE_CONFIG="/home/ubuntu/coroutines/pki/config.kubeconfig"
KUBE_APISERVER="https://172.17.0.2:6443"
kubectl config set-cluster kubernetes \
  --certificate-authority=/home/ubuntu/coroutines/pki/ca.pem \
  --embed-certs=true \
  --server=${KUBE_APISERVER} \
  --kubeconfig=kube-proxy.kubeconfig
# # 设置客户端认证参数
kubectl config set-credentials kube-proxy \
  --client-certificate=/home/ubuntu/coroutines/pki/kube-proxy.pem \
  --client-key=/home/ubuntu/coroutines/pki/kube-proxy-key.pem \
  --embed-certs=true \
  --kubeconfig=kube-proxy.kubeconfig
# # 设置上下文参数
kubectl config set-context default \
  --cluster=kubernetes \
  --user=kube-proxy \
  --kubeconfig=kube-proxy.kubeconfig

kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig