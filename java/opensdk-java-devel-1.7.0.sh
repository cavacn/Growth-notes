#!/bin/sh
yum install -y java-1.7.0-openjdk-devel.x86_64
echo 'JAVA_HOME=$JAVAHOME:/usr/lib/jvm/jre-1.7.0-openjdk.x86_64/' >>~/.bashrc
echo 'CLASSPATH=$CLASSPATH:$JAVA_HOME/lib' >>~/.bashrc
source ~/.bashrc
java --version
