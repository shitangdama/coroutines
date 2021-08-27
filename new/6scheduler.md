KUBE_CONFIG="/home/ubuntu/cert/kube-scheduler.kubeconfig"
KUBE_APISERVER="https://10.206.16.11:6443"

kubectl config set-cluster kubernetes \
  --certificate-authority=/home/ubuntu/cert/ca.pem \
  --embed-certs=true \
  --server=${KUBE_APISERVER} \
  --kubeconfig=${KUBE_CONFIG}
kubectl config set-credentials kube-scheduler \
  --client-certificate=./kube-controller-manager.pem \
  --client-key=/home/ubuntu/cert/kube-controller-manager-key.pem \
  --embed-certs=true \
  --kubeconfig=${KUBE_CONFIG}
kubectl config set-context default \
  --cluster=kubernetes \
  --user=kube-scheduler \
  --kubeconfig=${KUBE_CONFIG}
kubectl config use-context default --kubeconfig=${KUBE_CONFIG}


https://kubernetes.io/zh/docs/reference/command-line-tools-reference/kube-scheduler/

sudo vi /usr/lib/systemd/system/kube-scheduler.service


sudo systemctl daemon-reload 
sudo systemctl start kube-scheduler
sudo systemctl restart kube-scheduler
sudo systemctl enable --now kube-scheduler
sudo systemctl status kube-scheduler