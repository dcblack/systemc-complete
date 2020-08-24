#include "backtrace.hpp"

int main([[maybe_unused]]int argc, [[maybe_unused]]const char* argv[])
{
  // The following call does not return if the first argument is `-backtrace`,
  // but restarts under gdb with remaining arguments and displays command-line
  // arguments as an aid to debugging.
  backtrace(argc,argv);

  // Normal code -- that happens to have a bug...
  int* ptr = nullptr;
  *ptr = 666; //< CRASH!!
  return 0;
}
