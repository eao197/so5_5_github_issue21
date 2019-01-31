cmake_minimum_required(VERSION 3.13)
project(Experimen-1)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


add_executable(experiment_1
  main.cpp
)

set(DEP_DIR "/home/eao197/sandboxes/so5_5_github_issue_21/deps/")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")

SET (sobjectizer_DIR "${DEP_DIR}lib/cmake/sobjectizer" )
find_package( sobjectizer REQUIRED )

target_include_directories( experiment_1 BEFORE PRIVATE "${DEP_DIR}/include" )
target_link_libraries( experiment_1 PRIVATE  sobjectizer::SharedLib )
