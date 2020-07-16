FROM centos:7

COPY amqp/launcher.sh /srv/launcher.sh
COPY amqp/qpidd.conf /etc/qpid/qpidd.conf

RUN : && \
    yum -y install \
      vim unzip wget git gcc-c:: make cmake maven swig \
      java-1.8.0-openjdk-devel perl-XML-XPATH python-devel procps-ng && \
    wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum -y install epel-release-latest-7.noarch.rpm && \
    yum -y install \
          mono-devel python34-devel jsoncpp-devel nodejs-rhea \
          qpid-proton-cpp-devel python-qpid-proton qpid-proton-cpp-devel python2-qpid-proton \
          qpid-cpp-server qpid-cpp-client-devel python-qpid qpid-qpid-client-rdma qpid-tools && \
    chmod 755 /srv/launcher.sh && \
    :

EXPOSE 5672

ENTRYPOINT ["bash", "-c", "/srv/launcher.sh"]
