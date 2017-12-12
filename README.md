# Zeppelin Docker container with Glue Endpoint integration

[AWS Glue](https://aws.amazon.com/glue/) gives you the possibility to create a [development endpoint](http://docs.aws.amazon.com/glue/latest/dg/console-development-endpoint.html) to  develop the pyspark Glue jobs in a much friendlier way than using the AWS Glue console and submitting the jobs to AWS Glue. 
You can connect to the endpoint via SSH to access an interactive interpreter, or via a [Zeppelin](http://zeppelin.apache.org/) notebook.
You can install the Zeppelin notebook locally on your machine and connect it via an SSH tunnel, or spin up an EC2 instance with Zeppelin installed and configured. 

This project provides a docker container that you can run locally (TODO: test in ECS) based on the official [Apache Zeppelin docker container](http://zeppelin.apache.org/download.html). 

The docker image is configured to provide the SSH tunneling, thus combining the convenience of a preconfigured environment and the local persistance of notebooks and logs. With the Zeppelin EC2 instance created via Glue you would have to copy the notebooks to S3 or to local storage.

## How to
Clone this repository and run:
```
docker build -t zeppelin_glue .
```

Put the SSH private key corresponding to the one you used in the configuration of the AWS Glue development endpoint in `./ssh/ssh.key`. Ensure that the permissions on the file are correctly set via `chmod 600 ./ssh/ssh.key`.

You can then start the container in the foreground via:
```
docker run -p 8080:8080 --rm -v $PWD/ssh:/ssh -v $PWD/logs:/logs -v $PWD/notebook:/notebook -e DEV_ENDPOINT='ec2-aaa-bbb-ccc-ddd.compute-1.amazonaws.com' --name zeppelin zeppelin_glue
```

For deamon mode, add `-d`. 

Once the container is started it will connect to the development endpoint via SSH and run the Zeppeling notebook server. After few seconds you will be able to access Zeppelin at [localhost:8080](localhost:8080). The interpreter is already configured and you can start by adding a new note. AWS Glue uses pyspark: start your paragraphs with `%pyspark`. The first execution (`SHIFT+ENTER`) can be slow since the spark interpreter has to be started.

