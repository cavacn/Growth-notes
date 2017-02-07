#!/bin/sh
mysqlRpmUrl="https://dev.mysql.com/get/mysql57-community-release-el6-9.noarch.rpm"
sonarUrl="https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-6.2.zip"
tomcatUrl="http://mirrors.cnnic.cn/apache/tomcat/tomcat-7/v7.0.75/bin/apache-tomcat-7.0.75.tar.gz"
jenkinsUrl="https://mirrors.tuna.tsinghua.edu.cn/jenkins/war-stable/2.32.2/jenkins.war"

function installMySQL(){
    echo "安装 -[ MySQL ]- 官方源 $mysqlRpmUrl"
    rpm -ivh "$mysqlRpmUrl"
    yum install mysql-community-server -y
}

function installSonar(){
    echo "从 $sonarUrl 下载sonar.zip文件"
    wget $sonarUrl -Osonar.zip
    echo "解压sonar.zip"
    unzip sonar.zip
}

function installTomcat(){
    echo "从 $tomcatUrl 下载tomcat.tar.gz文件"
    wget $tomcatUrl -Otomcat.tar.gz
    tar -xvf tomcat.tar.gz
}

function installJenkins(){
    echo "从 $jenkinsUrl 下载jenkins.war文件"
    wget $jenkinsUrl -Ojenkins.war
}

echo ">>代码质量分析>>"
echo -n "是否全新安装MySQL5.7(y/n):"
read isInstallMySQL
if [[ "y"x == "$isInstallMySQL"x ]]; then
    installMySQL
fi

echo -n "是否全新安装Tomcat7.0.75(y/n):"
read isInstallTomcat
if [[ "y"x == "$isInstallTomcat"x ]]; then
    installTomcat
fi

echo -n "是否全新安装Sonar6.2(y/n):"
read isInstallSonar
if [[ "y"x == "$isInstallSonar"x ]]; then
    installSonar
fi

echo -n "是否全新安装Jenkins2.32.2(y/n):"
read isInstallJenkins
if [[ "y"x == "$isInstallJenkins"x ]]; then
    installJenkins
fi