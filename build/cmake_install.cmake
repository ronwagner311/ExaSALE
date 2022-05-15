# Install script for directory: /home/reemh/eclipse-workspace/Backus_test/src

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "0")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/reemh/eclipse-workspace/Backus_test/build/Parallel/cmake_install.cmake")
  include("/home/reemh/eclipse-workspace/Backus_test/build/General/cmake_install.cmake")
  include("/home/reemh/eclipse-workspace/Backus_test/build/Input/cmake_install.cmake")
  include("/home/reemh/eclipse-workspace/Backus_test/build/Boundary_conditions/cmake_install.cmake")
  include("/home/reemh/eclipse-workspace/Backus_test/build/Quantities/cmake_install.cmake")
  include("/home/reemh/eclipse-workspace/Backus_test/build/Boundary_conditions/Vertex/cmake_install.cmake")
  include("/home/reemh/eclipse-workspace/Backus_test/build/Boundary_conditions/Cell/cmake_install.cmake")
  include("/home/reemh/eclipse-workspace/Backus_test/build/Quantities/Cell/cmake_install.cmake")
  include("/home/reemh/eclipse-workspace/Backus_test/build/Quantities/Vertex/cmake_install.cmake")
  include("/home/reemh/eclipse-workspace/Backus_test/build/Mesh/cmake_install.cmake")
  include("/home/reemh/eclipse-workspace/Backus_test/build/Material/Equation_of_state/cmake_install.cmake")
  include("/home/reemh/eclipse-workspace/Backus_test/build/Material/cmake_install.cmake")
  include("/home/reemh/eclipse-workspace/Backus_test/build/Rezone_and_Advect/cmake_install.cmake")
  include("/home/reemh/eclipse-workspace/Backus_test/build/Time_step/cmake_install.cmake")
  include("/home/reemh/eclipse-workspace/Backus_test/build/Diagnostics/cmake_install.cmake")
  include("/home/reemh/eclipse-workspace/Backus_test/build/Main/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/reemh/eclipse-workspace/Backus_test/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
