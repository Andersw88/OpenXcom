
# Conan
set(CONAN_CMAKE_VERSION "0.17.0")
set(CONAN_CMAKE_PATH "${CMAKE_BINARY_DIR}/conan${CONAN_CMAKE_VERSION}.cmake")

if(NOT EXISTS "${CONAN_CMAKE_PATH}")
    message(STATUS "Downloading conan.cmake from https://raw.githubusercontent.com/conan-io/cmake-conan/${CONAN_CMAKE_VERSION}/conan.cmake")
    file(DOWNLOAD "https://raw.githubusercontent.com/conan-io/cmake-conan/${CONAN_CMAKE_VERSION}/conan.cmake" "${CONAN_CMAKE_PATH}"
        TLS_VERIFY ON
    )
endif()

include("${CONAN_CMAKE_PATH}")

if(NOT COMPILER_VERSION)
    set(COMPILER_VERSION 17)
endif()

#These should match the conan-center packages binaries to limit the need to build (Especially for CI)
SET(COMMON_CONAN_SETTINGS "arch=x86_64;compiler=Visual Studio;compiler.version=${COMPILER_VERSION}")
if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(CONAN_SETTINGS "${COMMON_CONAN_SETTINGS};build_type=Debug;compiler.runtime=MDd")
else()
    set(CONAN_SETTINGS "${COMMON_CONAN_SETTINGS};build_type=Release;compiler.runtime=MD")
endif()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_BINARY_DIR})
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_CURRENT_BINARY_DIR})

# end Conan