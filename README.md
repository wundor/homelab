# WundeR homelab

Something something Docker swarm

New machine routine

```
useradd -s /bin/bash -m wunder
echo "wunder ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/wunder
su - wunder
mkdir .ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDDuz/wJMMw2Xw25iP5adfAwbHzZXLNiLmLhpzioQWlU2TrvitBd7QxW5X8cOrsfOSjtaDynPUPB7DSvAKX70PORVyldplpQ3N6jBaWCHl3KK9k+5Cm6fmc3F3tQbG29kz++EOyvCuIhQyPdFgPUjVq3WG9OBtBCyCT1Wgfl8qEfMTj0qlTfbyyFcD5c76qxyY0tOHpAI5P2enUMU2CfqWt/GYqqdd6BZbk0O6gNNw9n84/G+DmtazHa530vyZEQwOeC9YY7KfNYuPulgHIbuQ289tRqIH3cvuoeTPSKF+l0eo5QIkew9nPj7dnyyT9azLwuOWmBR5G5rm3k4sqDxN1 wunder
" > .ssh/authorized_keys
passwd # if needed
```


Encryption

```
ansible-vault encrypt_string --vault-password-file .vault_pass 'secret' --name 'var_name'
```