ARG IMAGE=delegate-immutable
ARG TAG=23.01.78102.minimal
FROM harness/$IMAGE:$TAG
ARG TERRAFORM_VERSION=1.3.6
ARG TERRAFORM_ARCH=linux_amd64
USER root
RUN cat /etc/redhat-release
RUN cat /etc/os-release
RUN \
  set -e; \
  microdnf install -y https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm && \
  microdnf install unzip azure-cli; \
  microdnf install unzip openssl git && \
  microdnf clean all; \
  echo "Installing Helm 3"; \
  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash; \
  echo "Installing Terraform version ${TERRAFORM_VERSION}"; \
  curl -O -L https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_${TERRAFORM_ARCH}.zip; \
  unzip terraform_${TERRAFORM_VERSION}_${TERRAFORM_ARCH}.zip; \
  mv ./terraform /usr/bin/ && \
  chmod +x /usr/bin/terraform; \
  terraform --version
​
USER 1001