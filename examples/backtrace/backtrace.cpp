#include "backtrace.hpp"
#include <iostream>
#include <iomanip>
#include <fstream>
#include <vector>
#include <string>
#include <unistd.h>

using namespace std::literals;

void backtrace(int argc, const char* argv[])
{
  if( argc > 1 and std::string(argv[1]) == "-backtrace" ) {

    // Construct gdb set args command with remaining arguments
    std::string run = "run";
    for( int i=2; i<argc; ++i ) {
      std::string arg{argv[i]};
      // Is quoting needed due to internal white-space or single quotes?
      using Str=std::string;
      if( arg.find_first_of('"') != Str::npos ) {
        // Escape all double quotes
        size_t pos = 0;
        while( (pos=arg.find_first_of('"',pos)) != Str::npos ) {
          arg.replace( pos, 1, "\\\"" );
          pos += 2;
        }
      }
      run += " \""s + arg + "\""s;
    }
    std::cout << "DEBUG: {" << run << "}" << std::endl;

    // Create gdb gdb options
    const char* new_argv[] =
    { "gdb"
    , "-batch"
    , "-ex",   run.c_str()
    , "-ex",   "backtrace"
    , "-ex",   "quit"
    , argv[0]
    , nullptr
    };

    // Run the simulation under gdb
    int status_code = execvp( "gdb", reinterpret_cast<char*const*>(&new_argv) );
    if (status_code == -1) {
      std::cout
        << "exec failed"
        << " on line " << __LINE__ << " of " << __FILE__
        << "\n"
        ;
      exit(1);
    }
    std::cout << "This line will not be printed if execvp() runs correctly\n";
    exit(1);
  }
  std::cout << "Running " << argv[0];
  if ( argc == 1 ) std::cout << " with no arguments.\n";
  else             std::cout << " with arguments:\n";
  for( int i=1; i<argc; ++i ) {
    std::string arg(argv[i]);
    std::cout << "  " << std::setw(2) << i << ": {" << arg << "}" << std::endl;
  }
  std::cout << std::string(80,'-') << std::endl;
}
