find_package(OpenSSL 1.1.0 REQUIRED)
find_package(ZLIB 1.2.11 REQUIRED)
find_package(LibUV 1.18.0 REQUIRED)

add_library(uWS 
    Extensions.cpp 
    Group.cpp 
    Networking.cpp 
    Hub.cpp 
    Node.cpp 
    WebSocket.cpp 
    HTTPSocket.cpp
    Socket.cpp 
    Epoll.cpp)

set(public_header 
    uWS.h
    Asio.h
    Backend.h
    Extensions.h
    Group.h
    Networking.h 
    Hub.h
    Libuv.h
    Node.h 
    WebSocket.h 
    WebSocketProtocol.h
    HTTPSocket.h
    Socket.h 
    Epoll.h)

set_target_properties(uWS PROPERTIES PUBLIC_HEADER "${public_header}")
target_compile_definitions(uWS PUBLIC -DUSE_LIBUV)
target_link_libraries(uWS PUBLIC LibUV::LibUV OpenSSL::SSL ZLIB::ZLIB)

install(TARGETS uWS EXPORT uWebSocketTargets
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin
    PUBLIC_HEADER DESTINATION include/uWS)
