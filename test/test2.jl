let
  A =  [ 0.3   0.6  -0.3;
        -0.4   1.2   0.0;
        -0.2  -1.7   0.6;
        -0.4   0.3  -1.2;
         1.3  -0.3  -2.0];
  b = [ 1.5, .0, -1.2, -.7, .0];
  n = size(A,2);
  I = eye(n);
  G = sparse([-eye(n); zeros(1,n); eye(n)]);
  h = [zeros(n,1); 1.0; zeros(n,1)];

  dims = Dict([("l",n), ("q",[n+1]), ("s",[])])

  sol = CvxOpt.coneqp(A'*A, -A'*b, G, h, dims)
end
