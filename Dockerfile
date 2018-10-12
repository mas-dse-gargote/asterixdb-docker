#/*
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

FROM centos

ARG ASTERIX_VERSION=0.9.4

RUN echo 'LANG="en_US.UTF-8"' > /etc/sysconfig/i18n ;echo 'ZONE="America/Los_Angeles"' > /etc/sysconfig/clock ;cp -a /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
RUN echo "include_only=.us" >> /etc/yum/pluginconf.d/fastestmirror.conf
RUN yum -y update
RUN yum install -y unzip java-1.8.0-openjdk openssh-server openssh-clients python-setuptools wget curl

COPY target/lib/apache-asterixdb-${ASTERIX_VERSION}.zip .
RUN unzip apache-asterixdb-${ASTERIX_VERSION}.zip -d /opt \
    && ln -s /opt/apache-asterixdb-${ASTERIX_VERSION} /asterixdb \
    && rm apache-asterixdb*.zip


WORKDIR /asterixdb/bin

COPY entrypoint.sh /asterixdb/bin/entrypoint.sh

RUN chmod +x /asterixdb/bin/entrypoint.sh

ENV PATH="/asterixdb/opt/local/bin:/asterixdb/bin:${PATH}"
ENV JAVA_HOME /usr/lib/jvm/jre-1.8.0
ENV JAVA_OPTS -Xmx1536m
EXPOSE 19001 19002 8888 19003 50031

#ENTRYPOINT ['/asterixdb/bin/entrypoint.sh']
