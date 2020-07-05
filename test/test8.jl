using PyCall

let
    py"""
    import cvxopt

    def get_sparse(v, tc):
        return cvxopt.spmatrix(v, range(3), range(3), (3, 3), tc)

    """
    Id = py"get_sparse"(1.0, "d")
    Ic = py"get_sparse"(1.0 + 1.0im, "z")
    
    @test( Id[1, 1] == Id[2, 2] == Id[3, 3] == 1.0 )
    @test( Ic[1, 1] == Ic[2, 2] == Ic[3, 3] == 1.0 + 1.0im )
    
    @test( nnz(Id) == nnz(Ic) == 3 )

end
