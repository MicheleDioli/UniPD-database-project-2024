cmake_minimum_required(VERSION 3.10)

project(Database C)

include_directories(${CMAKE_SOURCE_DIR}/libpq/include)
link_directories(${CMAKE_SOURCE_DIR}/libpq/lib)

set(SOURCE_FILES
    main.c
    funzioni.c
)

add_executable(database ${SOURCE_FILES})

target_link_libraries(database PRIVATE pq)