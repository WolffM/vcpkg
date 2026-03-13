vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO matplotlib/matplotlib
    REF "v${VERSION}"
    SHA512 a28b8f2b3ce4f70469a237d81cfc84f87fbb5a26074febb9b453d72792efb7da567e99ddba17de83c223a51e3524143d42f62131118da73c77d7e9146713ef20
    HEAD_REF main
)

set(VCPKG_BUILD_TYPE release)

vcpkg_find_acquire_program(PYTHON3)

include("${CURRENT_INSTALLED_DIR}/share/python3/vcpkg-port-config.cmake")

x_vcpkg_get_python_packages(
    PYTHON_VERSION "3"
    PYTHON_EXECUTABLE "${PYTHON3}"
    PACKAGES
        "meson-python>=0.13.1"
        "meson>=1.1.0"
        "pybind11>=2.13.2,!=2.13.3"
        "setuptools_scm"
        "numpy>=1.23"
    OUT_PYTHON_VAR PYTHON3_ENV
)

vcpkg_execute_required_process(
    COMMAND "${PYTHON3_ENV}" -I -m pip install
        --no-build-isolation
        --no-deps
        "${SOURCE_PATH}"
        "--prefix=${CURRENT_PACKAGES_DIR}"
    WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}"
    LOGNAME "pip-install-${TARGET_TRIPLET}"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE/LICENSE")
