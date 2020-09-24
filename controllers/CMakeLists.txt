cmake_minimum_required(VERSION 3.5)
project(art-of-control)

find_package(Boost 1.36.0 REQUIRED)
find_package (Eigen3 3.3 REQUIRED NO_MODULE)

include_directories(
    include
)

add_executable(${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/src/main.cpp
                                ${CMAKE_SOURCE_DIR}/src/pid.cpp
                                ${CMAKE_SOURCE_DIR}/src/ramp.cpp                                
                )
target_link_libraries(${PROJECT_NAME} Eigen3::Eigen)