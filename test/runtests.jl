using SVMLightWriter
using SparseArrays
using Test

x = [0 2; 3.1 4.2]
x_sp = sparse(x)
y = [1, -1]
io = IOBuffer()
str = "1 1:3.1\n-1 0:2 1:4.2\n"

dump_svmlight_file(x, y, io)
@test String(take!(io)) == str

dump_svmlight_file(x, y, "tmp")
@test read("tmp", String) == str
rm("tmp", force = true)

dump_svmlight_file(x_sp, y, io)
@test String(take!(io)) == str