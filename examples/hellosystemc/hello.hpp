//FILE: hello.hpp
#ifndef HELLO_HPP
#define HELLO_HPP

// Trivial version of Hello SystemC World

#include <systemc>

struct Hello_module : sc_core::sc_module
{
  Hello_module(sc_core::sc_module_name instance_name); //< constructor
  void hello_thread(void);
};
#endif/*HELLO_HPP*/
//------------------------------------------------------------------------------
//EOF
