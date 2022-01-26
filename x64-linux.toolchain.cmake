include_guard(GLOBAL)

set(CMAKE_EXE_LINKER_FLAGS "-static-libgcc -static-libstdc++" CACHE INTERNAL "" FORCE)
set(VCPKG_TARGET_TRIPLET "x64-linux")
set(VCPKG_HOST_TRIPLET "x64-linux")
include("${CMAKE_CURRENT_LIST_DIR}/flags.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/toolchain.cmake")
