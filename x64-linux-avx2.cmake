set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE static)
set(VCPKG_CMAKE_SYSTEM_NAME Linux)

set(CMAKE_EXE_LINKER_FLAGS "-static-libgcc -static-libstdc++" CACHE INTERNAL "" FORCE)
include("${CMAKE_CURRENT_LIST_DIR}/flags-avx2.cmake")
set(VCPKG_C_FLAGS ${MY_FLAGS})
set(VCPKG_C_FLAGS_DEBUG ${MY_FLAGS_DEBUG})
set(VCPKG_CXX_FLAGS ${MY_FLAGS})
set(VCPKG_CXX_FLAGS_DEBUG ${MY_FLAGS_DEBUG})
