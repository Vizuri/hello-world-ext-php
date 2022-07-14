#docker login -u `oc whoami` -p `oc whoami --show-token`  https://default-route-openshift-image-registry.apps.k8s-lab.it.tufts.edu 
oc registry login

oc new-project hello-world-ext-php

oc create imagestream hello-world

#docker build . -t default-route-openshift-image-registry.apps.k8s-lab.it.tufts.edu/hello-world-ext-php/hello-world:latest
docker buildx build --platform linux/amd64 . -t default-route-openshift-image-registry.apps.k8s-lab.it.tufts.edu/hello-world-ext-php/hello-world:latest

docker push default-route-openshift-image-registry.apps.k8s-lab.it.tufts.edu/hello-world-ext-php/hello-world:latest

helm upgrade hello-world-ext-php helm/hello-world-php/ --install
