let
  c = [-4. -5.]';
  G = [2. 1. -1. 0.; 1. 2. 0. -1.]';
  h = [3. 3. 0. 0.]';
  sol = CVXOPT.lp(c, G, h)
  @test ( sol["status"] == "optimal" )
end
