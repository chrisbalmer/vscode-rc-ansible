FROM registry.access.redhat.com/ubi8:8.0-122

RUN dnf install -y python3 \
                   openssh-clients \
                   git \
                   gcc \
                   python3-devel \
                   krb5-devel \
                   krb5-workstation \
                   unzip \
    && dnf clean all

RUN cd /tmp/ \
    && curl -O https://releases.hashicorp.com/terraform/0.12.1/terraform_0.12.1_linux_amd64.zip \
    && unzip terraform_0.12.1_linux_amd64.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform_0.12.1_linux_amd64.zip

RUN cd /tmp/ \
    && curl -O https://cache.agilebits.com/dist/1P/op/pkg/v0.5.6-003/op_linux_amd64_v0.5.6-003.zip \
    && unzip op_linux_amd64_v0.5.6-003.zip \
    && mv op /usr/local/bin/ \
    && rm ./op*

RUN cd /tmp/ \
    && curl -OL https://github.com/wata727/tflint/releases/download/v0.8.3/tflint_linux_amd64.zip \
    && unzip tflint_linux_amd64.zip \
    && mv tflint /usr/local/bin/ \
    && rm ./tflint_linux_amd64.zip

RUN mkdir /workspaces /root/.ssh/
WORKDIR /workspaces

COPY .devcontainer/requirements.txt.core requirements.txt* /workspaces/

RUN pip3 install -r requirements.txt.core
RUN if [ -f "requirements.txt" ]; then pip3 install -r requirements.txt && rm requirements.txt*; fi

ENV SHELL /bin/bash

