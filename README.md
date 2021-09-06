# Lightning-fast svmlight writer

[![Build Status](https://github.com/AStupidBear/SVMLightWriter.jl/workflows/CI/badge.svg)](https://github.com/AStupidBear/SVMLightWriter.jl/actions)
[![Coverage](https://codecov.io/gh/AStupidBear/SVMLightWriter.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/AStupidBear/SVMLightWriter.jl)

## Installation

```julia
using Pkg
pkg"add SVMLightWriter"
```

## Usage

```julia
using SVMLightWriter, SparseArrays
x = [0 2; 3.1 4.2]
y = [1, -1]
x_sp = sparse(x)
```

You can dump a dense or sparse array to an IOBuffer or a file

```julia
dump_svmlight_file(x, y, IOBuffer())
dump_svmlight_file(x_sp, y, IOBuffer()) 
dump_svmlight_file(x, y, "tmp.svmlight")
```