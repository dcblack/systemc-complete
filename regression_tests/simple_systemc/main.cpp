#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"
#pragma GCC   diagnostic push
#pragma GCC   diagnostic ignored "-Wunused-parameter"
#include <systemc>
#pragma clang diagnostic pop
#pragma GCC   diagnostic pop
extern void func(int value);
int sc_main([[maybe_unused]]int argc,[[maybe_unused]]char * argv[])
{
  func(42);
  return 0;
}
