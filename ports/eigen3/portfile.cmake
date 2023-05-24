vcpkg_from_gitlab(
    GITLAB_URL https://gitlab.com
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libeigen/eigen
    REF b0eded878d5d162d61583a286c0d8a45406ad1bc
    SHA512 effa431e2decd3ad5d82c83bc8adcb4f346dc0206a2b0d2ebf2e0e4aaa721697df652957b3aec99100591e35fc8dca587ebb79a1ce0b54d546b01dbc0c5a1cba
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_TESTING=OFF
        -DEIGEN_BUILD_PKGCONFIG=ON
    OPTIONS_RELEASE
        "-DCMAKEPACKAGE_INSTALL_DIR:PATH=share/eigen3"
        "-DPKGCONFIG_INSTALL_DIR:PATH=lib/pkgconfig"
    OPTIONS_DEBUG
        "-DCMAKEPACKAGE_INSTALL_DIR:PATH=debug/share/eigen3"
        "-DPKGCONFIG_INSTALL_DIR:PATH=lib/pkgconfig"
)
vcpkg_install_cmake()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/eigen3/Eigen3Targets.cmake"
    "set(_IMPORT_PREFIX " "get_filename_component(_IMPORT_PREFIX \"\${CMAKE_CURRENT_LIST_DIR}/../..\" ABSOLUTE) #"
)

vcpkg_fixup_pkgconfig()

file(GLOB INCLUDES "${CURRENT_PACKAGES_DIR}/include/eigen3/*")
file(COPY ${INCLUDES} DESTINATION "${CURRENT_PACKAGES_DIR}/include")

file(INSTALL "${SOURCE_PATH}/COPYING.README" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
configure_file("${CURRENT_PORT_DIR}/vcpkg-cmake-wrapper.cmake" "${CURRENT_PACKAGES_DIR}/share/${PORT}/vcpkg-cmake-wrapper.cmake" COPYONLY)
