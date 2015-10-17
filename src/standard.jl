"""The standard 2x2 block matrix form with square diagonal blocks."""
type StandardBlockMatrix{T,TA<:AbMat,TB<:AbMat,TC<:AbMat,TD<:AbMat} <: AbstractBlockMatrix{T}
    A::TA
    B::TB
    C::TC
    D::TD

    function StandardBlockMatrix(A::AbMat,B::AbMat,C::AbMat,D::AbMat)
      sA,sB,sC,sD= map(size,Any[A,B,C,D])
      if sA[1]==sA[2] && sD[1]==sD[2]
        sA[1]==sC[2]==sB[1] && sD[1]==sC[1]==sB[2] ? new(A,B,C,D) : error("off-diagonal blocks must have compatible dimensions")
      else
        error("block diagonals must be square")
      end
    end
end
function StandardBlockMatrix(A::AbMat,B::AbMat,C::AbMat,D::AbMat)
    T = promote_type(map(eltype,(A,B,C,D))...)
    return StandardBlockMatrix{T,typeof(A),typeof(B),typeof(C),typeof(D)}(A,B,C,D)
end


"""Returns the four blocks in a 2x2 matrix"""
function blocks(M::StandardBlockMatrix)
    theblocks = Array{Any,2}(2,2)
    theblocks[1,1] = M.A
    theblocks[1,2] = M.B
    theblocks[2,1] = M.C
    theblocks[2,2] = M.A
    return theblocks
end

function Base.getindex(M::StandardBlockMatrix,i,j)
    mA,nA = size(M.A)
    if     i<=mA && j<=nA
        return M.A[i,j]
    elseif i>mA  && j<=nA
        return M.C[i-mA,j]
    elseif i<=mA && j>nA
        return M.B[i,j-nA]
    else
        return M.D[i-mA,j-nA]
    end
end
