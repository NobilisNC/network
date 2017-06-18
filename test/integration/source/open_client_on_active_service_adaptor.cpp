//System Includes
#include <string>
#include <memory>
#include <system_error>

//Project Includes
#include "corvusoft/network/tcpip_adaptor.hpp"

//External Includes
#include <catch.hpp>
#include <corvusoft/core/byte.hpp>
#include <corvusoft/core/run_loop.hpp>
#include <corvusoft/core/settings.hpp>

//System Namespaces
using std::string;
using std::error_code;
using std::shared_ptr;
using std::make_shared;

//Project Namespaces
using corvusoft::network::Adaptor;
using corvusoft::network::TCPIPAdaptor;

//External Namespaces
using corvusoft::core::Bytes;
using corvusoft::core::RunLoop;
using corvusoft::core::Settings;
using corvusoft::core::make_bytes;

TEST_CASE( "Open client on active service adaptor." )
{
    auto settings = make_shared< Settings >( );
    
    auto server = TCPIPAdaptor::create( );
    server->set_open_handler( [ settings ]( const shared_ptr< Adaptor > adaptor )
    {
        auto status = adaptor->open( settings );
        REQUIRE( status == std::errc::already_connected );
        
        adaptor->get_runloop( )->stop( );
    } );
    
    server->set_message_handler( [ ]( const shared_ptr< Adaptor > )
    {
        FAIL( "Recieved unexpected message handler invocation." );
    } );
    server->set_error_handler( [ ]( const shared_ptr< Adaptor >, const error_code code )
    {
        FAIL( "Recieved unexpected error handler invocation: " + code.message( ) );
    } );
    
    const auto status = server->listen( settings );
    REQUIRE( status == error_code( ) );
    
    auto runloop = server->get_runloop( );
    runloop->start( );
}
