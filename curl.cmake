# author zouxiaoliang
# date: 20210607

if (UNIX)

    if (NOT CMD_MAKE)
        message(STATUS "[curl] set CMD_MAKE is make.")
        set(CMD_MAKE make)
    endif()

    set (LIBCURL_PREFIX_DIR "$ENV{HOME}/.nervlab/curl7_77_0-prefix")
    message (STATUS "Using bundled LIBCURL in ${LIBCURL_SRC}")

    set(LIBCURL_LIB "${LIBCURL_PREFIX_DIR}/lib/libcurl.a")
    set(LIBCURL_INCLUDE "${LIBCURL_PREFIX_DIR}/include")
    ExternalProject_Add(
      libcurl
      DEPENDS libopenssl
      URL "https://github.com/curl/curl/releases/download/curl-7_77_0/curl-7.77.0.tar.gz"
      URL_HASH "SHA256=b0a3428acb60fa59044c4d0baae4e4fc09ae9af1d8a3aa84b2e3fbcd99841f77"
      CONFIGURE_COMMAND ./configure --prefix=${LIBCURL_PREFIX_DIR} --with-openssl=${LIBOPENSSL_PREFIX_DIR} CFLAGS=-fPIC CPPFLAGS=-fPIC
      BUILD_COMMAND ${CMD_MAKE}
      BUILD_IN_SOURCE 1
      BUILD_BYPRODUCTS ${LIBCURL_LIB}
      INSTALL_COMMAND ${CMD_MAKE} install
      UPDATE_COMMAND ""
    )

endif (UNIX)

