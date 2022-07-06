vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO spinicist/fftw3
    REF 262f5cfe23af54930b119bd3653bc25bf2d881da
    SHA512 8ea0cabf24b5012b7129662891f184631360403786a16776926ba2e6a2a7b7ff57c46bab1409a7efa3475844b5eb4df32451b519eeadca31613cf5ca1f0a3c2b
    PATCHES
        patch_targets.patch
        fftw3_arch_fix.patch
        aligned_malloc.patch
)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        openmp ENABLE_OPENMP
        threads ENABLE_THREADS
        threads WITH_COMBINED_THREADS
        avx2 ENABLE_AVX2
        avx ENABLE_AVX
        sse2 ENABLE_SSE2
        sse ENABLE_SSE
        neon ENABLE_NEON
)

set(ENABLE_FLOAT_CMAKE fftw3f)
set(ENABLE_LONG_DOUBLE_CMAKE fftw3l)
set(ENABLE_DEFAULT_PRECISION_CMAKE fftw3)

foreach(PRECISION ENABLE_FLOAT ENABLE_LONG_DOUBLE ENABLE_DEFAULT_PRECISION)
    if(PRECISION STREQUAL "ENABLE_LONG_DOUBLE")
        vcpkg_cmake_configure(
        SOURCE_PATH "${SOURCE_PATH}"
        OPTIONS 
            -D${PRECISION}=ON
            -DENABLE_OPENMP=${ENABLE_OPENMP}
            -DENABLE_THREADS=${HAVE_THREADS}
            -DWITH_COMBINED_THREADS=${HAVE_THREADS}
            -DBUILD_TESTS=OFF
        )
    else()
        vcpkg_cmake_configure(
        SOURCE_PATH "${SOURCE_PATH}"
        OPTIONS 
            -D${PRECISION}=ON
            ${FEATURE_OPTIONS}
            -DBUILD_TESTS=OFF
        )
    endif()

    vcpkg_cmake_install()

    vcpkg_copy_pdbs()

    vcpkg_cmake_config_fixup(PACKAGE_NAME ${${PRECISION}_CMAKE} CONFIG_PATH lib/cmake)
endforeach()

file(READ "${SOURCE_PATH}/api/fftw3.h" _contents)
if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    string(REPLACE "defined(FFTW_DLL)" "0" _contents "${_contents}")
else()
    string(REPLACE "defined(FFTW_DLL)" "1" _contents "${_contents}")
endif()
file(WRITE "${SOURCE_PATH}/include/fftw3.h" "${_contents}")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

vcpkg_fixup_pkgconfig()
