#!/bin/sh -ex
# Nothing to build for hue

# temporary adding dependency packages to try build.
#yum -y install ant asciidoc cyrus-sasl-devel cyrus-sasl-gssapi libtidy libxml2-devel libxslt-devel openldap-devel python-devel python-simplejson sqlite-devel krb5-devel gcc gcc-c++ mysql mysql-devel cyrus-sasl-plain

cd ${WORKSPACE}
# delete existing sources and artifacts
rm -rf *.rpm ${JOB_NAME}-*

#RPM Setup
RPM_DB_DIR=${WORKSPACE}/${JOB_NAME}-${BUILD_ID}-rpm_db
mkdir -p ${RPM_DB_DIR}
INSTALL_DIR=${WORKSPACE}/${JOB_NAME}-${BUILD_ID}-install
mkdir -p ${INSTALL_DIR}
RPM_DIR=${WORKSPACE}/${JOB_NAME}-${BUILD_ID}-rpms
mkdir -p ${RPM_DIR}

#wget setup
WGET_OPTS="--progress=dot:mega -S -T 10 -t 5"

ant_link='vcc-apache-ant-1.8.4-201301271707.x86_64.rpm'
asciidoc_link='ftp://rpmfind.net/linux/centos/6.5/os/x86_64/Packages/asciidoc-8.4.5-4.1.el6.noarch.rpm'
#cyrus-sasl-devel_link='ftp://rpmfind.net/linux/centos/6.5/os/x86_64/Packages/cyrus-sasl-devel-2.1.23-13.el6_3.1.x86_64.rpm'
#cyrus-sasl-gssapi_link='ftp://rpmfind.net/linux/centos/6.5/os/x86_64/Packages/cyrus-sasl-gssapi-2.1.23-13.el6_3.1.x86_64.rpm'
#libtidy_link='ftp://rpmfind.net/linux/centos/6.5/os/x86_64/Packages/libtidy-0.99.0-19.20070615.1.el6.x86_64.rpm'
#libxml2-devel_link='ftp://rpmfind.net/linux/centos/6.5/os/x86_64/Packages/libxml2-devel-2.7.6-14.el6.x86_64.rpm'
#libxslt-devel_link='ftp://rpmfind.net/linux/centos/6.5/os/x86_64/Packages/libxslt-devel-1.1.26-2.el6_3.1.x86_64.rpm'
#openldap-devel_link='ftp://rpmfind.net/linux/centos/6.5/os/x86_64/Packages/openldap-devel-2.4.23-32.el6_4.1.x86_64.rpm'
python_devel_link='ftp://rpmfind.net/linux/centos/6.5/os/x86_64/Packages/python-devel-2.6.6-51.el6.x86_64.rpm'
python_simplejson_link='ftp://rpmfind.net/linux/centos/6.5/os/x86_64/Packages/python-simplejson-2.0.9-3.1.el6.x86_64.rpm'
#sqlite-devel_link='ftp://rpmfind.net/linux/centos/6.5/os/x86_64/Packages/sqlite-devel-3.6.20-1.el6.x86_64.rpm'
#krb5-devel_link='ftp://rpmfind.net/linux/centos/6.5/os/x86_64/Packages/krb5-devel-1.10.3-10.el6_4.6.x86_64.rpm'
#cyrus-sasl-plain_link='ftp://rpmfind.net/linux/centos/6.5/os/x86_64/Packages/cyrus-sasl-plain-2.1.23-13.el6_3.1.x86_64.rpm'
#gcc_link=''
#gcc-c++_link=''
#mysql_link=''
#mysql-devel_link=''


wget ${WGET_OPTS} https://Et_Omwyfs4:Rez1Shrik5@yum.service.verticloud.com/prod/${ant_link} -O ${RPM_DIR}/${ant_link}
wget ${WGET_OPTS} ${asciidoc_link} -O ${RPM_DIR}/asciidoc-8.4.5-4.1.el6.noarch.rpm
wget ${WGET_OPTS} ${python_devel_link} -O ${RPM_DIR}/python-devel-2.6.6-51.el6.x86_64.rpm
wget ${WGET_OPTS} ${python_simplejson_link} -O ${RPM_DIR}/python-simplejson-2.0.9-3.1.el6.x86_64.rpm

#RPM Install
rpm --initdb --dbpath ${RPM_DB_DIR}
#rpm -ivh ant asciidoc cyrus-sasl-devel cyrus-sasl-gssapi libtidy libxml2-devel libxslt-devel openldap-devel python-devel python-simplejson sqlite-devel krb5-devel gcc gcc-c++ mysql mysql-devel cyrus-sasl-plain --prefix ${INSTALL_DIR} --dbpath ${RPM_DB_DIR} --nodeps --quiet
rpm -ivh ant asciidoc python-devel python-simplejson --prefix ${INSTALL_DIR} --dbpath ${RPM_DB_DIR} --nodeps --quiet

