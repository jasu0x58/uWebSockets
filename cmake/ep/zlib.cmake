if(CMAKE_BUILD_TYPE MATCHES "Debug")
    set(zlib_build_type --debug)
endif()

ExternalProject_Add(ep_zlib
    GIT_REPOSITORY https://github.com/madler/zlib
    GIT_TAG v1.2.11
    UPDATE_COMMAND ""
    INSTALL_DIR ${EP_INSTALL_PREFIX}
    BUILD_IN_SOURCE 1    
    CONFIGURE_COMMAND ./configure ${zlib_build_type} --static --prefix=<INSTALL_DIR>
    BUILD_COMMAND ${MAKE_COMMAND}
    INSTALL_COMMAND ${MAKE_COMMAND} install
)
