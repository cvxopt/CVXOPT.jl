# CvxOpt.jl

Julia interface to CVXOPT.

The package provides Julia wrappers for the following CVXOPT solvers:

- [cvxopt.solvers.conelp](http://cvxopt.org/userguide/coneprog.html?#linear-cone-programs)
- [cvxopt.solvers.coneqp](http://cvxopt.org/userguide/coneprog.html?#quadratic-cone-programs)
- [cvxopt.solvers.lp](http://cvxopt.org/userguide/coneprog.html?#linear-programming)
- [cvxopt.solvers.qp](http://cvxopt.org/userguide/coneprog.html?#quadratic-programming)
- [cvxopt.solvers.socp](http://cvxopt.org/userguide/coneprog.html?#second-order-cone-programming)
- [cvxopt.solvers.sdp](http://cvxopt.org/userguide/coneprog.html?#semidefinite-programming)


## Requirements

Python and CVXOPT must be installed. 

## Installation and test

```julia
Pkg.close("https://github.com/cvxopt/CvxOpt.jl")
Pkg.test("CvxOpt")
```



<!---

[![Build Status](https://travis-ci.org/cvxopt/CvxOpt.jl.svg?branch=master)](https://travis-ci.org/cvxopt/CvxOpt.jl)

[![Coverage Status](https://coveralls.io/repos/cvxopt/CvxOpt.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/cvxopt/CvxOpt.jl?branch=master)

[![codecov.io](http://codecov.io/github/cvxopt/CvxOpt.jl/coverage.svg?branch=master)](http://codecov.io/github/cvxopt/CvxOpt.jl?branch=master)

-->
