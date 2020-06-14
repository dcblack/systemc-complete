#!cmake .
#FILE: CMakeLists.txt
# This works with SystemV versions 2.3.2 and later, which have support for
# cmake and specify SystemC_CXX_STANDARD.
# 
# REQUIREMENTS:
#   Define SYSTEMC_HOME to point to install directory of SystemC (not source)

cmake_minimum_required(VERSION 3.11)
set(TARGET_EXECUTABLE $<TARGET_FILE_NAME:trivial.exe>)
project(trivial CXX)

include( /apps/cmake/BuildTypes.cmake )
include( /apps/cmake/SystemC.cmake )
include( /apps/cmake/strict.cmake )

add_compile_definitions(SC_INCLUDE_FX SC_INCLUDE_DYNAMIC_PROCESSES)

add_executable(trivial.exe
  trivial.cpp
  main.cpp
)
