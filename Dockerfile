FROM ubuntu

RUN apt-get update

# Install additional requirements
RUN apt-get -y install wget build-essential g++ cppcheck libgtest-dev unzip shellcheck cmake lcov gcovr git libboost-all-dev librabbitmq-dev libssl-dev

# Compile gtest
RUN cd /usr/src/gtest && cmake CMakeLists.txt && make && cp *.a /usr/lib && ldconfig

# Create tmp dir
RUN mkdir -p /opt/build-tmp

# Download and build rabbitmq-c
RUN cd /opt/build-tmp && \
    git clone https://github.com/alanxz/rabbitmq-c.git && \
    cd rabbitmq-c && \
    mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
    cmake --build . --target install

# Download and build SimpleAmpqClient
RUN cd /opt/build-tmp && \
    git clone https://github.com/killpl/SimpleAmqpClient.git && \
    cd SimpleAmqpClient && \
    mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
    cmake --build . --target install

# Cleanup
RUN rm -rf /opt/build-tmp

# Install sonar-scanner
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492-linux.zip &&  \
    unzip sonar-scanner-cli-3.3.0.1492-linux.zip -d /opt/sonar && \
    chmod +x /opt/sonar/sonar-scanner-3.3.0.1492-linux/bin/sonar-scanner
