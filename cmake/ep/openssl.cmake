ExternalProject_Add(ep_openssl
    GIT_REPOSITORY https://github.com/openssl/openssl
    GIT_TAG OpenSSL_1_1_0g
    UPDATE_COMMAND ""
    INSTALL_DIR ${EP_INSTALL_PREFIX}
    BUILD_IN_SOURCE 1    
    CONFIGURE_COMMAND ./config --prefix=<INSTALL_DIR> $<$<CONFIG:Debug>:-d> no-shared $<$<CONFIG:RelWithDebInfo>:-g>
    BUILD_COMMAND ${MAKE_COMMAND}
    INSTALL_COMMAND ${MAKE_COMMAND} install_sw
)
