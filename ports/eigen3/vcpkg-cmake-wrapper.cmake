_find_package(${ARGS})
if(TARGET Eigen3::Eigen)
  set_property(TARGET Eigen3::Eigen APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include")
  link_libraries(Eigen3::Eigen)
endif()
if(DEFINED EIGEN3_INCLUDE_DIR)
  set(EIGEN3_INCLUDE_DIR "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include" ${EIGEN3_INCLUDE_DIR})
endif()
if(DEFINED EIGEN3_INCLUDE_DIRS)
  set(EIGEN3_INCLUDE_DIRS "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include" ${EIGEN3_INCLUDE_DIRS})
endif()
if(DEFINED EIGEN_INCLUDE_DIR)
  set(EIGEN_INCLUDE_DIR "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include" ${EIGEN_INCLUDE_DIR})
endif()
if(DEFINED Eigen_INCLUDE_DIR)
  set(Eigen_INCLUDE_DIR "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include" ${Eigen_INCLUDE_DIR})
endif()
