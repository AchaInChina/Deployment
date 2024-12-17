#!/bin/bash

# 设置 NDK 路径
NDK_PATH=/home/sage/android/android-ndk-r27c
TOOLCHAIN_PREFIX=$NDK_PATH/toolchains/llvm/prebuilt/linux-x86_64/bin/arm-linux-androideabi-

# 设置目标架构
ARCH=arm64-v8a
API_LEVEL=25

# 创建构建目录
mkdir -p build
cd build

# 使用 CMake 配置项目
cmake /home/sage/android/libuv-1.49.2 -DCMAKE_TOOLCHAIN_FILE=$NDK_PATH/build/cmake/android.toolchain.cmake -DANDROID_NATIVE_API_LEVEL=$API_LEVEL -DANDROID_ABI=$ARCH -DANDROID_NDK=$NDK_PATH -DCMAKE_BUILD_TYPE=Release

# 构建项目
make -j$(nproc)
