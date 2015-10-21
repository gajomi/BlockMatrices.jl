module BlockMatrices

export AbstractBlockMatrix,StandardBlockMatrix,
       block,blocks,sizes,deepsizes

include("abstract.jl")
include("standard.jl")


end # module
