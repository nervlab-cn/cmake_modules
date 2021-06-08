if (UNIX)
    set (CUSTOM_LOCAL_PATH $ENV{HOME}/workspace/local)
    if (CMAKE_SYSTEM_NAME MATCHES "Linux")
        find_library(KRB5 NAMES krb5)
        if (EXISTS ${KRB5})
            set(CURL_DEPEND_LIBS ${CURL_DEPEND_LIBS} ${KRB5})
        endif(EXISTS ${KRB5})

        find_library(K5CRYPTO NAMES k5crypto)
        if (EXISTS ${K5CRYPTO})
            set(CURL_DEPEND_LIBS ${CURL_DEPEND_LIBS} ${K5CRYPTO})
        endif(EXISTS ${K5CRYPTO})

        find_library(IDN NAMES idn)
        if (EXISTS ${IDN})
            set(CURL_DEPEND_LIBS ${CURL_DEPEND_LIBS} ${IDN})
        endif(EXISTS ${IDN})

        message(STATUS "curl depends: ${HTTP_DEPENDS}")
    endif()

    set(CURL_SHARED_DEPEND_LIBS ${CURL_DEPEND_LIBS} curl)
    set(CURL_STATIC_DEPEND_LIBS ${CURL_DEPEND_LIBS})

    if (EXISTS ${CUSTOM_LOCAL_PATH}/lib)
        set(CURL_INCLUDE_PATH ${CUSTOM_LOCAL_PATH}/include)
        set(CURL_LIBS_PATH ${CUSTOM_LOCAL_PATH}/lib)
        set(CURL_STATIC_LIBS ${CUSTOM_LOCAL_PATH}/lib/libcurl.a)
    else ()
        set(CURL_INCLUDE_PATH /usr/local/include)
        set(CURL_LIBS_PATH /usr/local/lib)
        set(CURL_STATIC_LIBS libcurl.a)
    endif (EXISTS ${CUSTOM_LOCAL_PATH}/lib)

    message(STATUS "curl include path: ${CURL_INCLUDE_PATH}")
    message(STATUS "curl libs path: ${CURL_LIBS_PATH}")
    message(STATUS "curl static lib: ${CURL_STATIC_DEPEND_LIBS} ${CURL_STATIC_LIBS}")

endif (UNIX)

# author zouxiaoliang
# date: 20210607

#set (LIBCURL_SRC "")
#set (LIBCURL_INSTALL_DIR "")
#message (STATUS "Using bundled LIBCURL in ${LIBCURL_SRC}")

#set(LIBCURL_LIB "${LIBCURL_INSTALL_DIR}/lib/LIBCURL.a")
#set(LIBCURL_INCLUDE "${LIBCURL_INSTALL_DIR}/include")

#ExternalProject_Add(
#  LIBCURL
#  URL "https://github.com/curl/curl/releases/download/curl-7_77_0/curl-7.77.0.tar.gz"
#  URL_HASH "SHA256=b0a3428acb60fa59044c4d0baae4e4fc09ae9af1d8a3aa84b2e3fbcd99841f77"
#  CONFIGURE_COMMAND ./configure --prefix=${LIBCURL_INSTALL_DIR} CFLAGS=-fPIC CPPFLAGS=-fPIC --enable-static=true --enable-shared=false
#  BUILD_COMMAND ${CMD_MAKE}
#  BUILD_IN_SOURCE 1
#  BUILD_BYPRODUCTS ${LIBCURL_LIB}
#  INSTALL_COMMAND ${CMD_MAKE} install
#  UPDATE_COMMAND ""
#)
