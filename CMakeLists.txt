# Copyright 2013 Dario Lombardo <lomato@gmail.com>
#
#
# You should have received a copy of the GNU General Public License
# along with GNU Radio; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.
#

########################################################################
# Project setup
########################################################################
cmake_minimum_required(VERSION 2.6)
project(hcrt-dissector C)
set(hcrt-dissector_VERSION_MAJOR 0)
set(hcrt-dissector_VERSION_MINOR 1)
enable_testing()

#select the release build type by default to get optimization flags
if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE "Release")
   message(STATUS "Build type not specified: defaulting to release.")
endif(NOT CMAKE_BUILD_TYPE)
set(CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE} CACHE STRING "")

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules)

########################################################################
# Compiler specific setup
########################################################################
#if(CMAKE_COMPILER_IS_GNUC AND NOT WIN32)
#    #http://gcc.gnu.org/wiki/Visibility
#    add_definitions(-fvisibility=visible)
#endif()

find_package(GLIB2)
if(NOT GLIB2_FOUND)
    message(FATAL_ERROR "Glib not found")
endif()

find_package(Wireshark)
if(NOT WIRESHARK_FOUND)
    message(FATAL_ERROR "Wireshark dev package not found")
endif()

########################################################################
# Setup the include and linker paths
########################################################################
include_directories(
    ${CMAKE_SOURCE_DIR}
    ${GLIB2_INCLUDE_DIRS}
    ${WIRESHARK_INCLUDE_DIRS}
)

set(CMAKE_INSTALL_LIBDIR ~/.wireshark)

# Set component parameters
set(HCRT_DISSECTOR_INCLUDE_DIRS ${CMAKE_SOURCE_DIR} CACHE INTERNAL "" FORCE)

set(HCRT_PLUGIN_SRC ${CMAKE_SOURCE_DIR}/packet-hcrt.c)

set(PLUGIN_C_GENERATOR ${CMAKE_SOURCE_DIR}/make-dissector-reg.py)
set(PLUGIN_C plugin.c)

add_custom_command(
        OUTPUT ${PLUGIN_C}
        DEPENDS ${HCRT_PLUGIN_SRC}
        COMMAND ${PLUGIN_C_GENERATOR} ${CMAKE_SOURCE_DIR} plugin ${HCRT_PLUGIN_SRC}
        COMMENT "Generating ${PLUGIN_C}"
)

add_library(hcrt-plugin MODULE
    ${PLUGIN_C}
    moduleinfo.h
    ${HCRT_PLUGIN_SRC}
)
set_target_properties(hcrt-plugin PROPERTIES PREFIX "")
set_target_properties(hcrt-plugin PROPERTIES LINK_FLAGS "${WS_LINK_FLAGS}")
target_link_libraries(hcrt-plugin wireshark)

install(TARGETS hcrt-plugin
	LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/plugins NAMELINK_SKIP
)
