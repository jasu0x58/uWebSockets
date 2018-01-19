ExternalProject_Add(ep_libuv
    GIT_REPOSITORY https://github.com/libuv/libuv
    GIT_TAG v1.18.0
    UPDATE_COMMAND ""
    INSTALL_DIR ${EP_INSTALL_PREFIX}
    BUILD_IN_SOURCE 1    
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E remove_directory build/gyp 
        COMMAND git clone https://chromium.googlesource.com/external/gyp build/gyp 
        COMMAND ./gyp_uv.py -f make
    BUILD_COMMAND BUILDTYPE=$<$<CONFIG:Release>:Release>$<$<CONFIG:Debug>:Debug> ${MAKE_COMMAND} -C out
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/include <INSTALL_DIR>/include 
		COMMAND ${CMAKE_COMMAND} -E make_directory <INSTALL_DIR>/lib	
		COMMAND ${CMAKE_COMMAND} -E copy_if_different <SOURCE_DIR>/out/${CMAKE_BUILD_TYPE}/libuv.a <INSTALL_DIR>/lib
)
