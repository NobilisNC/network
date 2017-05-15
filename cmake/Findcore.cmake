find_library( core_STATIC_LIBRARY libcore.a HINTS "${CMAKE_SOURCE_DIR}/dependency/core/distribution/library" )
find_library( core_SHARED_LIBRARY NAMES libcore.so libcore.dylib HINTS "${CMAKE_SOURCE_DIR}/dependency/core/distribution/library" )
find_path( core_INCLUDE "corvusoft/core/settings.hpp"  HINTS "${CMAKE_SOURCE_DIR}/dependency/core/distribution/include" )

if ( core_INCLUDE AND core_STATIC_LIBRARY AND core_SHARED_LIBRARY )
    set( CORE_FOUND TRUE )
    message( STATUS "Located Core include at: ${core_INCLUDE}" )
    message( STATUS "Located Core static library at: ${core_STATIC_LIBRARY}" )
    message( STATUS "Located Core shared library at: ${core_SHARED_LIBRARY}" )
else ( )
    message( FATAL_ERROR "Failed to locate Core dependency, try again after performing: mkdir dependency/core/build; cd dependency/core/build; cmake ..; make install" )
endif ( )