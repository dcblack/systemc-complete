#include "backtrace.hpp"
#include <iostream>
#include <string>
#include <iomanip>

int main([[maybe_unused]]int argc, [[maybe_unused]]const char* argv[])
{
  backtrace(argc,argv); //< does not return if the first argument is `-backtrace`
  std::cout << "Starting " << argv[0] << std::endl;
  for( int i=1; i<argc; ++i ) {
    std::string arg(argv[i]);
    std::cout << "  " << std::setw(2) << i << ": " << arg << std::endl;
  }
  int* ptr = nullptr;
  *ptr = 666; //< CRASH!!
  return 0;
}
