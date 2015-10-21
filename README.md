# BlockMatrices

A Julia module providing block matrix types and linear algebra methods

#Basic usage

The most basic block matrix type is the ``StandardBlockMatrix``, which consist of four blocks in a 2x2 configuration with square diagonals. This type explicitly parameterizes the types of each block.
```julia
>>>using BlockMatrices
>>>StandardBlockMatrix([rand(2,2) for _=1:4]...)
4x4 BlockMatrices.StandardBlockMatrix{Float64,Array{Float64,2},Array{Float64,2},Array{Float64,2},Array{Float64,2}}:
 0.1044    0.57242    0.0947273  0.102741
 0.534849  0.0953438  0.224184   0.725349
 0.868405  0.408458   0.331075   0.213396
 0.335363  0.310023   0.365254   0.157675
```
In the case of heterogenous block ``eltype``s the block matrix eltype is promoted to the largest containing eltype
```julia
>>>M = StandardBlockMatrix(Diagonal(im*rand(2)),[Diagonal(rand(2)) for _=1:3]...)
4x4 BlockMatrices.StandardBlockMatrix{Complex{Float64},Diagonal{Complex{Float64}},Diagonal{Float64},Diagonal{Float64},Diagonal{Float64}}:
 0.0+0.776615im  0.0+0.0im       0.0055064  0.0     
 0.0+0.0im       0.0+0.668819im  0.0        0.925514
    0.443792        0.0          0.257211   0.0     
    0.0             0.843751     0.0        0.10759
```
The blocks themselves can be block matrix types. It is also possible to mix numeric and non-numeric ``eltype``s (although linear algebra methods won't be supported for thes)
```julia
>>>StandardBlockMatrix([:♠ :♣; :♥ :♦],zeros(Int64,2,4),rand(4,2),M)
6x6 BlockMatrices.StandardBlockMatrix{Any,Array{Symbol,2},Array{Int64,2},Array{Float64,2},BlockMatrices.StandardBlockMatrix{Complex{Float64},Diagonal{Complex{Float64}},Diagonal{Float64},Diagonal{Float64},Diagonal{Float64}}}:
  :♠         :♣           0               0            0          0       
  :♥         :♦           0               0            0          0       
 0.960475   0.421799   0.0+0.776615im  0.0+0.0im       0.0055064  0.0     
 0.797707   0.0549448  0.0+0.0im       0.0+0.668819im  0.0        0.925514
 0.632783   0.0975602     0.443792        0.0          0.257211   0.0     
 0.0936359  0.522128      0.0             0.843751     0.0        0.10759
```

##Linear algebra methods

Show different block structures, include sparse blocks of dense matrices, which generalizes sparse matrices to blocks

[![Build Status](https://travis-ci.org/gajomi/BlockMatrices.jl.svg?branch=master)](https://travis-ci.org/gajomi/BlockMatrices.jl)
