module SVMLightWriter

using Printf, SparseArrays, Requires, ProgressMeter

export dump_svmlight_file

function dump_svmlight_file(x::AbstractArray, y, f::IO; zero_based = true, query_id = nothing)
    @assert size(x, 2) == length(y)
    noqid = isnothing(query_id)
    noqid || @assert length(query_id) == length(y)
    @inbounds @showprogress "dumpsvm..." for j in 1:length(y)
        print(f, y[j])
        noqid || print(f, " qid:", query_id[j])
        for i in 1:size(x, 1)
            v = x[i, j]
            iszero(v) && continue
            i′ = ifelse(zero_based, i - 1, i)
            print(f, ' ', i′, ':')
            @printf(f, "%.4g", v)
        end
        println(f)
    end
end

function dump_svmlight_file(x::SparseMatrixCSC, y, f::IO; zero_based = true, query_id = nothing)
    @assert size(x, 2) == length(y)
    noqid = isnothing(query_id)
    noqid || @assert length(query_id) == length(y)
    @inbounds @showprogress "dumpsvm..." for j in 1:length(y)
        print(f, y[j])
        noqid || print(f, " qid:", query_id[j])
        for n in x.colptr[j]:(x.colptr[j + 1] - 1)
            i = x.rowval[n]
            i′ = ifelse(zero_based, i - 1, i)
            print(f, ' ', i′, ':')
            @printf(f, "%.4g", x.nzval[n])
        end
        println(f)
    end
end

dump_svmlight_file(x, y, file::String; ka...) = open(file, "w") do f
    dump_svmlight_file(x, y, f; ka...)
end

@init @require PyCall="438e738f-606a-5dbb-bf0a-cddfbfd45ab0" begin
dump_svmlight_file(x::PyCall.PyObject, a...; ka...) =
    PyCall.pyimport("sklearn.datasets").dump_svmlight_file(x, a..., ka...)
end

end # module
