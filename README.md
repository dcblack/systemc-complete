About this directory
====================

This is the source code for the systemc-complete scripts and docker files.

Files
=====

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
|   |-- setup.profile        #< Potentially used during docker build
|   |-- src/                 #< Holds downloaded sources during installation
|   `-- systemc/             #< Install directory for SystemC libraries
|-- bin/                     #< Executables for use outside of the docker container
|   |-- DO                   #< Used by sc. See home/bin/DO for details.
|   `-- sc                   #< Invokes docker image
|-- home/                    #< Copied to home directory
|   |-- bin/                 #< Scripts for daily use inside container
|   |   |-- .bak/            #< For backups of files edited by vim inside container
|   |   |-- .bash_profile    #< Invoked on login
|   |   |-- .gdbinit         #< Enables use of .gdbinit in work directory
|   |   |-- .vimrc           #< Minimum set of useful vim settings
|   |   |-- DO               #< Echoes command & executes (Used by build)
|   |   |-- README.md        
|   |   |-- build            #< Runs cmake & ninja to compile & run systemc
|   |   |-- filter-mlog      #< Filters log files (used by build)
|   |   |-- filter-sclog     #< Filters SystemC log files (used by build)
|   |   |-- header           #< Creates block text (used by build)
|   |   |-- qsc              #< Quick and dirty systemc compile (not intelligent)
|   |   `-- ruler            #< Echoes horizontal line to aid visibility (used by build)
|   `-- setup.profile        #< User setup
`-- setup.profile            #< Source to add local ./bin to $PATH

```
Viewing
=======
This file uses [**GitHub flavored markdown**](https:#github.github.com/gfm/). For measier viewing use one of:
1. Linux/OSX/Windows: [Typora.io](https:#typora.io) **<< Highly recommended**
2. Online: [StackEdit](https:#stackedit.io/editor)
3. General: [VIm](http:#www.vim.org)

#### End
