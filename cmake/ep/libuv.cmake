if(CMAKE_BUILD_TYPE MATCHES "Debug")
    set(libuv_build_type Debug)
else()
    set(libuv_build_type Release)
endif()

unset(libuv_flags)
if(CMAKE_BUILD_TYPE MATCHES "RelWithDebInfo")
    set(libuv_flags -g)
endif()

ExternalProject_Add(ep_libuv
    GIT_REPOSITORY https://github.com/libuv/libuv
    GIT_TAG v1.18.0
    UPDATE_COMMAND ""
    INSTALL_DIR ${EP_INSTALL_PREFIX}
    BUILD_IN_SOURCE 1    
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E remove_directory build/gyp 
        COMMAND git clone https://chromium.googlesource.com/external/gyp build/gyp 
        COMMAND ./gyp_uv.py -f make
    BUILD_COMMAND CFLAGS=${libuv_flags} CXXFLAGS=${libuv_flags} BUILDTYPE=${libuv_build_type} ${MAKE_COMMAND} -C out
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/include <INSTALL_DIR>/include 
		COMMAND ${CMAKE_COMMAND} -E make_directory <INSTALL_DIR>/lib
		COMMAND ${CMAKE_COMMAND} -E copy_if_different <SOURCE_DIR>/out/${libuv_build_type}/libuv.a <INSTALL_DIR>/lib/
)
