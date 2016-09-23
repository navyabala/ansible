#Working with playbooks and enhancing the same.

These playbooks  shall be run inside the docker container but you can also run these on host os.

##Building test environmnet to run this playbook.

- Log on to any linux server with  docker installed and running.Pull below mentioned docker image. <br>

```
docker pull thinkingmonster/centos7-ansible
```

- This docker image is already having git and ansible installed to it.Once image is pulled start  container using the same.<br>

```
docker run -t -p 8085:8080 -i thinkingmonster/centos7-ansible  /bin/bash
```

- once you get inside the container create a directory where you can pull these playbooks from github.<br>

```
mkdir /playbooks
```

- Get into the  /playbooks directory and  initialize the same.<br>

```
git init
```

- Pull these  playbooks from the github <br>

```
git pull https://github.com/thinkingmonster/ansible.git
```

- Get inside any  playbook. In this example we i will explaining with jenkins playbook <br>

```
cd jenkins-playbook
```
![Get_inside_container]
<br>
- Run below command to run the playbook <br>

```
ansible-playbook jenkins.yml
```
![Run_Ansible](https://github.com/thinkingmonster/ansible/blob/master/images/Ansible_run.png?raw)
<br>


- Once you execute the above command,notice that playbook will do following.

- [x] Install java.<br>
- [x] Install jenkins.<br>
- [x] Install require plugings in the jenkins.<br>
- [x] stop and start the jenkins.<br>

- Once Playbook run is done you can access the jenkins by accessing following url in your browser.<br>

```
http://<host machine>:8085
```

- Once you exit the  container jenkins will also stop.To attach back to the container and continue your testing  run below command to get your container id. <br>

```
docker ps -a
```

- Note down your container id and start the same. <br>

```
docker start <containerid>
```

- Once container is started.Get attached to the container. <br>

```
docker attach <containerid>
```
![Attach_container]
<br>

Now you are back in your container and  can  start your testing  inside container.Where you exited the container,you will find it in the same stage.With all files intact.You can do a git fetch and can test your changes related to jenkins playbook again.<br>

