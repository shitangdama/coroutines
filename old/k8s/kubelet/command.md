
kubelet \
--bootstrap-kubeconfig=/home/ubuntu/coroutines/pki/bootstrap.kubeconfig  \
--cert-dir=/home/ubuntu/coroutines/pki/kubelet/ \
--kubeconfig=/home/ubuntu/coroutines/pki/kubelet.kubeconfig \
--config=/home/ubuntu/coroutines/pki/kubelet-config.yaml \
--network-plugin=cni \
--pod-infra-container-image=k8s.gcr.io/pause:3.1 \
--alsologtostderr=true \
--logtostderr=false \
--log-dir=/var/log/kubernetes \
--v=4


kubelet \
--bootstrap-kubeconfig=/home/ubuntu/coroutines/pki/bootstrap.kubeconfig  \
--cert-dir=/home/ubuntu/coroutines/pki/kubelet/ \
--kubeconfig=/home/ubuntu/coroutines/pki/kubelet.kubeconfig \
--config=/home/ubuntu/coroutines/pki/kubelet-config.yaml \
--pod-infra-container-image=k8s.gcr.io/pause:3.1 \
--alsologtostderr=true \
--logtostderr=false \
--log-dir=/var/log/kubernetes \
--v=4


journalctl -f -u kubelet