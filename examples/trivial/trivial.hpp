//FILE: trivial.hpp
#ifndef TRIVIAL_HPP
#define TRIVIAL_HPP
#include <systemc>
struct Trivial_module : sc_core::sc_module
{
  Trivial_module( sc_core::sc_module_name instance );
  ~Trivial_module( void ) = default;
private:
  void main_thread( void );
};
#endif
