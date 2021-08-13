
KUBE_APISERVER="https://172.17.0.2:6443"

BOOTSTRAP_TOKEN="12e458ef68ca548a72b87ae6ba4fa31d"

# KUBE_APISERVER=https://172.17.0.2:6443  #api-server访问地址

kubectl config set-cluster kubernetes \
  --certificate-authority=/home/ubuntu/coroutines/pki/ca.pem \
  --embed-certs=true \
  --server=${KUBE_APISERVER} \
  --kubeconfig=bootstrap.kubeconfig
kubectl config set-credentials kubelet-bootstrap \
  --token=${BOOTSTRAP_TOKEN} \
  --kubeconfig=bootstrap.kubeconfig
kubectl config set-context default \
  --cluster=kubernetes \
  --user=kubelet-bootstrap \
  --kubeconfig=bootstrap.kubeconfig
kubectl config use-context default --kubeconfig=bootstrap.kubeconfig