

  --bootstrap-kubeconfig=/home/ubuntu/coroutines/pki/token.csv \
  --cert-dir=/home/ubuntu/coroutines/pki/ \
  --kubeconfig=/home/ubuntu/coroutines/pki/kubelet.kubeconfig \
  --config=/home/ubuntu/coroutines/pki/kubelet.yaml \
  --network-plugin=cni \
  --pod-infra-container-image=k8s.gcr.io/pause:3.2 \
  --alsologtostderr=true \
  --logtostderr=false \
  --log-dir=/var/log/kubernetes \
  --v=2