cmake_minimum_required(VERSION 3.29)
project(sample)
set(CMAKE_INSTALL_PREFIX ${PROJECT_SOURCE_DIR}/INSTALL/${CMAKE_BUILD_TYPE})
if(MSVC)
    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS TRUE)
endif()
set(CMAKE_CXX_STANDARD 23)
include_directories(${CMAKE_SOURCE_DIR}/include)
add_library(sample SHARED src/library.cpp)
install(TARGETS sample RUNTIME_DEPENDENCY_SET APP_DEPS RUNTIME DESTINATION bin ARCHIVE DESTINATION lib LIBRARY DESTINATION lib)

add_executable(test_sample tests/test.cpp)
target_link_libraries(test_sample sample)
install(TARGETS test_sample RUNTIME_DEPENDENCY_SET APP_DEPS RUNTIME DESTINATION bin ARCHIVE DESTINATION lib LIBRARY DESTINATION lib)

list(APPEND NON_DISTRIBUTABLES_PRE
    [[api-ms-win-.*]]
    [[ext-ms-.*]]
    [[kernel32\.dll]]
    [[.*/system32/.*\.dll]]
    [[libc\.so\..*]]
    [[libm\.so\..*]]
    [[librt\.so\..*]]
    [[libdl\.so\..*]]
    [[libpthread\.so\..*]]
    [[^/lib.*]]
    [[^ld-linux.*]]
    [[^/lib64.*]]
    [[^/usr/lib.*]]
    [[^/usr/lib64.*]]
)
list(APPEND NON_DISTRIBUTABLES_POST
    [[.*/system32/.*\.dll]]
)
install(RUNTIME_DEPENDENCY_SET APP_DEPS PRE_EXCLUDE_REGEXES ${NON_DISTRIBUTABLES_PRE} POST_EXCLUDE_REGEXES ${NON_DISTRIBUTABLES_POST})