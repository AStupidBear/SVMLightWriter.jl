# Lightning-fast svmlight writer

## Installation

```julia
using Pkg
pkg"add SVMLightWriter"
```

## Usage

```
using SVMLightWriter, SparseArrays
x = [0 2; 3.1 4.2]
y = [1, -1]
x_sp = sparse(x)
```

You can dump a dense or sparse array to an IOBuffer or a file

```
dump_svmlight_file(x, y, IOBuffer())
dump_svmlight_file(x_sp, y, IOBuffer()) 
dump_svmlight_file(x, y, "tmp.svmlight")
```