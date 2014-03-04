#!/bin/sh -ex
# Nothing to build for hue

# temporary adding dependency packages to try build.
#yum -y install ant asciidoc cyrus-sasl-devel cyrus-sasl-gssapi libtidy libxml2-devel libxslt-devel openldap-devel python-devel python-simplejson sqlite-devel krb5-devel gcc gcc-c++ mysql mysql-devel cyrus-sasl-plain

cd ${WORKSPACE}
# delete existing sources and artifacts
rm -rf *.rpm ${JOB_NAME}-*

# options for fetching files with wget
WGET_OPTS="--progress=dot:mega -S -T 10 -t 5"

# Fetch and install the RPMs
RPM_DB_DIR=${WORKSPACE}/${JOB_NAME}-${BUILD_ID}-rpm_db
mkdir -p ${RPM_DB_DIR}
INSTALL_DIR=${WORKSPACE}/${JOB_NAME}-${BUILD_ID}-install
mkdir -p ${INSTALL_DIR}
R_RPM=vcc-R_${R_MAJOR_VERSION}-${R_MINOR_VERSION}.x86_64.rpm


rpm --initdb --dbpath ${RPM_DB_DIR}
rpm -ivhq ant asciidoc cyrus-sasl-devel cyrus-sasl-gssapi libtidy libxml2-devel libxslt-devel openldap-devel python-devel python-simplejson sqlite-devel krb5-devel gcc gcc-c++ mysql mysql-devel cyrus-sasl-plain --prefix ${INSTALL_DIR} --dbpath ${RPM_DB_DIR} --nodeps


