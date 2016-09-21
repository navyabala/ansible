#Sonar-Playbook

This playbook installs sonar  at /opt location.<br>


###Playbook variables

We have defined below mentioned variables for our playbook.


```
---
sonar_username: 'sonar'
sonar_dependencies:
-java-1.8.0-openjdk
-sonar-5.3
sonar_repo: 'http://downloads.sourceforge.net/project/sonar-pkg/rpm/sonar.repo
sonarrunner_url: 'http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/2.4/sonar-runner-dist-2.4.zip
sonar_plugins:
-http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/python/sonar-python-plugin/1.5/sonar-python-plugin-1.5.jar
```

####Current Required functionalities.
- Use postgres or mysql database for sonar.

#### To contribute

- Create a feature branch from the change.
- Make changes to feature branch only.
- Test your feature branch.
- Merge back to master.