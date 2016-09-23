#To understand some of the concepts related to this file visit at https://github.com/thinkingmonster/ansible/tree/master/supervisord

FROM thinkingmonster/centos7-ansible

MAINTAINER akathaku <akathaku@thinkingmonster.com>

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