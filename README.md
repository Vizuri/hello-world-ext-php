# hello-world-ext-php

The hello-world-ext-php is a demonstration project that shows the steps to build a PHP application container external to OpenShift, push image into the internal openshift registry and then deploy it using a helm chart.

## Steps to Build and Run The Application

### Create Namespace to host the application
Create a namespace in openshift to host the application.

```
oc new-project hello-world-ext-php
```

### Create an imagesteam for the Container
Create an image stream in the application namespace to host the container. 

```
oc create imagestream hello-world -n hello-world-ext-php
```

### Build and Tag Image

 Build and tag the container image.  In this example, we are using docker to build and tag the image from the provided Dockerfile.  Note that the tag must match the path to your external registery path plus the namespace where you plan to run the applcation and the imaage stream created above.  

```
docker build . -t default-route-openshift-image-registry.apps.k8s-lab.it.tufts.edu/hello-world-ext-php/hello-world:latest
```
or if you are on M1 mac, use this command to build an adm64 container.
```
docker buildx build --platform linux/amd64 . -t default-route-openshift-image-registry.apps.k8s-lab.it.tufts.edu/hello-world-ext-php/hello-world:latest
```

### Login to the RedHat Internal Registry

You must login into the openshift registry.  These examples show how to login in if your are already logged into the openshift command line.  You could use a service account token as well.

You can either use a docker login command like this.
```
docker login -u `oc whoami` -p `oc whoami --show-token`  https://default-route-openshift-image-registry.apps.k8s-lab.it.tufts.edu 
```
Or the provided oc registry login command.
```
oc registry login
```

### Push image to OpenShift

Push the image to you imagestream. 

```
docker push default-route-openshift-image-registry.apps.k8s-lab.it.tufts.edu/hello-world-ext-php/hello-world:latest
```

### Install Helm Chart in the Application
Install the helm chart in the project.  Note that the image reference must match your project/imagestream. 
```
helm upgrade hello-world-ext-php helm/hello-world-php/ --install
```
