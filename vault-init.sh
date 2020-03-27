#!/bin/bash

kubectl exec -i -n $KUBE_NAMESPACE vault-0 -- vault status

if [ $? -eq 2 ]; then
  kubectl exec -i -n $KUBE_NAMESPACE vault-0 -- vault operator init | grep "Initial Root Token"
fi

kubectl get service vault-ui -o jsonpath='{.status.loadBalancer.ingress[0].ip}'