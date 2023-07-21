# Fast Scanner

[简体中文](README.md) | English

Container images may contain outdated software versions, unpatched vulnerabilities, and sensitive information leakage, posing security risks. These vulnerabilities could be exploited by attackers, leading to container compromises, data leaks, or being used for malicious attacks. Therefore, regular image security scanning and updates are crucial.

Fast Scanner is a container image scanner designed specifically for container scenarios like Docker and Containerd. It can scan the images of container applications on servers. It provides two working modes: node image scanning and repository image scanning. Once the scanning is completed, Fast Scanner can generate detailed reports in XLSX format.

This tool takes into account domestic needs and can scan container images built on Euler, Kylin, and UOS (Tongxin) base images, demonstrating strong compatibility and applicability.

# Quick Start

```bash
docker run --rm -it --privileged \
  -e RUNTIME=docker \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(pwd)/reports:/app/reports \
  docker.io/arksec/fast-scanner:v1.0.0
```
Alternatively, you can use the "fast-scanner" image located on Alibaba Cloud (阿里云) to perform container image scanning.

```bash
docker run --rm -it --privileged \
  -e RUNTIME=docker \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(pwd)/reports:/app/reports \
  registry.cn-beijing.aliyuncs.com/arksecurity/fast-scanner:v1.0.0
```

# The highlights of Fast Scanner

**High Level of Localization Support:** Supports domestic operating systems such as Kylin, Unity, Euler, etc. It can scan container images built on these types of operating systems.

**One-click Scan Report:** Supports running one-off containers, quickly performs server security scans, and promptly issues a security scan report of the container image.

**Support for Various Image Repositories:** Supports mainstream Docker Registry, Harbor, JFrog, ACR, SWR. Also, it has good support for private cloud scenarios, including Huawei's and Alibaba's private clouds, BoCloud, Alauda, Miaoyun, KubeSphere, and many more.

# Running Fast Scanner

## Scan Local Image, Docker, Containerd

Node images are images downloaded to the local container runtime environment (i.e., node) and can potentially be used to run containers. These images are stored in the local image library of the container runtime environment and can be directly used to create and run containers.

In the Docker environment, you need to mount the docker.sock file into the scanning container. By default, the docker.sock file is located under the /var/run/docker.sock path.

```bash
docker run --rm -it --privileged \
  -e RUNTIME=docker \
  -v <path_to_docker_socket>:/var/run/docker.sock \
  -v $(pwd)/reports:/app/reports \
  docker.io/arksec/fast-scanner:v1.0.0
```

If you are using containerd as your container runtime, you need to mount the socket of containerd into the scanner container, where the default path for the socket is /run/containerd/containerd.sock. Then, you can create the scanning container for the containerd scenario using the ctr tool.

```bash
ctr images pull docker.io/arksec/fast-scanner:v1.0.0
ctr run --rm -t \
  --env RUNTIME=containerd \
  --mount type=bind,src=<path_to_containerd_socket>,dst=/run/containerd/containerd.sock,options=rbind:rw \
  --mount type=bind,src=$(pwd)/reports,dst=/app/reports,options=rbind:rw \
  docker.io/arksec/fast-scanner:v1.0.0 fast-scanner-container

```

## Scan Remote Image, Docker Registry, Harbor

Repository images refer to images stored in remote image repositories, such as Docker Hub or private repositories. These images are typically used for sharing and distribution, and when it's necessary to run containers on a new node, these images can be downloaded from the repository to the local as node images. In the development and deployment process, developers usually push the built images to the repository, and then pull images from the repository on the nodes where containers need to be run.

1. Configure Identity Credentials

To ensure that Fast Scanner can successfully access the remote image repository, you need to configure the corresponding login credentials. If your image repository uses a conventional username and password for authentication, please configure according to the following steps. The following example shows how to configure credentials for Harbor login using the Token method.

```yaml
# @.harbor.enabled 启用该登录凭证
# @.harbor.config.insecure 远程镜像仓库的 TLS 合法性，如果是不安全的镜像仓库，需要修改此值为 true
# @.harbor.config.address 远程镜像仓库的 URL
# @.harbor.config.username 用户
# @.harbor.config.password 密码
harbor:
  enabled: true
  config:
    insecure: false
    address: "https://registry.arksec.cn"
    username: "admin"
    password: "123456"
```

2. Mount the identity credential configuration file to the container and run it.

```bash
docker run --rm -it --privileged \
  -e RUNTIME=docker \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(pwd)/config-example.yaml:/app/config/config.yaml \
  -v $(pwd)/reports:/app/reports \
  docker.io/arksec/fast-scanner:v1.0.0
```

## Retrieving the Scan Report

he report after the image scan will be stored in the reports folder in your current working directory, with the report name in the form of reports_*. For convenience of reference, you can use tools such as SCP, SecureCRT, Xshell, WinSCP or MobaXterm to download the report file to your local computer.

![](./files/excel_report_example.png)

# Compatibility

**Supported Image System Version List**

- CentOS 3.x - 8.x

- RedHat 4.x - 8.x

- Debian 1.1.x - 12.x

- Ubuntu 4.10.x - 21.10.x

- EulerOS

- TencentOS

- RHCOS


**Supported Registry Type List**

- Docker Registry 2

- Harbor v1 & v2

**Supported Container Engine Type List**

- docker

- containerd

# Limited access to DockerHub network? Get the complete list of images

We provide many images distributed in public image repositories across different regions. Depending on your geographic location, you can choose the nearest or most suitable repository to pull images.

```
docker.io/arksec/fast-scanner:v1.0.0
registry.cn-beijing.aliyuncs.com/arksecurity/fast-scanner:v1.0.0
registry.cn-shanghai.aliyuncs.com/arksecurity/fast-scanner:v1.0.0
registry.cn-hangzhou.aliyuncs.com/arksecurity/fast-scanner:v1.0.0
registry.cn-huhehaote.aliyuncs.com/arksecurity/fast-scanner:v1.0.0
registry.ap-northeast-1.aliyuncs.com/arksecurity/fast-scanner:v1.0.0    // Tokyo, Japan
registry.us-west-1.aliyuncs.com/arksecurity/fast-scanner:v1.0.0    // Silicon Valley, USA
registry.me-east-1.aliyuncs.com/arksecurity/fast-scanner:v1.0.0    // Dubai, United Arab Emirates
```

# Technical Discussion Group

We are a group of geeks, marketing experts, and enthusiasts passionate about technological research and development, full of unlimited creativity, dreams, and passion for the future. "Endless Progress" is the brand culture we advocate, calling for people of this era to be brave in innovation and dare to create!

**QQ 群**

<p float="left">
  <img src="./files/QR_QQ.png" width="30%" />
</p>

# Company

rkSec Cloud is a high-tech company that focuses on the field of cloud-native security, explores and develops revolutionary technologies from the cloud to the edge, and is committed to breakthroughs in industrial transformation. ArkSec Cloud was born on the eve of a tremendous transformation brought about by cloud-native technology architecture and design thinking for security, with its headquarters located in Beijing, the capital of China.

The core members of our team come from well-known leading information security and infrastructure companies both at home and abroad. Together, we have built a technology-driven high-tech enterprise mainly composed of full-stack products and services for cloud-native security based on cloud-native technology architecture and design philosophy.

    https://www.arksec.cn

    https://www.arksec.cn/blog/

**公众号**

<p float="left">
  <img src="./files/QR_WX_8CM.jpg" width="30%" />
</p>

# LICENSE

Copyright (c) 2020-2023 ArkSec

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0
