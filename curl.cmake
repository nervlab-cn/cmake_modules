# author zouxiaoliang
# date: 20210607

if (UNIX)
    set (LIBCURL_PREFIX_DIR "$ENV{HOME}/.nervlab/curl7_77_0-prefix")
    message (STATUS "Using bundled LIBCURL in ${LIBCURL_SRC}")

    set(LIBCURL_LIB "${LIBCURL_PREFIX_DIR}/lib/libcurl.a")
    set(LIBCURL_INCLUDE "${LIBCURL_PREFIX_DIR}/include")

    if (NOT CMD_MAKE)
        message(STATUS "[curl] set CMD_MAKE is make.")
        set(CMD_MAKE make)
    endif()

    message(STATUS "[curl] add external project: curl")

    # 依赖库 https://curl.se/docs/libs.html
    ExternalProject_Add(
        curl
        DEPENDS openssl
        URL "https://github.com/curl/curl/releases/download/curl-7_77_0/curl-7.77.0.tar.gz"
        URL_HASH "SHA256=b0a3428acb60fa59044c4d0baae4e4fc09ae9af1d8a3aa84b2e3fbcd99841f77"
        CONFIGURE_COMMAND ./configure --prefix=${LIBCURL_PREFIX_DIR} --without-librtmp --without-libidn2 --without-zstd --without-brotli --without-nghttp2 --without-nghttp3 --without-ldap-lib --with-openssl=${LIBOPENSSL_PREFIX_DIR} CFLAGS=-fPIC CPPFLAGS=-fPIC
        BUILD_COMMAND ${CMD_MAKE}
        BUILD_IN_SOURCE 1
        BUILD_BYPRODUCTS ${LIBCURL_LIB}
        INSTALL_COMMAND ${CMD_MAKE} install
        UPDATE_COMMAND ""
        )

endif (UNIX)

