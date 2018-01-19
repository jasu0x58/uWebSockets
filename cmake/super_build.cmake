include(ExternalProject)

#########################################################
# define helper
#########################################################
function(add_dependency dep_var)
    unset(_dep_var)
    foreach(dependency ${ARGN})
        include(cmake/ep/${dependency}.cmake)
        list(APPEND _dep_var ep_${dependency})
    endforeach()
	set(${dep_var} ${_dep_var} PARENT_SCOPE)
endfunction()

function(add_common_cmake_args args)
	set(${args} 
		${${args}} 
		-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} 
		-DCMAKE_PREFIX_PATH=${EP_INSTALL_PREFIX} 
		-DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> 
		PARENT_SCOPE)
endfunction()
set(MAKE_COMMAND make -j4)

add_dependency(dependencies openssl libuv zlib)
add_common_cmake_args(cmake_args)
set(cmake_args ${cmake_args} -DSUPER_BUILD=OFF)
ExternalProject_Add(ep_uwebsockets
    DEPENDS ${dependencies}
    SOURCE_DIR ${PROJECT_SOURCE_DIR}
    BINARY_DIR ${CMAKE_BINARY_DIR}/uwebsockets
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${cmake_args}
    BUILD_ALWAYS 1
    INSTALL_COMMAND ""
)

install(SCRIPT ${CMAKE_BINARY_DIR}/uwebsockets/cmake_install.cmake)
