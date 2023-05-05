#!/bin/bash

#echo "Enter desired namespace"
#read namespace

namespace=$(kubectl get namespace 2> /dev/null | tail -n+2 | fzf | awk '{print $1}' )
echo "$namespace"

if [ -z "$namespace" ]; then
  echo "no namespace selected"
  exit 0
fi

pod=$(kubectl get pods -n $namespace --field-selector=status.phase=Running 2> /dev/null | awk '{print $1,$3,$5}' | tail -n+2 | fzf | awk '{print $1'} )

if [ -z "$pod" ]; then
  echo "no pod selected"
  exit 0
fi

kubectl exec -n $namespace $pod /bin/bash -it
exit 0
