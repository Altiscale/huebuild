#!/bin/sh -ex
ALTISCALE_RELEASE=${ALTISCALE_RELEASE:-0.2.0}
HUE_VERSION=${ARTIFACT_VERSION:-3.5}

# Destination directory
DEST_ROOT=${INSTALL_DIR}/opt/hue-${HUE_VERSION}
mkdir --mode=0755 -p ${DEST_ROOT}
#ln -s ${INSTALL_DIR}/opt/hue-${HUE_VERSION} ${INSTALL_DIR}/opt/hue

#Install Hue
cd ${WORKSPACE}/hue
TEMP_INSTALL_DIR=${INSTALL_DIR}
INSTALL_DIR=${DEST_ROOT}
PREFIX=${DEST_ROOT} make install
/bin/chmod +x ./tools/relocatable.sh
./tools/relocatable.sh
INSTALL_DIR=${TEMP_INSTALL_DIR}

/usr/sbin/prelink -u ${DEST_ROOT}/build/env/bin/python
/usr/sbin/prelink -u ${DEST_ROOT}/build/env/bin/python2.6

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
-v ${ARTIFACT_VERSION} \
--iteration ${DATE_STRING} \
--rpm-user hue \
--rpm-group hue \
-C ${INSTALL_DIR} \
opt




