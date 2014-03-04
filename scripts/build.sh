#!/bin/sh -ex
# Nothing to build for hue

# temporary adding dependency packages to try build.
yum -y install ant asciidoc cyrus-sasl-devel cyrus-sasl-gssapi libtidy libxml2-devel libxslt-devel openldap-devel python-devel python-simplejson sqlite-devel krb5-devel gcc gcc-c++ mysql mysql-devel cyrus-sasl-plain

