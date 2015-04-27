# ansible

add admin user :-
ansible-playbook  site.yml  --extra-vars "username=popat  password=akash admin=yes action=create_user"

add non-admin user:-
ansible-playbook  site.yml  --extra-vars "username=popat  password=akash admin=no action=create_user"

delete user:-
ansible-playbook  site.yml  --extra-vars "username=popat  action=delete_user"
