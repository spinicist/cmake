set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE static)
set(VCPKG_CMAKE_SYSTEM_NAME Darwin)
set(VCPKG_OSX_ARCHITECTURES x86_64)
set(VCPKG_BUILD_TYPE release)

include("${CMAKE_CURRENT_LIST_DIR}/../flags/$ENV{FLAGS_FILE}.cmake")
set(VCPKG_C_FLAGS ${MY_FLAGS})
set(VCPKG_CXX_FLAGS ${MY_FLAGS})
