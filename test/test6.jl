let
  using SparseArrays
  n = 4;
  S = [ 4e-2  6e-3 -4e-3    0.0;
        6e-3  1e-2  0.0     0.0;
       -4e-3  0.0   2.5e-3  0.0;
        0.0   0.0   0.0     0.0];
  pbar = [.12 .10 .07 .03]';
  G = sparse(1:n,1:n,-ones(Float64,n));
  h = zeros(n);
  A = ones(1,n);
  b = [1.0];

  # Compute trade-off.
  mu = 0.1;
  sol = CVXOPT.qp(mu*S, -pbar, G, h, A=A, b=b)
  @test ( sol["status"] == "optimal" )
end
