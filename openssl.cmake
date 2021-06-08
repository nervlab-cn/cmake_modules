if (UNIX)
    set (CUSTOM_LOCAL_PATH $ENV{HOME}/workspace/local)
    # 如果存在自编译的openssl库，则优先使用该库
    if (EXISTS /usr/local/opt/openssl@1.1/)
        set(SSL_INCLUDE_PATH /usr/local/opt/openssl@1.1/include)
        set(SSL_LIB_PATH /usr/local/opt/openssl@1.1/lib)
        set(SSL_STATIC_LIBS /usr/local/opt/openssl@1.1/lib/libssl.a /usr/local/opt/openssl@1.1/lib/libcrypto.a)
    elseif (EXISTS ${CUSTOM_LOCAL_PATH}/lib)
        set(SSL_INCLUDE_PATH ${CUSTOM_LOCAL_PATH}/include)
        set(SSL_LIB_PATH ${CUSTOM_LOCAL_PATH}/lib)
        set(SSL_STATIC_LIBS ${CUSTOM_LOCAL_PATH}/lib/libssl.a ${CUSTOM_LOCAL_PATH}/lib/libcrypto.a)
    elseif (EXISTS /usr/local/ssl/)
        set(SSL_INCLUDE_PATH /usr/local/ssl/include)
        set(SSL_LIB_PATH /usr/local/ssl/lib)
        set(SSL_STATIC_LIBS /usr/local/ssl/lib/libssl.a /usr/local/ssl/lib/libcrypto.a)
    elseif (EXISTS /usr/local/lib64)
        set(SSL_INCLUDE_PATH /usr/local/include)
        set(SSL_LIB_PATH /usr/local/lib64)
        set(SSL_STATIC_LIBS /usr/local/lib64/libssl.a /usr/local/lib64/libcrypto.a)
    elseif (EXISTS /usr/local/lib)
        set(SSL_INCLUDE_PATH /usr/local/include)
        set(SSL_LIB_PATH /usr/local/lib)
        set(SSL_STATIC_LIBS /usr/local/lib/libssl.a /usr/local/lib/libcrypto.a)
    else()
        set(SSL_STATIC_LIBS libssl.a libcrypto.a)
    endif()
endif (UNIX)


# author zouxiaoliang
# date: 20210607

#set (LIBOPENSSL_SRC "")
#set (LIBOPENSSL_INSTALL_DIR "")
#message (STATUS "Using bundled LIBOPENSSL in ${LIBOPENSSL_SRC}")

#set(LIBOPENSSL_LIB "${LIBOPENSSL_INSTALL_DIR}/lib/LIBOPENSSL.a")
#set(LIBOPENSSL_INCLUDE "${LIBOPENSSL_INSTALL_DIR}/include")

#ExternalProject_Add(
#  LIBOPENSSL
#  URL "https://www.openssl.org/source/openssl-1.1.1k.tar.gz"
#  URL_HASH "SHA256=892a0875b9872acd04a9fde79b1f943075d5ea162415de3047c327df33fbaee5"
#  CONFIGURE_COMMAND ./configure --prefix=${LIBOPENSSL_INSTALL_DIR} CFLAGS=-fPIC CPPFLAGS=-fPIC --enable-static=true --enable-shared=false
#  BUILD_COMMAND ${CMD_MAKE}
#  BUILD_IN_SOURCE 1
#  BUILD_BYPRODUCTS ${LIBOPENSSL_LIB}
#  INSTALL_COMMAND ${CMD_MAKE} install
#  UPDATE_COMMAND ""
#)
