SystemC Complete
================

About this directory
--------------------

This is the source code for the systemc-complete scripts and docker files.

Tested platforms
----------------

This has been tested on the following platforms:

+ Mac OS X 10.15.5 (Catalina)

Please send feedback so we can know your success and add to this list, we will credit you.

How to build
------------

There are a number of dependencies if you want to use this project. Below is a simple list including the currently used versions of those tools. This may work with earlier versions, but no testing has been done. If you use an older version and it works, please let us know. If you have problems with a newer version please let us know.

| Tool     | Version | Website                                        | 
| :------- | :------ | :--------------------------------------------- | 
| `make`   | 4.3     | https://www.gnu.org/software/make/             | 
| `docker` | 19.03.8 | https://www.docker.com/products/docker-desktop | 
| `git`    | 2.26.2  | https://git-scm.com/                           | 
| `perl`   | 5.26.3  | https://www.perl.org/                          | 
| `bash`   | 5.0.17  | https://www.gnu.org/software/bash/             | 

Note: On Mac OS X, we used MacPorts to obtain some of the above. You will likely find that Ubuntu's apt-get will get decent versions. Please let us know your experiences so that we can add to this list.

Once the tools are in place, you should be able to build this with a simple command:

```bash
make image
```

How to use
----------

Once you have built the docker image you can of course use the docker commands to run it; however, you might find a convenience script of interest. Simply add the local `bin/` directory to your PATH and use either of the following syntax's:

```bash
  sc # with no arguments simply puts you into the Ubuntu container
  sc COMMAND # see below
```

You can simply source `setup.profile` to add the syntax if you are using an `sh` style shell (i.e., sh, bash, zsh, ksh).

The above will ensure the directory you are in at the time of invocation is attached to the container. This allows you to develop your code in a local directory and simply use the `sc` (systemc-complete) tool to compile and execute. See [Examples](#ex) below.

Commands beyond obvious `bash` that you can use include:

* `build` `make` `ninja` `g++` `clang++` `astyle` `cppcheck` `new` `rsync` `git` `less` `vim` (non-GUI)

We intentionally did not include GUI tools to keep the image and its complexity relatively small.

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
-------

This file uses [**GitHub flavored markdown**](https:#github.github.com/gfm/). For measier viewing use one of:
1. Linux/OSX/Windows: [Typora.io](https:#typora.io) **<< Highly recommended**
2. Online: [StackEdit](https:#stackedit.io/editor)
3. General: [VIm](http:#www.vim.org)

#### End
