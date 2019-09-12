## lasrc-dockerfile
This repository contains cloudformation templates and Dockerfiles for running the EROS `espa-surface-reflectance` code on ECS. 

The `lasrc` code requires a number of [dependencies](https://github.com/developmentseed/espa-surface-reflectance/tree/master/lasrc#dependencies) to manage these dependencies in a more streamlined way the `Dockerfile` uses a base image which can be built using `usgs.espa.centos.external` template defined in the [espa-dockerfiles](https://github.com/developmentseed/espa-dockerfiles) repository.
See the instructions in the repository for building the external dependencies image. 

After building the dependencies image, following the steps outlined [here](https://docs.aws.amazon.com/AmazonECR/latest/userguide/ECR_AWSCLI.html) you can tag this image as `552819999234.dkr.ecr.us-east-1.amazonaws.com/espa/external` and push it to ECR.

After building your base dependencies image and pushing it to ECR you can build the `lasrc` processing image with 

```shell
$ docker build --tag lasrc .
```

You can then tag this `lasrc` image as `552819999234.dkr.ecr.us-east-1.amazonaws.com/lasrc` and push it to ECR.

Now that we have the necessary images in ECR we can build the AWS infrastructure to run these containers as tasks. 


The `lasrc` processing code requires [auxiliary data](https://github.com/developmentseed/espa-surface-reflectance/tree/master/lasrc#downloads) to run. To use a task to download these data to the relevant location on EFS you can run ...

The `lasrc` auxiliary data also requires [periodic updates](https://github.com/developmentseed/espa-surface-reflectance/tree/master/lasrc#auxiliary-data-updates) to run these updates as a task ...





