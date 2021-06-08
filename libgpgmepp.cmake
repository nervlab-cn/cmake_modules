# author zouxiaoliang

set (LIBGPGME_SRC "")
set (LIBGPGME_INSTALL_DIR "")
message (STATUS "Using bundled libgpgme in ${LIBGPGME_SRC}")

set(LIBGPGME_LIB "${LIBGPGME_INSTALL_DIR}/lib/libgpgme.a")
set(LIBGPGME_INCLUDE "${LIBGPGME_INSTALL_DIR}/include")

ExternalProject_Add(
  libgpgme
  URL "https://github.com/yaml/libyaml/releases/download/0.2.5/yaml-0.2.5.tar.gz"
  URL_HASH "SHA256=1b29fedb8bfad775e70eafac5b0590621683b2d9869db994568e6401f4034ceb"
  CONFIGURE_COMMAND ./configure --prefix=${LIBGPGME_INSTALL_DIR} CFLAGS=-fPIC CPPFLAGS=-fPIC --enable-static=true --enable-shared=false
  BUILD_COMMAND ${CMD_MAKE}
  BUILD_IN_SOURCE 1
  BUILD_BYPRODUCTS ${LIBGPGME_LIB}
  INSTALL_COMMAND ${CMD_MAKE} install
  UPDATE_COMMAND ""
)
