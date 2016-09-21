#To understand some of the concepts related to this file visit at https://stash-eng.cisco.com/sjc/shared/1/projects/CVGTOOL/repos/cvg_tools_ansible/browse/supervisord

FROM quay.cisco.com/akathaku/cidemo:latest

MAINTAINER akathaku <akathaku@cisco.com>

USER root


ENV SCPATH /etc/supervisor/conf.d
ENV PLAYBOOKS /ansible

# RUN yum  -y update

# The daemons
RUN yum -y install supervisor
RUN mkdir -p /var/log/supervisor

# Supervisor Configuration
ADD ./supervisord/conf.d/* $SCPATH/


#Running ansible
ADD ./sonar-playbook $PLAYBOOKS/sonar-playbook
ADD ./maven-playbook $PLAYBOOKS/maven-playbook
ADD ./artifactory-playbook $PLAYBOOKS/artifactory-playbook
ADD ./jenkins-playbook $PLAYBOOKS/jenkins-playbook
ADD ./tomcat-playbook $PLAYBOOKS/tomcat-playbook

WORKDIR $PLAYBOOKS/maven-playbook
RUN ansible-playbook maven.yml -c local
WORKDIR $PLAYBOOKS/sonar-playbook
RUN ansible-playbook sonar.yml -c local
WORKDIR $PLAYBOOKS/jenkins-playbook
RUN ansible-playbook jenkins.yml -c local
WORKDIR $PLAYBOOKS/tomcat-playbook
RUN ansible-playbook tomcat.yml -c local
WORKDIR $PLAYBOOKS/artifactory-playbook
RUN ansible-playbook artifactory.yml -c local



# Application Code

CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisor.conf"]
EXPOSE 8080 8081 9000 9001 8086