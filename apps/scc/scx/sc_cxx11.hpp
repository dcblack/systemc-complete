#ifndef SC_CXX11_HPP
#define SC_CXX11_HPP

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"
#pragma GCC   diagnostic push
#pragma GCC   diagnostic ignored "-Wunused-parameter"
#include <systemc>
#pragma clang diagnostic pop
#pragma GCC   diagnostic pop

#if __cplusplus >= 201103L

// The following allows for easy bigint's: 123456789ABCDEF0123456789_BIGINT
#ifndef SC_MAX_NBITS
#define SC_MAX_NBITS 17*30
#endif
inline sc_dt::sc_bigint<SC_MAX_NBITS> operator "" _BIGINT( const char* literal_string ) {
  return sc_dt::sc_bigint<SC_MAX_NBITS>( literal_string );
}
inline sc_dt::sc_bigint<SC_MAX_NBITS> operator "" _BIGUINT( const char* literal_string ) {
  return sc_dt::sc_bigint<SC_MAX_NBITS>( literal_string );
}
#endif

#endif
