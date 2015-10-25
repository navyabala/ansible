# Version: 0.0.1
FROM thinkingmonster/centos7-ansible 
MAINTAINER thinkingmonster "akash94thakur@gmail.com"

add inventory-file /etc/ansible/hosts
ADD provision.yml provision.yml
RUN ansible-playbook provision.yml -c local
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx"]
