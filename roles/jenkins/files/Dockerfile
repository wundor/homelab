FROM jenkins/jenkins:2.289.2-lts

USER root
RUN apt update && \
    apt install python3-pip -y && \
    apt clean && \
    pip3 install ansible

ADD roles/host_setup/files/ssh_config /etc/ssh/ssh_config
ADD roles/host_setup/files/ci .vault_pass /lab/
RUN mkdir -p /.ssh && \
    ansible-vault view --vault-password-file /lab/.vault_pass /lab/ci > /.ssh/id_ecdsa && \
    chown -R jenkins /.ssh && \
    chmod 0400 /.ssh/id_ecdsa && \
    rm -rf /lab
USER jenkins