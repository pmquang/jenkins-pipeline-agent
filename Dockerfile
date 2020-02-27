FROM alpine:3.10
LABEL maintainer="qpham@archanan.io"

USER root

RUN apk add --no-cache curl \
  bash \
  python py-pip \
  gzip \
  ca-certificates \
  docker\
  git && \
  pip install awscli==1.16.279 codecov semver && \
	rm -rf /var/cache/apk/* \
  mkdir /root/.kube/ && touch /root/.kube/config

RUN curl -s https://releases.hashicorp.com/terraform/0.12.8/terraform_0.12.8_linux_amd64.zip | zcat > /usr/bin/terraform \
	&& chmod +x /usr/bin/terraform
RUN curl -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator \ 
  && chmod +x /usr/local/bin/aws-iam-authenticator
RUN curl -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.17.0/bin/linux/amd64/kubectl \
  && chmod +x /usr/local/bin/kubectl

COPY ./app.sh /usr/local/bin/app.sh
ENTRYPOINT ["/usr/local/bin/app.sh"]
