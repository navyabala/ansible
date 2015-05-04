As of now we already know what are tasks and handlers and how to use then in ansible. But writing all the yml in to one single file is not the good option .In fact we have roles defined in side playbooks which help us to organise our files.
In side any playbook, create below mentioned directories as I have created in my “manage_users” playbook
[root@puppetmaster manage_users]# tree
.
├── roles
│ ├── usercreate
│ │ ├── defaults
│ │ ├── files
│ │ ├── handlers
│ │ ├── meta
│ │ ├── tasks
│ │ │ └── main.yml
│ │ ├── templates
│ │ └── vars
│ └── userdel
│ ├── defaults
│ ├── files
│ ├── handlers
│ ├── meta
│ ├── tasks
│ │ └── main.yml
│ ├── templates
│ └── vars
└── site.yml

So “usercreate ” and “userdel ” are the two roles created .Below is the short description regarding each directory of the role.
• If roles/x/tasks/main.yml exists, tasks listed therein will be added to the play
• If roles/x/handlers/main.yml exists, handlers listed therein will be added to the play
• If roles/x/vars/main.yml exists, variables listed therein will be added to the play
• If roles/x/meta/main.yml exists, any role dependencies listed therein will be added to the list of roles (1.3 and later)
• Any copy tasks can reference files in roles/x/files/ without having to path them relatively or absolutely
• Any script tasks can reference scripts in roles/x/files/ without having to path them relatively or absolutely
• Any template tasks can reference files in roles/x/templates/ without having to path them relatively or absolutely
• Any include tasks can reference files in roles/x/tasks/ without having to path them relatively or absolutely

<strong>Creating User_manage playbook:-</strong>

Here I will be explaining as how to create user_manage playbook with “usercreate” and “userdel” roles each.

1) Create a “user_manage”empty playbook directory and create site.yml file inside it.
mkdir user_manage
cd user_manage
touch site.yml

2) Create a “roles” directory inside “user_manage” with “usercreate” and “userdel” directories inside it.
mkdir usercreate userdel

3) Inside each role create below sub-directories
cd userdel &amp;&amp; mkdir defaults files handlers meta tasks templates vars
cd ../ usercreate &amp;&amp; mkdir defaults files handlers meta tasks templates vars

4) Lets build our roles now .For now we will be using only the task directory of our roles in this example and will write main.yml file inside each role.We don’t need other directories for this example but will be utilizing all in our next examples.

5) Create main.yml file inside the “usercreate/tasks” with content as shown below.
<span style="color: #000080;">---</span>
<span style="color: #000080;"> - name: Generate passwords</span>
<span style="color: #000080;">  shell: python -c 'import crypt; print crypt.crypt("{{ upassword }}", "$6$random_salt")'</span>
<span style="color: #000080;">  register: genpass</span>

<span style="color: #000080;">- name: Creating user "{{ uusername }}" with admin access</span>
<span style="color: #000080;">  user: name={{ uusername }} password={{ genpass.stdout }} groups=admin append=yes</span>
<span style="color: #000080;">  when: assigned_role == "yes"</span>

<span style="color: #000080;">- name: Creating users "{{ uusername }}" without admin access</span>
<span style="color: #000080;">  user: name={{ uusername }} password={{ genpass.stdout }}</span>
<span style="color: #000080;">  when: assigned_role == "no"</span>

<span style="color: #000080;">- name: Expiring password for user "{{ uusername }}"</span>
<span style="color: #000080;">  shell: chage -d 0 "{{ uusername }}"</span>
<p style="text-align: center;"><a href="https://thinkingmonster.files.wordpress.com/2015/04/role1.png"><img class=" size-full wp-image-432 aligncenter" src="https://thinkingmonster.files.wordpress.com/2015/04/role1.png" alt="role1" width="529" height="198" /></a></p>
6) Create main.yml file inside the “userdel/tasks” with content as shown below.
---
<span style="color: #000080;">- name: Deleating user "{{ uusername }}"</span>
<span style="color: #000080;">  user: name="{{ uusername }}" state=absent remove=yes</span>

<a href="https://thinkingmonster.files.wordpress.com/2015/04/role2.png"><img class=" size-full wp-image-433 aligncenter" src="https://thinkingmonster.files.wordpress.com/2015/04/role2.png" alt="role2" width="442" height="87" /></a>

7) Once main.yml files are created inside the roles add below data to site.yml file inside “manage_users” playbook
<span style="color: #000080;">---</span>
<span style="color: #000080;"> - hosts: thinkingmonster</span>
<span style="color: #000080;"> user: root</span>
<span style="color: #000080;"> vars:</span>
<span style="color: #000080;"> user_password: "{{ password }}"</span>
<span style="color: #000080;"> user_name: "{{ username }}"</span>
<span style="color: #000080;"> is_admin: "{{ admin }}"</span>
<span style="color: #000080;"> roles:</span>
<span style="color: #000080;"> - { role: usercreate ,upassword: "{{ user_password }}",uusername: "{{ user_name }}",assigned_role: "{{ is_admin }}", when: action == "create_user" }</span>
<span style="color: #000080;"> - { role: userdel ,uusername: "{{ user_name }}", when: action == "delete_user" }</span>

