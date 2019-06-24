FROM ubuntu

RUN apt-get update

# Install additional requirements
RUN apt-get -y install wget build-essential g++ cppcheck libgtest-dev unzip shellcheck cmake lcov gcovr git libboost-all-dev

# Compile gtest
RUN cd /usr/src/gtest && cmake CMakeLists.txt && make && cp *.a /usr/lib && ldconfig

# Install sonar-scanner
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492-linux.zip &&  \
    unzip sonar-scanner-cli-3.3.0.1492-linux.zip -d /opt/sonar && \
    chmod +x /opt/sonar/sonar-scanner-3.3.0.1492-linux/bin/sonar-scanner
