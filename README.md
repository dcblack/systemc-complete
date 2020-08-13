SystemC Complete
================

About this directory
--------------------

This is the source code for the Systemc-Complete scripts and docker files.

WARNING: This is a project under development and not quite ready for full deployment.

### Important Subdirectories and Files

```
Dockerfile → configuration for the docker container
GNUmakefile → used to build the docker container
/apps/ →becomes /apps pointed to with $SCC_APPS
 +-- bin/ → scripts used to build the docker container
 +-- cci/ → cci installation
 +-- cmake/ → cmake scripts
 +-- greensocs/ → possible new home?
 +-- include/
 +-- make/ → shared make scripts
 +-- sc-templates/ → each template gets its own subdirectory
 |   +-- LICENSE
 |   +-- README.md
 |   +-- bin/
 |   +--   new* → extracts templates and replaces placeholders
 |   +--   phred* → placeholder replacement editor
 |   +-- ${TEMPLATE_DIR}/ → contains templates themselves
 +-- scc/ → extensions (none required) referenced with $SCC_HOME
 |    +-- README.md
 |    +-- no_clock/
 |    +-- report/
 |    +-- require_version.hpp
 |    +-- scc_version/
 |    +-- scx/ → extends SystemC (e.g. literals)
 |    +-- systemcc → <systemc> wrapper (suppress certain SystemC warnings)
 |    +-- tlmc → <tlm> wrapper using <systemcc>
 +-- setup.profile → sh setup used during builds of docker container
 +-- src/ → subdirectories contain source
 +-- systemc/ → systemc installation
/home/sc_user/
 +-- setup.profile
 +-- bin/
 +-- work/ → mountpoint for local directory where you end up in bash
```


About SystemC-Complete
----------------------
SystemC-Complete aims to provide an environment with the goal of providing everything you need (complete) to focus on code rather than surrounding boilerplate code endemic to SystemC. 

SystemC-Complete has numerous redeeming features:

1.  Docker container that should be platform independent
  a.  Uses Ubuntu latest (20.04 currently ? but worked under 18.04)
  b.  Special `Makefile.defs` to build the docker platform provided ? overrides planned
  c.  ALL compilation/execution takes place inside the docker
  d.  Under 3GB (currently 2.4G, but I want to leave some room for a few new things and not surprise users)
2.  A script to launch docker from your terminal (should work in Windows, but I need a machine to test on), `scc` (SystemC-Complete)
  a.  Makes the current working directory available inside the container. Thus you can edit code with your favorite Windows/Mac/Linux tools and simply invoke this script to compile/run.
  b.  Echoes command-lines used to script directory (simplified debugging script issues and/or inform what was used)
3.  Several approaches to invocation compilation:
  a.  `compile`, the easiest use model with several invocations and features:
    i.  Invoke without any arguments and it just scoops up all the `*.cpp` files in the local directory unless you have a `Makefile`
    ii.  Invoke with specific source files for a more targeted compilation
    iii.  Invoke with a local `Makefile` specifying SRCS for even more specific settings (use -f to override which `Makefile`)
    iv.  All settings can be overridden on the command-line
    v.  Automatically adds a bunch of things that are just distractions normally by scanning souce file content (e.g. `-DSC_INCLUDE_FX -lboost/`... etc)
    vi.  Creates all output files in sub-directories by default (easily overridable via command-line options)
    vii.  Creates error.log if compilation errors detected
    viii.  Creates compile-FILE.log if successful compile
    ix.  Does not attempt link if you left out `sc_main`. Allows for compile one file at a time.
    x.  Creates link.log when linking
    xi.  Executes `run.x` (or whatever name you choose) upon successful link and captures run.log
  b.  `build`, assumes a CMakeList.txt file and is suitable for larger projects (e.g. `scc build [target]`)
  c.  Simply invoke make, g++ or clang++, etc. manually or whatever (e.g. `scc make`)
  d.  Enter `scc bash` to use from within the Ubuntu container. Vim is supported
  e.  We've been able to setup Eclipse to use this environment (eclipse outside docker); although, still have not solved debugging with gdb
4.  Installed modern versions of both gcc (9.3) and clang (10.0), which support C++17 and slightly beyond
5.  Installed static analysis and linting (also optional targets for the compile script with targeted log files)
6.  Installed SystemC 2.3.4 (automatically built from public github when building the docker container)
7.  Supplementary SystemC utility sources provided (optional) ? easier reporting and support for C++ user-defined literals (e.g. 1_ns, 22.5_ms, 18_KHz )
  a.  Documented
