include(CheckCXXCompilerFlag)
include(CMakeToolsHelpers OPTIONAL)
include(CMakePrintHelpers)
include(${CMAKE_CURRENT_LIST_DIR}/BuildType.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/ccache.cmake)

set(FLAGS_FILE "base" CACHE STRING "Which flags file to include")
set(ENV{FLAGS_FILE} ${FLAGS_FILE})

set(VCPKG_C_FLAGS ${MY_FLAGS})
set(VCPKG_CXX_FLAGS ${MY_FLAGS})
set(VCPKG_OVERLAY_TRIPLETS "${CMAKE_CURRENT_LIST_DIR}/triplets")
set(VCPKG_OVERLAY_PORTS "${CMAKE_CURRENT_LIST_DIR}/ports")
include(${CMAKE_CURRENT_LIST_DIR}/vcpkg/scripts/buildsystems/vcpkg.cmake)

include("${CMAKE_CURRENT_LIST_DIR}/flags/${FLAGS_FILE}.cmake")

set(CMAKE_C_FLAGS_INIT ${MY_FLAGS})
set(CMAKE_CXX_FLAGS_INIT ${MY_FLAGS})
set(CMAKE_C_FLAGS_DEBUG_INIT ${MY_FLAGS_DEBUG})
set(CMAKE_CXX_FLAGS_DEBUG_INIT ${MY_FLAGS_DEBUG})
