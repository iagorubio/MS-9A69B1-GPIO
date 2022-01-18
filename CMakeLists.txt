cmake_minimum_required(VERSION 3.20)
project(x86GPIO_9A69B1 C ASM)

set (CMAKE_C_STANDARD 99)
set (CMAKE_C_FLAGS "-fPIE")
set (CMAKE_ASM_FLAGS "-fPIE")

add_executable(x86GPIO_9A69B1 main.c 9A69B1.h 9A69B1.s)