8.  Compiled, but not yet tested CCI
9.  All compilations are run with ?pedantic -Wall -Wextra (with wrappers available to avoid some SystemC warnings). Ability to suppress provided, but should not be necessary for normal code.
10.  Includes a special set of SystemC templates (what I call Easier SystemC) to speed up development
  a.  Invoked via my `new` script (e.g. scc new tlm-target [VARIOUS_OPTIONS])
  b.  A fair number of templates are provided
11.  A set of code examples and regression tests are also provided.
12.  All scripts are documented both for usage and implementation. README.md provided as appropriate.
  a.  Scripts are a mixture of bash, perl and make
  b.  Many regression tests have been created or are planned.

Longer term:
1.  Planning to include QEMU (both flavors)
2.  Add graphical (tricky, but we have some proof of concept)

Tested platforms
----------------

This has been tested on the following platforms:

+ Mac OS X 10.15.6 (Catalina)

Please send feedback so we can know your success and add to this list, we will credit you.

How to build
------------

There are a number of **prerequisite tool dependencies** if you want to use this project. Below is a simple list including the currently used versions of those tools. This may work with earlier versions, but no testing has been done. If you use an older version and it works, please let us know. If you have problems with a newer version please let us know.

| Tool     | Version | Website                                        |
| :------- | :------ | :--------------------------------------------- |
| `make`   | 4.3     | https://www.gnu.org/software/make/             |
| `docker` | 19.03.8 | https://www.docker.com/products/docker-desktop |
| `git`    | 2.27    | https://git-scm.com/                           |
| `perl`   | 5.26.3  | https://www.perl.org/                          |
| `bash`   | 5.0.17  | https://www.gnu.org/software/bash/             |

Note: On Mac OS X, we used MacPorts to obtain some of the above. You will likely find that Ubuntu's apt-get will get decent versions. Please let us know your experiences so that we can add to this list.

<u>After the prerequisite tools are in place</u>, you should be able to build this with a simple command:

```bash
git checkout works #< unless you want to use the latest (possibly broken) version
make image
```

You should also check out the documentation associated with the `makefile` with the command:

```bash
make help
```

How to use
----------

Once you have built the docker image you can of course use the docker commands to run it; however, you might find a convenience script of interest. Simply add the local `bin/` directory to your PATH and use either of the following syntax's:

```bash
  scc # with no arguments simply puts you into the Ubuntu container
  scc COMMAND # see below
```

You can simply source `setup.profile` to add the syntax if you are using an `sh` style shell (i.e., sh, bash, zsh, ksh).

