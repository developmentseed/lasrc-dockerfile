##lasrc-dockerfile##
This repository contains cloudformation templates and Dockerfiles for running the EROS `espa-surface-reflectance` code on ECS. 

The `lasrc` code requires a number of [dependencies](https://github.com/developmentseed/espa-surface-reflectance/tree/master/lasrc#dependencies) to manage these dependencies in a more streamlined way the `Dockerfile` uses base image built fromn the `https://github.com/developmentseed/espa-surface-reflectance/tree/master/lasrc#dependencies).  To better manage these dependencies the `Dockerfile` uses a base image which can be built using `usgs.espa.centos.external` template defined in the [espa-dockerfiles](https://github.com/developmentseed/espa-dockerfiles) repository.


