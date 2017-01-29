# CVXOPT.jl — Julia interface to CVXOPT

The package provides Julia wrappers for the following [CVXOPT](http://cvxopt.org) solvers:

- [cvxopt.solvers.conelp](http://cvxopt.org/userguide/coneprog.html?#linear-cone-programs)
- [cvxopt.solvers.coneqp](http://cvxopt.org/userguide/coneprog.html?#quadratic-cone-programs)
- [cvxopt.solvers.lp](http://cvxopt.org/userguide/coneprog.html?#linear-programming)
- [cvxopt.solvers.qp](http://cvxopt.org/userguide/coneprog.html?#quadratic-programming)
- [cvxopt.solvers.socp](http://cvxopt.org/userguide/coneprog.html?#second-order-cone-programming)
- [cvxopt.solvers.sdp](http://cvxopt.org/userguide/coneprog.html?#semidefinite-programming)


## Installation and test (Linux/macOS)

CVXOPT.jl requires [PyCall](https://github.com/JuliaPy/PyCall.jl) to
call functions from the CVXOPT Python extension from Julia. If you
already have a Python executable in your path, then PyCall will use
that version of Python. Alternatively, you can force PyCall to use
[Conda.jl](https://github.com/JuliaPy/Conda.jl) to install a minimal Python distribution that is private to
Julia by setting `PYTHON=""`:

```julia
ENV["PYTHON"]=""  # Optional: force PyCall to use Conda.jl
Pkg.add("CVXOPT")
Pkg.test("CVXOPT")
```

This will automatically install CVXOPT from the conda-forge channel.

## Build status

[![Build Status](https://travis-ci.org/cvxopt/CVXOPT.jl.svg?branch=master)](https://travis-ci.org/cvxopt/CVXOPT.jl)
[![Coverage Status](https://coveralls.io/repos/github/cvxopt/CVXOPT.jl/badge.svg?branch=master)](https://coveralls.io/github/cvxopt/CVXOPT.jl?branch=master)