The above will ensure the directory you are in at the time of invocation is attached to the container. This allows you to develop your code in a local directory and simply use the `scc` (systemc-complete) tool to compile and execute. See [Examples](#ex) below.

Commands beyond obvious `bash` that you can use include:

* `build` `make` `ninja` `g++` `clang++` `astyle` `cppcheck` `new` `rsync` `git` `less` `vim` (non-GUI)

We intentionally did not include GUI tools to keep the image and its complexity relatively small.

Examples
--------

### Setup project directory

```bash
mkdir ~/trivial && cd ~/trivial

### Trivial source

Create the following three files.

​```c++
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
```

```c++
//FILE: trivial.cpp
#include "trivial.hpp"

using namespace sc_core;

Trivial_module::Trivial_module( sc_core::sc_module_name instance )
: sc_module( instance )
{
  SC_REPORT_INFO( "/Doulos/trivial", "Constructing Trivial_module" );
  SC_HAS_PROCESS( Trivial_module );
  SC_THREAD( main_thread );
}

void Trivial_module::main_thread( void )
{
  SC_REPORT_INFO( "/Doulos/trivial", "Starting main_thread" );
  wait( 10, SC_NS );
  SC_REPORT_WARNING( "/Doulos/trivial", "Stopping main_thread" );
  sc_stop();
}
```

```c++
//FILE: main.cpp
#include "trivial.hpp"
#include <systemc>

using namespace sc_core;

int sc_main( int argc, char* argv[] )
{
  SC_REPORT_INFO( "/Doulos/trivial", "Constructing top" );
  Trivial_module top{"top"};
  SC_REPORT_INFO( "/Doulos/trivial", "Initiating simulation" );
  sc_start();
  SC_REPORT_INFO( "/Doulos/trivial", "Exiting" );
  return 0;
}
```

### SystemC sources in a single directory

Run as follows...

```bash
scc compile
```

### SystemC sources described by Makefile

Create the following file:

```make
#!make -f
#FILE: Makefile

UNIT:=trivial
SRCS:=main.cpp trivial.cpp
CXX:=clang++

include /apps/make/Makefile.rules
```
Run as follows...

```bash
scc make clean run
```

### SystemC compiled via Cmake

Create the following file:

```cmake
#!cmake .
#FILE: CMakeLists.txt
# This works with SystemV versions 2.3.2 and later, which have support for
# cmake and specify SystemC_CXX_STANDARD.
# 
# REQUIREMENTS:
#   Define SYSTEMC_HOME to point to install directory of SystemC (not source) →/apps/systemc
#   Option: CCI_HOME →/apps/cci

cmake_minimum_required(VERSION 3.11)
set(TARGET_EXECUTABLE $<TARGET_FILE_NAME:trivial.exe>)
project(trivial CXX)

include( /apps/cmake/BuildTypes.cmake )
include( /apps/cmake/SystemC.cmake )
include( /apps/cmake/strict.cmake )

add_compile_definitions(SC_INCLUDE_FX SC_INCLUDE_DYNAMIC_PROCESSES)

add_executable(trivial.exe
  trivial.cpp
  main.cpp
)
```

Run as follows...

```bash
mkdir -p build
scc build -run
```

Files
-----

```
.
|-- Dockerfile               #< Configures the dock container
|-- GNUmakefile              #< Automates docker builds (habit)
|-- README.md                #< This text
|-- apps/
|   |-- bin/                 #< Executables used to build various bits-n-pieces
|   |   |-- README.md
|   |   |-- install-cmake    #< Not currently used, but might be useful in future
|   |   |-- install-qemu     #< Anticipating addition
|   |   `-- install-systemc  #< Installs latest SystemC
|   |-- cmake/               #< Configuration files for SystemC compiles
|   |   |-- ABOUT_CMAKE.md
|   |   |-- BuildTypes.cmake #< Establishes Debug vs Release criteria
|   |   |-- SystemC.cmake    #< Enables SystemC
|   |   `-- strict.cmake     #< Adds pedantic warnings for everything
|   |-- sc-templates/        #< Location of SystemC templates used by `new` script
|   |-- setup.profile        #< Potentially used during docker build
|   |-- src/                 #< Holds downloaded sources during installation
|   `-- systemc/             #< Install directory for SystemC libraries
|-- bin/                     #< Executables for use outside of the docker container
|   |-- DO                   #< Eventually used by scc. See home/bin/DO for details.
|   `-- scc                  #< SystemC-Complete (SCC) invokes systemcc docker image
|-- home/                    #< Copied to home directory
|   |-- bin/                 #< Scripts for daily use inside container
|   |   |-- .bak/            #< For backups of files edited by vim inside container
|   |   |-- .bash_profile    #< Invoked on login
|   |   |-- .gdbinit         #< Enables use of .gdbinit in work directory
|   |   |-- .vimrc           #< Minimum set of useful vim settings
|   |   |-- DO               #< Echoes command & executes (Used by build →minor issues)
|   |   |-- README.md        
|   |   |-- build            #< Runs cmake & ninja to compile & run systemc
|   |   |-- filter-mlog      #< Filters log files (used by build)
|   |   |-- filter-sclog     #< Filters SystemC log files (used by build)
|   |   |-- header           #< Creates block text (used by build)
|   |   |-- compile          #< Compiles, links and runs programs using Makefile automation built into the docker image
|   |   `-- ruler            #< Echoes horizontal line to aid visibility (used by build)
|   `-- setup.profile        #< User setup
`-- setup.profile            #< Source to add local ./bin to $PATH

```
Viewing
-------

This file uses [**GitHub flavored markdown**](https:#github.github.com/gfm/). For measier viewing use one of:
1. Linux/OSX/Windows: [Typora.io](https:#typora.io) **<< Highly recommended**
2. Online: [StackEdit](https:#stackedit.io/editor)
3. General: [VIm](http:#www.vim.org)

#### End
