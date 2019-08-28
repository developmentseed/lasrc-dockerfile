FROM espa/external:latest
ENV PREFIX=/usr/local \
    SRC_DIR=/usr/local/src \
    ESPAINC=/usr/local/include \
    ESPALIB=/usr/local/lib \
		L8_AUX_DIR=/usr/local/src

# RUN cd $SRC_DIR \
	# && wget http://edclpdsftp.cr.usgs.gov/downloads/auxiliaries/lasrc_auxiliary/lasrc_aux.2013-2017.tar.gz \
	# && tar -xvzf lasrc_auxiliary.2013-2017.tar.gz


RUN REPO_NAME=espa-product-formatter \
    && REPO_TAG=product_formatter_v1.16.1 \
    && cd $SRC_DIR \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git ${REPO_NAME} \
    && cd ${REPO_NAME} \
    && git checkout ${REPO_TAG} \
    && make BUILD_STATIC=yes ENABLE_THREADING=yes \
    && make install \
    && cd $SRC_DIR \
    && rm -rf ${REPO_NAME}

RUN REPO_NAME=espa-surface-reflectance \
    && cd $SRC_DIR \
    && git clone https://github.com/USGS-EROS/${REPO_NAME}.git \
    && cd /usr/local/src/espa-surface-reflectance/lasrc/c_version/src \
    && make BUILD_STATIC=yes ENABLE_THREADING=yes \
    && make install \
    && make clean \ 
    # && cd /usr/local/src/espa-surface-reflectance/lasrc/landsat_aux/src \
    # && make BUILD_STATIC=yes ENABLE_THREADING=yes \
    # && make install \
    # && make clean \ 
    && cd $SRC_DIR \
    && rm -rf ${REPO_NAME}
