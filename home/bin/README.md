About this directory
====================

These are useful scripts for building SystemC projects that go beyond simple g++, clang++, cmake, make, or ninja. Most should have internal documentation.

Files
=====

```
.
|-- DO -- echo argments and execute
|-- README.md -- this file (markdown documentation)
|-- build -- runs cmake inside a build/ subdirectory to keep generated distractions to a minimum.
|-- filter-mlog -- Cleans up paths that reference $PROJ_ROOT.
|-- filter-sclog -- Removes excess blank lines around REPORT_INFO and fixes paths per filter-mlog.
|-- header -- big block letters
|-- qsc -- quick dirty systemc compile (assumes all visible .cpp files are the entire source)
`-- ruler -- horizontal line
```

Viewing
=======
This file uses [**GitHub flavored markdown**](https://github.github.com/gfm/). For measier viewing use one of:
1. Linux/OSX/Windows: [Typora.io](https://typora.io)
2. Online: [StackEdit](https://stackedit.io/editor)
3. General: [VIm](http://www.vim.org)

#### End
