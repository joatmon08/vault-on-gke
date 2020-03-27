kubectl exec -i -n $KUBE_NAMESPACE vault-0 -- vault status

if [ $? -eq 2 ]; then
  kubectl exec -i -n $KUBE_NAMESPACE vault-0 -- vault operator init | grep "Initial Root Token"
fi