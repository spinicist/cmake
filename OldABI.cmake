set(MY_FLAGS "-march=native -Wall -D_GLIBCXX_USE_CXX11_ABI=0")
set(MY_FLAGS_DEBUG "-O2")
set(CMAKE_C_FLAGS_INIT ${MY_FLAGS})
set(CMAKE_CXX_FLAGS_INIT ${MY_FLAGS})
set(CMAKE_C_FLAGS_DEBUG_INIT ${MY_FLAGS_DEBUG})
set(CMAKE_CXX_FLAGS_DEBUG_INIT ${MY_FLAGS_DEBUG})

include(CheckCXXCompilerFlag)
include(CMakeToolsHelpers OPTIONAL)
include(CMakePrintHelpers)
include(${CMAKE_CURRENT_LIST_DIR}/BuildType.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/vcpkg/scripts/buildsystems/vcpkg.cmake)