
abstract AbstractBlockMatrix{T} <: AbstractMatrix{T}
typealias AbMat{T} AbstractMatrix{T}

"""Returns the blocks of a matrix (non-recursive)"""
blocks(A::AbstractMatrix) = Any[A]

"""Returns the specified matrix block"""
block(M::AbstractMatrix,inds...)  = getindex(blocks(M),inds...)

"""Returns the size of the block matrix. Assumes row/column independent partitiong."""
function Base.size(M::AbstractBlockMatrix)
  thesizes = sizes(M)
  collens,rowlens = [s[1] for s in thesizes[:,1]],[s[2] for s in thesizes[1,:]]
  return (sum(collens),sum(rowlens))
end

"""Returns the sizes of each of the blocks in the matrix (non-recursive)"""
sizes(M::AbstractBlockMatrix) = map(size,blocks(M))

"""Recursive version of sizes, returning collection of sizes of non-block form matrices in block matrix"""
deepsizes(M::AbstractBlockMatrix) = map(deepsizes,blocks(M))
deepsizes(A::AbstractMatrix) = size(A)
