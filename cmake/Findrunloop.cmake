find_library( runloop_STATIC_LIBRARY corvusoft-runloop HINTS "${PROJECT_SOURCE_DIR}/dependency/runloop/distribution/library" )
find_path( runloop_INCLUDE "corvusoft/core/run_loop.hpp" HINTS "${PROJECT_SOURCE_DIR}/dependency/runloop/distribution/include" )

if ( runloop_INCLUDE AND runloop_STATIC_LIBRARY )
    set( RUNLOOP_FOUND TRUE )
    message( STATUS "Located Runloop include at: ${runloop_INCLUDE}" )
    message( STATUS "Located Runloop static library at: ${runloop_STATIC_LIBRARY}" )
    message( STATUS "Located Runloop shared library at: ${runloop_SHARED_LIBRARY}" )
else ( )
    message( FATAL_ERROR "Failed to locate Runloop dependency, try again after performing: mkdir build; cd build; cmake ..; make install" )
endif ( )
