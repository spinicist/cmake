vcpkg_download_distfile(ARCHIVE
    URLS "http://www.fftw.org/fftw-3.3.9.tar.gz"
    FILENAME "fftw-3.3.9.tar.gz"
    SHA512 52ebc2a33063a41fd478f6ea2acbf3b511867f736591d273dd57f9dfca5d3e0b0c73157921b3a36f1a7cfd741a8a6bde0fd80de578040ae730ea168b5ba466cf
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    PATCHES
        omp_test.patch
        patch_targets.patch
        fftw3_arch_fix.patch
        aligned_malloc.patch
)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    openmp ENABLE_OPENMP
    threads ENABLE_THREADS
    threads WITH_COMBINED_THREADS
    avx2 ENABLE_AVX2
    avx ENABLE_AVX
    sse2 ENABLE_SSE2
    sse ENABLE_SSE
)

set(ENABLE_FLOAT_CMAKE fftw3f)
set(ENABLE_LONG_DOUBLE_CMAKE fftw3l)
set(ENABLE_DEFAULT_PRECISION_CMAKE fftw3)

foreach(PRECISION ENABLE_FLOAT ENABLE_LONG_DOUBLE ENABLE_DEFAULT_PRECISION)
    if(PRECISION STREQUAL "ENABLE_LONG_DOUBLE")
        vcpkg_configure_cmake(
        SOURCE_PATH ${SOURCE_PATH}
        PREFER_NINJA
        OPTIONS 
            -D${PRECISION}=ON
            -DENABLE_OPENMP=${ENABLE_OPENMP}
            -DENABLE_THREADS=${HAVE_THREADS}
            -DWITH_COMBINED_THREADS=${HAVE_THREADS}
            -DBUILD_TESTS=OFF
        )
    else()
        vcpkg_configure_cmake(
        SOURCE_PATH ${SOURCE_PATH}
        PREFER_NINJA
        OPTIONS 
            -D${PRECISION}=ON
            ${FEATURE_OPTIONS}
            -DBUILD_TESTS=OFF
        )
    endif()

    vcpkg_install_cmake()

    vcpkg_copy_pdbs()

    vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake TARGET_PATH share/${${PRECISION}_CMAKE})
endforeach()

file(READ ${SOURCE_PATH}/api/fftw3.h _contents)
if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    string(REPLACE "defined(FFTW_DLL)" "0" _contents "${_contents}")
else()
    string(REPLACE "defined(FFTW_DLL)" "1" _contents "${_contents}")
endif()
file(WRITE ${SOURCE_PATH}/include/fftw3.h "${_contents}")

# Cleanup
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

# Handle copyright
file(COPY ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/fftw3)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/fftw3/COPYING ${CURRENT_PACKAGES_DIR}/share/fftw3/copyright)
