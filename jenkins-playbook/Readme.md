#Ansible Playbook -Jenkins


This playbook installs Jenkins  at /var/lib/jenkins location .


###Playbook variables

We have defined below mentioned variables for our playbook.


```
jenkins_connection_delay: 5
jenkins_connection_retries: 60
jenkins_hostname: localhost
jenkins_http_port: 8080
jenkins_jar_location: /opt/jenkins-cli.jar
jenkins_plugins:
  - git
  - sonar
  - ssh
  - cobertura
  - jira
  - job-import-plugin
  - plain-credentials
  - rally-plugin
  - stash-pullrequest-builder
  - stashNotifier
  - token-macro
  - workflow-step-api
  - view-job-filters
  - job-dsl
jenkins_url_prefix: ""

```

####Current Required functionalities.
- Add creadential management to the playbook.
- Add  automated job creation from groovy scripts.
- Update  playbook as out  demo pipelines.

#### To contribute

- Create a feature branch from the change.
- Make changes to feature branch only.
- Test your feature branch.
- Merge back to master.