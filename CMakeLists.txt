cmake_minimum_required(VERSION 3.20)
project(ass3 C ASM)

set(CMAKE_C_STANDARD 99)

set(GCC_COVERAGE_COMPILE_FLAGS "-no-pie")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${GCC_COVERAGE_COMPILE_FLAGS}")
#add_executable(ass3 main.c run_main.s)
add_executable(ass3 pstring.s func_select.s main.c run_main.s)#run_main-test.c
#add_executable(ass3 main.c)
