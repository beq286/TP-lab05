# CMake generated Testfile for 
# Source directory: /home/zarok/projects/tp_labs/tp_projects/lab05/lab05
# Build directory: /home/zarok/projects/tp_labs/tp_projects/lab05/lab05/_build
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test([=[check]=] "/home/zarok/projects/tp_labs/tp_projects/lab05/lab05/_build/check")
set_tests_properties([=[check]=] PROPERTIES  _BACKTRACE_TRIPLES "/home/zarok/projects/tp_labs/tp_projects/lab05/lab05/CMakeLists.txt;26;add_test;/home/zarok/projects/tp_labs/tp_projects/lab05/lab05/CMakeLists.txt;0;")
subdirs("third-party/gtest")
