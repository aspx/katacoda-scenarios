#!/bin/bash

ssh root@[[HOST_IP]] 'echo "Host *" >> /root/.ssh/config && echo "    StrictHostKeyChecking no" >> /root/.ssh/config && chmod 400 /root/.ssh/config'

while [ ! -f /root/.kube/config ]
  do
    sleep 1
  done
if [ -f /root/.kube/start ]; then
  /root/.kube/start
fi

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
curl -s https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

ssh root@node01 'curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -;curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -'
ssh root@node02 'curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -;curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -'
ssh root@node03 'curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -;curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -'

# Wait for the 4 nodes 
#while [[ $(kubectl get nodes | wc -l) != "5" ]]; do sleep 1; done
#ssh root@node03 'systemctl stop kubelet'

