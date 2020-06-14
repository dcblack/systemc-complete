//FILE: main.cpp
#include "trivial.hpp"
#include <systemc>
#include "/apps/include/cppversion.hpp"
#include <iostream>

using namespace sc_core;

int sc_main( [[maybe_unused]] int argc, [[maybe_unused]] char* argv[] )
{
  std::cout << "Compiler: " << CPPVERSION_STREAM << std::endl;
  SC_REPORT_INFO( "/Doulos/trivial", "Constructing top" );
  Trivial_module top{"top"};
  SC_REPORT_INFO( "/Doulos/trivial", "Initiating simulation" );
  sc_start();
  SC_REPORT_INFO( "/Doulos/trivial", "Exiting" );
  return 0;
}
