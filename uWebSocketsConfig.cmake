include(CMakeFindDependencyMacro)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})
find_dependency(OpenSSL 1.1.0)
find_dependency(ZLIB 1.2.11)
find_dependency(LibUV 1.18.0)
include(${CMAKE_CURRENT_LIST_DIR}/uWebSocketsTargets.cmake)
