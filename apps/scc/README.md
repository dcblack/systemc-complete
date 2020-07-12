<!-- For doxygen -->
\mainpage

# About $SCC_HOME

## Overview

This directory contains useful SystemC extensions including:

  `systemcc`             | "SystemC Complete" header to pull in the extensions in addition to `systemc`.
  `no_clock/`            | Supports the `no_clock` class replacing `sc_clock`. See `ABOUT_NOCLOCK.md`.
  `README.md`            | This documentation.
  `require_version.hpp`  | Checks for required versions of both C++ and SystemC
  `tlmc`                 | "TLM Complete" header to pull in the extensions in addition to `tlmc`
  `report/`              | `SC_REPORT_*` extensions. See `ABOUT_REPORT.md`
  `scx/`                 | SystemC eXtension suggestions. See `ABOUT_SCX.md`

## How to use

The environment variable $SCC_HOME is automatically added to include directories for compilation under SystemC Complete.

Just replace includes of `systemc` with `systemcc` and `tlm` with `tlmc`.

### The end
