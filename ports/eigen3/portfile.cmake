vcpkg_buildpath_length_warning(37)

block(SCOPE_FOR VARIABLES PROPAGATE SOURCE_PATH)
set(VCPKG_BUILD_TYPE release) # header-only

vcpkg_from_gitlab(
    GITLAB_URL https://gitlab.com
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libeigen/eigen
    REF a798d076596343b89b18e44c8033d77d22e19892
    SHA512 fa5b4566fefb8300922f7aaf309ab2a0cbe0266c77f3be8f06c76d9a8622ee0c99bc2f7673ac7b127d356986a53aceb8f56388c02a014f8d4d64b546c5d341cf
    HEAD_REF master
    PATCHES
        remove_configure_checks.patch # This removes unnecessary configure checks. Eigen3 just installs headers not anything more.
        fix-vectorized-reductions-half.patch # Remove this patch in the next update
)

# vcpkg_from_git(
#     URL file:///Users/tobias/Code/eigen
#     OUT_SOURCE_PATH SOURCE_PATH
#     REF d60ac9580d4adca784152f5c7b32e6ea5c1573e6
# )

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TESTING=OFF
        -DEIGEN_BUILD_DOC=OFF
        -DEIGEN_BUILD_PKGCONFIG=ON
        "-DCMAKEPACKAGE_INSTALL_DIR=${CURRENT_PACKAGES_DIR}/share/eigen3"
        "-DPKGCONFIG_INSTALL_DIR=${CURRENT_PACKAGES_DIR}/lib/pkgconfig"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup()
endblock()

if(NOT VCPKG_BUILD_TYPE)
    file(INSTALL "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/eigen3.pc" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig")
endif()
vcpkg_fixup_pkgconfig()

file(GLOB INCLUDES "${CURRENT_PACKAGES_DIR}/include/eigen3/*")
# Copy the eigen header files to conventional location for user-wide MSBuild integration
file(COPY ${INCLUDES} DESTINATION "${CURRENT_PACKAGES_DIR}/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING.README")
