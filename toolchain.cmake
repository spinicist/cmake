include(CheckCXXCompilerFlag)
include(CMakeToolsHelpers OPTIONAL)
include(CMakePrintHelpers)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_LIST_DIR})

if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE
    STRING "Choose the build mode." FORCE)
endif()
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS Debug Release RelWithDebInfo)

find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CCACHE_PROGRAM}")
endif()

set(FLAGS_FILE "base" CACHE STRING "Which flags file to include")
set(ENV{FLAGS_FILE} ${FLAGS_FILE})
include("${CMAKE_CURRENT_LIST_DIR}/flags/${FLAGS_FILE}.cmake")
set(VCPKG_OVERLAY_TRIPLETS "${CMAKE_CURRENT_LIST_DIR}/triplets")
set(VCPKG_OVERLAY_PORTS "${CMAKE_CURRENT_LIST_DIR}/ports")
include(${CMAKE_CURRENT_LIST_DIR}/vcpkg/scripts/buildsystems/vcpkg.cmake)

set(CMAKE_C_FLAGS_INIT ${MY_FLAGS})
set(CMAKE_CXX_FLAGS_INIT ${MY_FLAGS})
set(CMAKE_C_FLAGS_DEBUG_INIT ${MY_FLAGS_DEBUG})
set(CMAKE_CXX_FLAGS_DEBUG_INIT ${MY_FLAGS_DEBUG})

if(LINUX)
    set(CMAKE_EXE_LINKER_FLAGS_INIT "-static-libgcc -static-libstdc++")
endif()

# Deal with GCC 8 and std::filesystem
# Thanks to Deniz Bahadir on the CMake Discourse
add_link_options("$<$<CXX_COMPILER_ID:GNU>:LINKER:--as-needed>")
link_libraries("$<$<AND:$<CXX_COMPILER_ID:GNU>,$<VERSION_LESS:$<CXX_COMPILER_VERSION>,9.0>>:-lstdc++fs>")
