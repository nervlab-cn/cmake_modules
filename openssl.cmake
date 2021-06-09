# author zouxiaoliang
# date: 20210607

if (UNIX)

    set (LIBOPENSSL_PREFIX_DIR "$ENV{HOME}/.nervlab/libopenssl_1_1_1k-prefix")
    message (STATUS "Using bundled LIBOPENSSL in ${LIBOPENSSL_SRC}")

    set(LIBOPENSSL_INCLUDE "${LIBOPENSSL_PREFIX_DIR}/include")
    set(LIBOPENSSL_CRYPTO_LIB "${LIBOPENSSL_PREFIX_DIR}/lib/libcrypto.a")
    set(LIBOPENSSL_SSL_LIB "${LIBOPENSSL_PREFIX_DIR}/lib/libssl.a")

    message(STATUS "[openssl] OPENSSL_EXISTS is $ENV{OPENSSL_EXISTS}.")
    if ($ENV{OPENSSL_EXISTS})
        if (NOT CMD_MAKE)
            message(STATUS "[openssl] set CMD_MAKE is make.")
            set(CMD_MAKE make)
        endif()

        set(ENV{OPENSSL_EXISTS} YES)
        message(STATUS "[openssl] set OPENSSL_EXISTS is $ENV{OPENSSL_EXISTS}.")

        ExternalProject_Add(
            libopenssl
            URL "https://www.openssl.org/source/openssl-1.1.1k.tar.gz"
            URL_HASH "SHA256=892a0875b9872acd04a9fde79b1f943075d5ea162415de3047c327df33fbaee5"
            CONFIGURE_COMMAND ./config --prefix=${LIBOPENSSL_PREFIX_DIR} no-asm CFLAGS=-fPIC CPPFLAGS=-fPIC
            BUILD_COMMAND ${CMD_MAKE}
            BUILD_IN_SOURCE 1
            BUILD_BYPRODUCTS ${LIBOPENSSL_LIB}
            INSTALL_COMMAND ${CMD_MAKE} install
            UPDATE_COMMAND ""
            )
    endif($ENV{OPENSSL_EXISTS})
endif (UNIX)
