let
  # Primal infeasible LP
  sol = CVXOPT.lp([1.0],[1.0 -1.0]',[0.0 -1.0]')
  @test ( sol["status"] == "primal infeasible" )

  # Dual infeasible LP
  sol = CVXOPT.lp([1.0],[1.0],[1.0])
  @test ( sol["status"] == "dual infeasible" )
end
