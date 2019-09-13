## lasrc-dockerfile
This repository contains cloudformation templates and Dockerfiles for running the EROS `espa-surface-reflectance` code on ECS. 

The `lasrc` code requires a number of [dependencies](https://github.com/developmentseed/espa-surface-reflectance/tree/master/lasrc#dependencies). To manage these dependencies in a more streamlined way the `Dockerfile` uses a base image which can be built using the `usgs.espa.centos.external` template defined in the [espa-dockerfiles](https://github.com/developmentseed/espa-dockerfiles) repository.
See the instructions in the repository for building the external dependencies image. 

After building the dependencies image, following the steps outlined [here](https://docs.aws.amazon.com/AmazonECR/latest/userguide/ECR_AWSCLI.html) you can tag this image as `552819999234.dkr.ecr.us-east-1.amazonaws.com/espa/external` and push it to ECR.

After building your base dependencies image and pushing it to ECR you can build the `lasrc` processing image with 
```shell
$ docker build --tag lasrc .
```
You can then tag this `lasrc` image as `552819999234.dkr.ecr.us-east-1.amazonaws.com/lasrc` and push it to ECR.

The `lasrc` processing code requires [auxiliary data](https://github.com/developmentseed/espa-surface-reflectance/tree/master/lasrc#downloads) to run.  To build the image contaning the scripts for downloading this data to a shared EFS mount point run
```shell
$ docker build --tag lasrc_aux ./lasrc_aux
```
You can then tags this `lasrc_aux` images as `552819999234.dkr.ecr.us-east-1.amazonaws.com/lasrc_aux` and push it to ECR.

Now that we have the necessary images in ECR we can build the AWS infrastructure to run these containers as tasks. The included Cloudformation template contains all the necessary stack resources, to deploy a new stack run

```shell
$ ./deploy.sh
```
You will be prompted to enter a stack name.  This script assumes you have [configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) your AWS credentials and that your account has sufficient permissions to create new resources. 

Once your new stack is deployed you can run Lasrc as an ECS task with 

The `lasrc` auxiliary data also requires [periodic updates](https://github.com/developmentseed/espa-surface-reflectance/tree/master/lasrc#auxiliary-data-updates) to run these updates as a task ...
