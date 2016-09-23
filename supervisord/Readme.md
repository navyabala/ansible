## Understanding supervisor process and docker file.

Usually when you install various tools and software  inside  a docker container you need  some way to start your process inside the container.There is no process  manager inside the container which can start and stop your process.So to do the task here comes the role of supervisor package.

To  control a process with supervisor,create a file  for the service  inside conf.d directory as i have created for  jenkins and add content like this in the file

```
[program:jenkins]
command=/bin/bash -c "/etc/init.d/jenkins start"
redirect_stderr=true

```

Now when supervisor will be installed inside the container it will automatically pick this file and start the service.We have mentioned this in Dockerfile.See below content inside the docker file.

```
ENV SCPATH /etc/supervisor/conf.d
ENV PLAYBOOKS /ansible

# RUN yum  -y update

# The daemons
RUN yum -y install supervisor
RUN mkdir -p /var/log/supervisor

# Supervisor Configuration
ADD ./supervisord/conf.d/* $SCPATH/
```

This code  sets  vale for  SCPATH variable.It then installs the supervisor  in 6th line.In last line you can see that we have added  content of our conf.d directory inside the container. ADD keyword does this.

Finally check below code of dockerfile.

```
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisor.conf"]
```

This actually starts   the supervisor process and in turn supervisor starts all the processes defined inside conf.d in our repository.