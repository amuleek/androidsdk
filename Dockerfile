# Use an official Ubuntu runtime as a base image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Download and install Android SDK
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH=${PATH}:${ANDROID_SDK_ROOT}/tools/bin:${ANDROID_SDK_ROOT}/platform-tools
RUN mkdir -p ${ANDROID_SDK_ROOT} && cd ${ANDROID_SDK_ROOT} \
    && curl -o sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip \
    && unzip sdk.zip \
    && rm sdk.zip \
    && yes | sdkmanager --licenses

# Set up environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=${PATH}:${JAVA_HOME}/bin

# Install OpenJDK (if not already installed)
RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    && rm -rf /var/lib/apt/lists/*
