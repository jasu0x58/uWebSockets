cmake_minimum_required(VERSION 3.10)

project(uWebSockets LANGUAGES CXX)

#########################################################
# define global build options
#########################################################
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

#########################################################
# super build options
#########################################################
option(SUPER_BUILD "Build all dependencies" ON)
if(SUPER_BUILD)
    set_directory_properties(PROPERTIES EP_BASE ${CMAKE_BINARY_DIR}/prefix)
    if(NOT EP_USE_CMAKE_INSTALL_PREFIX)
        if(NOT EP_INSTALL_PREFIX)
            set(EP_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/externals)
        endif()
    else()
        set(EP_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX})
    endif()
    project(super_build)
    include(cmake/super_build.cmake)
    return()
endif()

#########################################################
# project setup
#########################################################
project(uWebSockets VERSION 0.14.5 LANGUAGES CXX)

########################################################
#define global options
########################################################
set(CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH} ${PROJECT_SOURCE_DIR}/cmake)
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

add_subdirectory(src)

install(EXPORT uWebSocketTargets
    FILE uWebSocketsTargets.cmake
    NAMESPACE uWS::
    DESTINATION share/cmake/uWebSockets)
install(EXPORT uWebSocketTargets
    FILE uWebSocketsTargets.cmake
    NAMESPACE uWS::
    DESTINATION share/cmake/uWebSockets)
include(CMakePackageConfigHelpers)
write_basic_package_version_file(${CMAKE_CURRENT_BINARY_DIR}/uWebSocketsConfigVersion.cmake
    COMPATIBILITY SameMajorVersion)
install(
    FILES uWebSocketsConfig.cmake 
        ${CMAKE_CURRENT_BINARY_DIR}/uWebSocketsConfigVersion.cmake
        ${PROJECT_SOURCE_DIR}/cmake/FindLibUV.cmake
    DESTINATION share/cmake/uWebSockets)