<a href="https://thinkingmonster.files.wordpress.com/2015/04/role3.png"><img class=" size-full wp-image-434 aligncenter" src="https://thinkingmonster.files.wordpress.com/2015/04/role3.png" alt="role3" width="529" height="98" /></a>

<strong>Explaining the concept:-</strong>
<span style="text-decoration: underline;"><em>site.yml</em></span>

When creating a user using my play book I will be running my play book with below command
<span style="color: #000080;"><em>ansible-playbook site.yml --extra-vars "username= password= admin=yes action=create_user"</em></span>

Here I am passing all the variables from command line when running site.yml so below code in site.yml assigns the values further to the variable.

<span style="color: #000080;"><em>vars:</em></span>
<span style="color: #000080;"><em> user_password: "{{ password }}"</em></span>
<span style="color: #000080;"><em> user_name: "{{ username }}"</em></span>
<span style="color: #000080;"><em> is_admin: "{{ admin }}"</em></span>

so now “user_password”,”user_name” and “is admin” has the value of input variables.

In next lines I have called the related roles and have passed these variables to the roles so that they van be used.

<span style="color: #000080;"><em>roles:</em></span>
<span style="color: #000080;"><em> - { role: usercreate ,upassword: "{{ user_password }}",uusername: "{{ user_name }}",assigned_role: "{{ is_admin }}", when: action == "create_user" }</em></span>
<span style="color: #000080;"><em> - { role: userdel ,uusername: "{{ user_name }}", when: action == "delete_user" }</em></span>

Here “upasswd”,”uusername” and “assigned_role” are the variable defined inside “createuser” role.Check main.yml file of the role inside tasks.

So this is the way how variables are passed from the command line across the site.yml and to the roles finally.

<span style="text-decoration: underline;"><em>createuser/tasks/main.yml</em></span>

Here we are generating encrypted form of our password sent from the command line and storing the same inside the genpass variable

<span style="color: #000080;"><em>- name: Generate passwords</em></span>
<span style="color: #000080;"><em> shell: python -c 'import crypt; print crypt.crypt("{{ upassword }}", "$6$random_salt")'</em></span>
<span style="color: #000080;"><em> register: genpass</em></span>

next we are creating the actual user on the machine by passing the username and encrypted password

<span style="color: #000080;"><em>- name: Creating user "{{ uusername }}" with admin access</em></span>
<span style="color: #000080;"><em> user: name={{ uusername }} password={{ genpass.stdout }} groups=admin append=yes</em></span>
<span style="color: #000080;"><em> when: assigned_role == "yes"</em></span>

we have used password={{ genpass.stdout }} ie assigned the value to the password but instead of using genpass only we are using genpass.stdout.Its because genpass contain an array of key value pairs and we are only interested in stdout which contains the encrypted password.

And further this task will only be executed when value of assigned_role variable is “yes” only.It will be skipped otherwise.

Last lines of the file are to set the account expired so that user can forced to change the password on first login

<span style="color: #000080;"><em>- name: Expiring password for user "{{ uusername }}"</em></span>
<span style="color: #000080;"><em> shell: chage -d 0 "{{ uusername }}</em></span>"

<span style="text-decoration: underline;"><em>userdel/tasks/main.yml</em></span>

The code written in the file id doing nothing more then removing the account from the hosts.
<span style="color: #000080;"><em>- name: Deleating user "{{ uusername }}"</em></span>
<span style="color: #000080;"><em> user: name="{{ uusername }}" state=absent remove=yes</em></span>
remove=yes ensures that home directory of the user shall also be deleted.

Indentation for the code may be wrong here refer below link  of my <a href="https://github.com/thinkingmonster/ansible" target="_blank">git-hub</a> repository for original examples.

<strong>Using Playbook</strong>

<span style="text-decoration: underline;"><em>Adding admin user:-</em></span>

<span style="color: #000080;"> ansible-playbook site.yml --extra-vars "username=popat password=akash admin=yes action=create_user"</span>

<span style="text-decoration: underline;"><em>Adding normal user:-</em></span>

<span style="color: #000080;">ansible-playbook site.yml --extra-vars "username=popat password=akash admin=no action=create_user"</span>

<span style="text-decoration: underline;"><em>Removing user:-</em></span>

<span style="color: #000080;">ansible-playbook site.yml --extra-vars "username=popat action=delete_user"</span>

&nbsp;

&nbsp;

 ansible-playbook linux_users.yml   --extra-vars "username=xxxxx  password=yyyy admin=yes action=create_user remote=192.168.249.134" --user anjna -k --sudo -K

 
ansible-playbook postgres_users.yml --extra-vars "remote=192.168.249.134  loginuser=tom loginpassword=password username=akash userpassword=akash"
ansible-playbook postgres_users.yml --extra-vars "remote=app-servers loginuser=akash loginpassword=akash username=devashish userpassword=devashish role=SUPERUSER,CREATEDB,CREATEROLE" --user athakur -k --sudo -K
ansible all -m postgresql_user -a "login_user=akash login_password=akash login_host=127.0.0.1 name=devashish db=postgres state=absent" --user athakur -k
