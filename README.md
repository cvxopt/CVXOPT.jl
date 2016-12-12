# CVXOPT.jl

Julia interface to CVXOPT.

The package provides Julia wrappers for the following CVXOPT solvers:

- [cvxopt.solvers.conelp](http://cvxopt.org/userguide/coneprog.html?#linear-cone-programs)
- [cvxopt.solvers.coneqp](http://cvxopt.org/userguide/coneprog.html?#quadratic-cone-programs)
- [cvxopt.solvers.lp](http://cvxopt.org/userguide/coneprog.html?#linear-programming)
- [cvxopt.solvers.qp](http://cvxopt.org/userguide/coneprog.html?#quadratic-programming)
- [cvxopt.solvers.socp](http://cvxopt.org/userguide/coneprog.html?#second-order-cone-programming)
- [cvxopt.solvers.sdp](http://cvxopt.org/userguide/coneprog.html?#semidefinite-programming)


## Installation and test


```julia
ENV["PYTHON"]=""  # Force PyCall to use Conda
Pkg.clone("https://github.com/cvxopt/CVXOPT.jl")
Pkg.test("CVXOPT")
```

## Build status

[![Build Status](https://travis-ci.org/cvxopt/CVXOPT.jl.svg?branch=master)](https://travis-ci.org/cvxopt/CVXOPT.jl)

<!--
[![Coverage Status](https://coveralls.io/repos/cvxopt/CVXOPT.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/cvxopt/CVXOPT.jl?branch=master)

[![codecov.io](http://codecov.io/github/cvxopt/CVXOPT.jl/coverage.svg?branch=master)](http://codecov.io/github/cvxopt/CVXOPT.jl?branch=master)
-->

