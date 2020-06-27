//FILE: hello.cpp
#include "hello.hpp"
#include <systemc>

namespace {
  char const * const MSGID = "/Doulos/example/hello";
}
using namespace sc_core;

Hello_module::Hello_module(sc_core::sc_module_name instance_name)
: sc_module(instance_name)
{
  SC_HAS_PROCESS(Hello_module);
  SC_THREAD(hello_thread);
}

void Hello_module::hello_thread(void)
{
  SC_REPORT_INFO(MSGID,"Hello SystemC World!");
}

//------------------------------------------------------------------------------
//EOF
