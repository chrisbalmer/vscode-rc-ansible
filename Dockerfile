FROM registry.access.redhat.com/ubi8:8.0-122

RUN dnf install -y python3 \
                   openssh-clients \
                   git \
                   gcc \
                   python3-devel \
                   krb5-devel \
                   krb5-workstation

RUN mkdir /workspace /root/.ssh/
WORKDIR /workspace

COPY .devcontainer/requirements.txt.core requirements.txt* /workspace/

RUN pip3 install -r requirements.txt.core
RUN if [ -f "requirements.txt" ]; then pip3 install -r requirements.txt && rm requirements.txt*; fi

ENV SHELL /bin/bash