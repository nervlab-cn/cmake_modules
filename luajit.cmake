#
# Copyright (C) 2020 The Falco Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
# the License. You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.

option(CUSTOM_LIBS "using custom luajit library" OFF)

if (CUSTOM_LIBS)
    message(STATUS "using custom luajit library is ON")

    set(LUAJIT_SRC      "/Users/zouxiaoliang/workspace/github/luajit")
    set(LUAJIT_PREFIX   "${PROJECT_BINARY_DIR}/prefix")
    message(STATUS      "Using bundled LuaJIT in '${LUAJIT_SRC}'")
    set(LUAJIT_INCLUDE  "${LUAJIT_PREFIX}/include")
    set(LUAJIT_LIB      "${LUAJIT_PREFIX}/lib/libluajit-5.1.a")
    set(LUAJIT_BIN      "${LUAJIT_SRC}/src/luajit")

    execute_process(COMMAND sw_vers -productVersion OUTPUT_VARIABLE PV )
    string(STRIP ${PV} PV)
    ExternalProject_Add(
        luajit
        SOURCE_DIR "/Users/zouxiaoliang/workspace/github/luajit"
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ${CMD_MAKE} "MACOSX_DEPLOYMENT_TARGET=11.0"
        BUILD_IN_SOURCE 1
        BUILD_BYPRODUCTS ${LUAJIT_LIB}
        INSTALL_COMMAND ${CMD_MAKE} install PREFIX=${LUAJIT_PREFIX} && ln -sf ${LUAJIT_PREFIX}/include/luajit-2.1 ${LUAJIT_PREFIX}/include/luajit
#        BUILD_ALWAYS 1
        )

else()
    set(LUAJIT_SRC      "${PROJECT_BINARY_DIR}/luajit-prefix/src/luajit/src")
    set(LUAJIT_PREFIX   "${PROJECT_BINARY_DIR}/prefix")
    message(STATUS      "Using bundled LuaJIT in '${LUAJIT_SRC}'")
    set(LUAJIT_INCLUDE  "${LUAJIT_PREFIX}/include")
    set(LUAJIT_LIB      "${LUAJIT_PREFIX}/lib/libluajit-5.1.a")
    set(LUAJIT_BIN      "${LUAJIT_SRC}/luajit")

    if (APPLE)
        execute_process(COMMAND sw_vers -productVersion OUTPUT_VARIABLE PV )
        string(STRIP ${PV} PV)
        ExternalProject_Add(
            luajit
            GIT_REPOSITORY "https://github.com/LuaJIT/LuaJIT"
            GIT_TAG "1d8b747c161db457e032a023ebbff511f5de5ec2"
            CONFIGURE_COMMAND ""
            BUILD_COMMAND ${CMD_MAKE} "MACOSX_DEPLOYMENT_TARGET=${PV}"
            BUILD_IN_SOURCE 1
            BUILD_BYPRODUCTS ${LUAJIT_LIB}
            INSTALL_DIR ${LUAJIT_PREFIX}
            INSTALL_COMMAND ${CMD_MAKE} install PREFIX=${LUAJIT_PREFIX} && ln -sf ${LUAJIT_PREFIX}/include/luajit-2.1 ${LUAJIT_PREFIX}/include/luajit
            UPDATE_COMMAND ""
            )
    else()
        ExternalProject_Add(
          luajit
          GIT_REPOSITORY "https://github.com/LuaJIT/LuaJIT"
          GIT_TAG "1d8b747c161db457e032a023ebbff511f5de5ec2"
          CONFIGURE_COMMAND ""
          BUILD_COMMAND ${CMD_MAKE}
          BUILD_IN_SOURCE 1
          BUILD_BYPRODUCTS ${LUAJIT_LIB}
          INSTALL_COMMAND ""
          UPDATE_COMMAND ""
        )
    endif()
endif()

