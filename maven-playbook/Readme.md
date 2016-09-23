#Maven-Playbook

This playbook installs maven  at /opt location.<br>


###Playbook variables

We have defined below mentioned variables for our playbook.

```
---
maven_version: 3.3.9
artifactrepo:
   nexus: False
   artifactory: True
```
   

- maven_version :- defines the version of maven to be installed.
- Artifact repo :- Allows you to use any of the artifactory  solution.You can use nexus if installed by making value  for nexus as true or can also choose artifactory if its also installed on the same  machine,where  maven is installed using this playbook

###Playbook  Anatomy

Different files and folders used in this playbook can be defined as following.

![Attach_container](https://github.com/thinkingmonster/ansible/blob/master/images/maven-playbook/maven-playbook-anotamy.png?raw)

We have below files and structure defined for our playbook.

- **maven-playbook :** This is main playbook directory.Acts as container for all playbook related roles and other files.
- **roles :** Role are the actual piece of execution.They have there own defined directory structure.Roles contain  tasks which contains  further plays.
- **maven :** This is our maven role.
- **defaults :** defaults hold files in which we can define default values for the variables that are used in the playbook.Like here i have defined maven_version as a variable.
- **main.yml :** This  file inside defaults contains different variables defined.
- files: This  folder contains any files that we want to place as it id during the maven installation.Here it contains settings files for both artifactory and nexus.
- **artifactory_settings.xml :** File having   maven configuration to use artifactory.Will be placed at /opt/maven/conf
- **nexus_settings.xml :** File having   maven configuration to use nexus .Will be placed at /opt/maven/conf
- **handlers :** contains YAML files which contain 'handlers' little bits of config that can be triggered with the notify: action inside a task. 
- **tasks :** Directory to hold different yml files.Performing some kind of action.
- **java.yml :** contains  directions(plays) to install java.
- **main.yml :** This is the file which bind all other files in tasks to each other.
- **maven_install.yml :** This file contains plays to install maven
- **vars :** This is a directory where you can define some variables to be used in the playbook.
- **maven.yml :** This is the main  file in top most directory and allows which role to run.
- **Readme.md :** instruction file.You are reading this content which is written in this file.


####Current Required functionalities.
- Allow installation in any directory.
- Allow to choose java version.


#### To contribute

- Create a feature branch from the change.
- Make changes to feature branch only.
- Test your feature branch.
- Merge back to master.
