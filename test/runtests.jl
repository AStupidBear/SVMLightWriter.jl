using SVMLightWriter
using Test

x = [1 2; 3 4]
y = [1, -1]
f = IOBuffer()
dump_svmlight_file(x, y, f)
str = String(take!(f))
@test str == "1 0:1.00 1:3.00\n-1 0:2.00 1:4.00\n"