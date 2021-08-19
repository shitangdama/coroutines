
kube-scheduler \
--address=127.0.0.1 \
--kubeconfig=/home/ubuntu/coroutines/pki/config.kubeconfig \
--leader-elect=true \
--alsologtostderr=true \
--logtostderr=false \
--log-dir=/var/log/kubernetes \
--v=2