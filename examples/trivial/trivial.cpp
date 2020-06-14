//FILE: trivial.cpp
#include "trivial.hpp"

using namespace sc_core;

Trivial_module::Trivial_module( sc_core::sc_module_name instance )
: sc_module( instance )
{
  SC_REPORT_INFO( "/Doulos/trivial", "Constructing Trivial_module" );
  SC_HAS_PROCESS( Trivial_module );
  SC_THREAD( main_thread );
}

void Trivial_module::main_thread( void )
{
  SC_REPORT_INFO( "/Doulos/trivial", "Starting main_thread" );
  wait( 10, SC_NS );
  SC_REPORT_WARNING( "/Doulos/trivial", "Stopping main_thread" );
  sc_stop();
}
