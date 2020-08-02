#include "backtrace.hpp"
#include <iostream>
#include <fstream>
#include <string>

void backtrace(int argc, const char* argv[])
{
  if( argc > 1 and std::string(argv[1]) == "-backtrace" ) {

    // Construct arguments into a single character string to be interpreted
    std::string args;
    for( int i=2; i<argc; ++i ) args += std::string(argv[i]) + " ";
    while( not args.empty() and args.back() == ' ' ) args.pop_back();
    // Escape single quotes
    size_t pos=0;
    while(  ( pos = args.find_first_of( '\'', pos ) ) != std::string::npos ) {
      args.replace( pos, 1, "\\'" );
      pos += 2;
    }

    // Create gdb command
    std::string command{ "echo y | gdb -ex 'set args %s' -ex run -ex backtrace -ex quit %s" };
    std::string program{ argv[0] };
    // Adjust command to replace %s placeholders
    command.replace( command.find( "%s" ), 2, args );
    command.replace( command.find( "%s" ), 2, program );

    // Run the simulation under gdb
    std::cout << "DEBUG: " << command << std::endl;
    exit( system( command.c_str() ) );
  }
}
