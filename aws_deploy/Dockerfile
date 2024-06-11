FROM amazonlinux:2

# Install required tools and dependencies
RUN yum install -y \
    python3 \
    python3-devel \
    gcc \
    gcc-c++ \
    make \
    wget \
    unzip \
    cmake3 \
    curl

# Create a symbolic link for cmake3 to cmake
RUN ln -s /usr/bin/cmake3 /usr/bin/cmake

# Install additional dependencies for building OpenCV
RUN yum install -y \
    gtk2-devel \
    pkgconfig \
    numpy \
    libtiff-devel \
    libjpeg-devel \
    libpng-devel \
    glib2-devel \
    libfontconfig1-devel \
    libglib2.0-devel \
    libgtk2.0-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libdc1394-22-dev \
    openexr \
    libopenexr-dev \
    libgstreamer-plugins-base1.0-dev \
    libavresample-dev \
    x264 \
    libx264-dev \
    libv4l-dev \
    libxvidcore-dev \
    libpq-dev \
    libpqxx-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    liblzma-dev \
    libfreetype6-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libexpat1-dev \
    python-dev \
    python-numpy \
    python3-dev \
    python3-numpy \
    python3-pip \
    unzip \
    curl

# Copy the OpenCV source code archive into the Docker image
COPY ./opencv-4.5.3.zip /tmp/opencv.zip

# Extract the OpenCV source code
RUN unzip /tmp/opencv.zip -d /tmp

# Build and install OpenCV
RUN mkdir -p /tmp/opencv-4.5.3/build && \
    cd /tmp/opencv-4.5.3/build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local .. && \
    make VERBOSE=1 -j8 && \
    make install

# Clean up
RUN rm -rf /tmp/opencv.zip /tmp/opencv-4.5.3 && \
    yum clean all && \
    rm -rf /var/cache/yum

CMD ["/bin/bash"]
