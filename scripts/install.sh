#!/bin/sh -ex
ALTISCALE_RELEASE=${ALTISCALE_RELEASE:-0.2.0}
HUE_VERSION=${ARTIFACT_VERSION:-3.0}

# Destination directory
DEST_ROOT=${INSTALL_DIR}/opt
mkdir --mode=0755 -p ${DEST_ROOT}

#Install Hue
cd ${WORKSPACE}/hue
PREFIX=${DEST_ROOT} make install

#Configuration
mkdir --mode=0755 -p ${INSTALL_DIR}/etc/hue-${HUE_VERSION}
ls -s ${INSTALL_DIR}/etc/hue-${HUE_VERSION} ${INSTALL_DIR}/etc/hue

cp ${INSTALL_DIR}/opt/hue/desktop/conf/pseudo-distributed.ini.tmpl ${INSTALL_DIR}/etc/hue/hue.ini
ln -s ${INSTALL_DIR}/etc/hue/hue.ini ${INSTALL_DIR}/opt/hue/desktop/conf/hue.ini

#Building RPM
cd ${RPM_DIR}
export RPM_NAME=vcc-hue-${ARTIFACT_VERSION}
fpm --verbose \
--maintainer ops@verticloud.com \
--vendor VertiCloud \
--provides ${RPM_NAME} \
--description "${DESCRIPTION}" \
--replaces vcc-hue \
-s dir \
-t rpm \
-n ${RPM_NAME} \
-v ${RPM_VERSION} \
--iteration ${DATE_STRING} \
${CONFIG_FILES} \
--rpm-user root \
--rpm-group root \
-C ${INSTALL_DIR} \
opt etc




