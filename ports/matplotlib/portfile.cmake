set(VCPKG_BUILD_TYPE release) # Python package; no debug build needed

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO matplotlib/matplotlib
    REF "v${VERSION}"
    SHA512 a28b8f2b3ce4f70469a237d81cfc84f87fbb5a26074febb9b453d72792efb7da567e99ddba17de83c223a51e3524143d42f62131118da73c77d7e9146713ef20
    HEAD_REF main
)

vcpkg_find_acquire_program(PYTHON3)

vcpkg_execute_required_process(
    COMMAND "${PYTHON3}" -m pip install
        --no-compile
        --prefix "${CURRENT_PACKAGES_DIR}"
        "${SOURCE_PATH}"
    WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}"
    LOGNAME "pip-install-${TARGET_TRIPLET}"
)

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE/LICENSE")
