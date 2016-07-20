FROM centos:7

#maintainer
MAINTAINER "Mithun Mandal" <mithun12000@gmail.com>

#setting environment
ENV container docker

#install vim, wget and openjdk
RUN yum install -y vim wget java-1.7.0-openjdk

#change directory to home
RUN cd home

#Downloading JDK 7
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.rpm"

#Install JDK
RUN yum localinstall jdk-7u79-linux-x64.rpm -y

#removing local file
RUN rm -f jdk-7u79-linux-x64.rpm 

#Setting Java alternative
RUN alternatives --install /usr/bin/java java /usr/java/latest/bin/java 5
RUN alternatives --install /usr/bin/java java /usr/java/jdk1.7.0_79/bin/java 5
RUN alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 5
RUN alternatives --install /usr/bin/javac javac /usr/java/jdk1.7.0_79/bin/javac 5
#RUN alternatives --set jar /usr/java/jdk1.7.0_79/bin/jar

RUN echo "JAVA_HOME=/usr/java/jdk1.7.0_79" > /etc/profile.d/java.sh
RUN echo "JRE_HOME=/usr/java/jdk1.7.0_79/jre" >> /etc/profile.d/java.sh
RUN echo "export JAVA_HOME" >> /etc/profile.d/java.sh
RUN echo "export JRE_HOME" >> /etc/profile.d/java.sh
RUN echo 'export PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin' >> /etc/profile.d/java.sh

#set scala version
RUN export SCALA_VERSION=scala-2.11.8
RUN wget http://www.scala-lang.org/files/archive/${SCALA_VERSION}.tgz
RUN echo "SCALA_HOME=/usr/local/scala/scala-2.11.8" > /etc/profile.d/scala.sh
RUN echo 'export SCALA_HOME' >> /etc/profile.d/scala.sh
RUN mkdir -p /usr/local/scala
RUN cp $SCALA_VERSION.tgz /usr/local/scala/
RUN cd /usr/local/scala/
RUN tar xvf $SCALA_VERSION.tgz
RUN rm -f $SCALA_VERSION.tgz
#RUN chown -R root:root /usr/local/scala

RUN alternatives --install "/usr/bin/scala" "scala" "/usr/local/scala/scala-2.11.8/bin/scala" 1
RUN alternatives --install "/usr/bin/scalac" "scalac" "/usr/local/scala/scala-2.11.8/bin/scalac" 1
RUN alternatives --install "/usr/bin/scalap" "scalap" "/usr/local/scala/scala-2.11.8/bin/scalap" 1
RUN alternatives --install "/usr/bin/scaladoc" "scaladoc" "/usr/local/scala/scala-2.11.8/bin/scaladoc" 1
RUN alternatives --install "/usr/bin/fsc" "fsc" "/usr/local/scala/scala-2.11.8/bin/fsc" 1
