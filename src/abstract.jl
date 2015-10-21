
abstract AbstractBlockMatrix{T} <: AbstractMatrix{T}
typealias AbMat{T} AbstractMatrix{T}

"""Returns the blocks of a matrix (non-recursive)"""
blocks(A::AbstractMatrix) = Any[A]

"""Returns the specified matrix block"""
block(M::AbstractMatrix,inds...)  = getindex(blocks(M),inds...)

"""Returns the sizes of each of the blocks in the matrix (non-recursive)"""
sizes(M::AbstractBlockMatrix) = map(size,blocks(M))

collens(M::AbstractBlockMatrix) = Int64[s[1] for s in sizes(M)[:,1]]
rowlens(M::AbstractBlockMatrix) = Int64[s[2] for s in sizes(M)[1,:]]

"""Returns the size of the block matrix. Assumes row/column independent partitiong."""
function Base.size(M::AbstractBlockMatrix)
  return (sum(collens(M)),sum(rowlens(M)))
end

"""Recursive version of sizes, returning collection of sizes of non-block form matrices in block matrix"""
deepsizes(M::AbstractBlockMatrix) = map(deepsizes,blocks(M))
deepsizes(A::AbstractMatrix) = size(A)

function Base.getindex(M::AbstractBlockMatrix,i,j)
    cinds,rinds = cumsum([0;rowlens(M)]),cumsum([0;collens(M)])
    cblock,rblock = searchsortedfirst(rinds,i)-1,searchsortedfirst(cinds,j)-1
    return block(M,cblock,rblock)[i-cinds[cblock],j-rinds[rblock]]
end

function Base.full(M::AbstractBlockMatrix)
    fullM = similar(M)
    for i = 1:length(M)
        fullM[i] = M[i]
    end
    return fullM
end
