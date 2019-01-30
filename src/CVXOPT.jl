"CVXOPT.jl - a Julia interface to CVXOPT"
module CVXOPT
using PyCall
using SparseArrays

const cvxopt = PyNULL()
const solvers = PyNULL()

function __init__()
    copy!(cvxopt, pyimport_conda("cvxopt", "cvxopt", "conda-forge"))
    copy!(solvers, pyimport_conda("cvxopt.solvers", "cvxopt"))
end

#
# Wrappers
#

"""
CVXOPT conelp() interface

See CVXOPT documentation for more information:

  http://cvxopt.org/userguide/coneprog.html#linear-cone-programs
"""
function conelp(c,G,h,dims;A=[],b=[],options=Dict())

  # Convert problem data to CVXOPT matrices
  cp = julia_to_cvxopt(c);
  Gp = julia_to_cvxopt(G);
  hp = julia_to_cvxopt(h);
  Ap = julia_to_cvxopt(A);
  bp = julia_to_cvxopt(b);

  # Convert 'dims' and 'options' dictionaries to Python dictionaries
  py_dims = py"{'l':int($(dims[\"l\"])),'q':[int(i) for i in $(dims[\"q\"])],'s':[int(i) for i in $(dims[\"s\"])]}"o;
  py_opts = PyObject(options);

  # Call cvxopt.solvers.conelp()
  sol = solvers[:conelp](cp,Gp,hp,py_dims,A=Ap,b=bp,options=py_opts);

  # Convert solution to Julia arrays
  sol["x"] = cvxopt_to_julia(sol["x"])
  sol["s"] = cvxopt_to_julia(sol["s"])
  sol["z"] = cvxopt_to_julia(sol["z"])
  sol["y"] = cvxopt_to_julia(sol["y"])

  return sol;
end


"""
CVXOPT coneqp() interface

See CVXOPT documentation for more information:

  http://cvxopt.org/userguide/coneprog.html#quadratic-cone-programs
"""
function coneqp(P,q,G,h,dims;A=[],b=[],options=Dict())

  # Convert problem data to CVXOPT matrices
  Pp = julia_to_cvxopt(P);
  qp = julia_to_cvxopt(q);
  Gp = julia_to_cvxopt(G);
  hp = julia_to_cvxopt(h);
  Ap = julia_to_cvxopt(A);
  bp = julia_to_cvxopt(b);

  # Convert 'dims' and 'options' dictionaries to Python dictionaries
  py_dims = py"{'l':int($(dims[\"l\"])),'q':[int(i) for i in $(dims[\"q\"])],'s':[int(i) for i in $(dims[\"s\"])]}"o;
  py_opts = PyObject(options);

  # Call cvxopt.solvers.coneqp()
  sol = solvers[:coneqp](Pp,qp,Gp,hp,py_dims,A=Ap,b=bp,options=py_opts);

  # Convert solution to Julia arrays
  if sol["status"] == "optimal"
    sol["s"] = cvxopt_to_julia(sol["s"])
    sol["x"] = cvxopt_to_julia(sol["x"])
    sol["z"] = cvxopt_to_julia(sol["z"])
    sol["y"] = cvxopt_to_julia(sol["y"])
  elseif sol["status"] == "dual infeasible"
    sol["s"] = cvxopt_to_julia(sol["s"])
    sol["x"] = cvxopt_to_julia(sol["x"])
  elseif sol["status"] == "primal infeasible"
    sol["z"] = cvxopt_to_julia(sol["z"])
    sol["y"] = cvxopt_to_julia(sol["y"])
  end

  return sol;
end


"""
CVXOPT lp() interface

See CVXOPT documentation for more information:

  http://cvxopt.org/userguide/coneprog.html#linear-programming
"""
function lp(c,G,h;A=[],b=[],options=Dict())

  # Convert problem data to CVXOPT matrices
  cp = julia_to_cvxopt(c);
  Gp = julia_to_cvxopt(G);
  hp = julia_to_cvxopt(h);
  Ap = julia_to_cvxopt(A);
  bp = julia_to_cvxopt(b);

  # Convert 'options' dictionary to Python dictionary
  py_opts = PyObject(options);

  # Call cvxopt.solvers.lp()
  sol = solvers[:lp](cp,Gp,hp;A=Ap,b=bp,options=py_opts);

  # Convert solution to Julia arrays
  if sol["status"] == "optimal"
    sol["s"] = cvxopt_to_julia(sol["s"])
    sol["x"] = cvxopt_to_julia(sol["x"])
    sol["z"] = cvxopt_to_julia(sol["z"])
    sol["y"] = cvxopt_to_julia(sol["y"])
  elseif sol["status"] == "dual infeasible"
    sol["s"] = cvxopt_to_julia(sol["s"])
    sol["x"] = cvxopt_to_julia(sol["x"])
  elseif sol["status"] == "primal infeasible"
    sol["z"] = cvxopt_to_julia(sol["z"])
    sol["y"] = cvxopt_to_julia(sol["y"])
  end

  return sol;
end


"""
CVXOPT qp() interface

See CVXOPT documentation for more information:

  http://cvxopt.org/userguide/coneprog.html#quadratic-programming
"""
function qp(P,q,G,h;A=[],b=[],options=Dict())

  # Convert problem data to CVXOPT matrices
  Pp = julia_to_cvxopt(P);
  qp = julia_to_cvxopt(q);
  Gp = julia_to_cvxopt(G);
  hp = julia_to_cvxopt(h);
  Ap = julia_to_cvxopt(A);
  bp = julia_to_cvxopt(b);

  # Convert 'options' dictionary to Python dictionary
  py_opts = PyObject(options);

  # Call cvxopt.solvers.qp()
  sol = solvers[:qp](Pp,qp,Gp,hp,A=Ap,b=bp,options=py_opts);

  # Convert solution to Julia arrays
  if sol["status"] == "optimal"
    sol["s"] = cvxopt_to_julia(sol["s"])
    sol["x"] = cvxopt_to_julia(sol["x"])
    sol["z"] = cvxopt_to_julia(sol["z"])
    sol["y"] = cvxopt_to_julia(sol["y"])
  elseif sol["status"] == "dual infeasible"
    sol["s"] = cvxopt_to_julia(sol["s"])
    sol["x"] = cvxopt_to_julia(sol["x"])
  elseif sol["status"] == "primal infeasible"
    sol["z"] = cvxopt_to_julia(sol["z"])
    sol["y"] = cvxopt_to_julia(sol["y"])
  end

  return sol;
end


"""
CVXOPT socp() interface

See CVXOPT documentation for more information:

  http://cvxopt.org/userguide/coneprog.html#second-order-cone-programming
"""
function socp(c,Gl,hl,Gq,hq;A=[],b=[],options=Dict())

  # Convert problem data to CVXOPT matrices
  cp = julia_to_cvxopt(c);
  Glp = julia_to_cvxopt(Gl);
  hlp = julia_to_cvxopt(hl);
  Ap = julia_to_cvxopt(A);
  bp = julia_to_cvxopt(b);

  Gqp = Array{Any,1}(undef,length(Gq));
  hqp = Array{Any,1}(undef,length(hq));
  for i = 1:length(Gq)
    Gqp[i] = julia_to_cvxopt(Gq[i]);
    hqp[i] = julia_to_cvxopt(hq[i]);
  end
  Gqp = PyObject(Gqp);
  hqp = PyObject(hqp);

  # Convert 'options' dictionary to Python dictionary
  py_opts = PyObject(options);

  # Call cvxopt.solvers.socp()
  sol = solvers[:socp](cp, Gl=Glp, hl=hlp, Gq=Gqp, hq=hqp, A=Ap, b=bp, options=py_opts);

  # Convert solution to Julia arrays
  if sol["status"] == "optimal"
    sol["x"] = cvxopt_to_julia(sol["x"])
    sol["y"] = cvxopt_to_julia(sol["y"])
    sol["sl"] = cvxopt_to_julia(sol["sl"]);
    sol["zl"] = cvxopt_to_julia(sol["zl"]);
    for i = 1:length(Gq)
      sol["sq"][i] = cvxopt_to_julia(sol["sq"][i]);
      sol["zq"][i] = cvxopt_to_julia(sol["zq"][i]);
    end
  elseif sol["status"] == "dual infeasible"
    sol["sl"] = cvxopt_to_julia(sol["sl"])
    sol["x"] = cvxopt_to_julia(sol["x"])
    for i = 1:length(Gq)
      sol["sq"][i] = cvxopt_to_julia(sol["sq"][i]);
    end
  elseif sol["status"] == "primal infeasible"
    sol["zl"] = cvxopt_to_julia(sol["zl"])
    sol["y"] = cvxopt_to_julia(sol["y"])
    for i = 1:length(Gq)
      sol["zq"][i] = cvxopt_to_julia(sol["zq"][i]);
    end
  end

  return sol;
end


"""
CVXOPT sdp() interface

See CVXOPT documentation for more information:

  http://cvxopt.org/userguide/coneprog.html#semidefinite-programming
"""
function sdp(c, Gl, hl, Gs, hs; A=[], b=[], options=Dict())

  # Convert problem data to CVXOPT matrices
  cp = julia_to_cvxopt(c);
  Glp = julia_to_cvxopt(Gl);
  hlp = julia_to_cvxopt(hl);
  Ap = julia_to_cvxopt(A);
  bp = julia_to_cvxopt(b);

  Gsp = Array{Any,1}(undef,length(Gs));
  hsp = Array{Any,1}(undef,length(hs));
  for i = 1:length(Gs)
    Gsp[i] = julia_to_cvxopt(Gs[i]);
    hsp[i] = julia_to_cvxopt(hs[i]);
  end
  Gsp = PyObject(Gsp);
  hsp = PyObject(hsp);

  # Convert 'options' dictionary to Python dictionary
  py_opts = PyObject(options);

  # Call cvxopt.solvers.sdp()
  sol = solvers[:sdp](cp, Gl=Glp, hl=hlp, Gs=Gsp, hs=hsp, A=Ap, b=bp, options=py_opts);

  # Convert solution to Julia arrays
  if sol["status"] == "optimal"
    sol["x"] = cvxopt_to_julia(sol["x"])
    sol["y"] = cvxopt_to_julia(sol["y"])
    sol["sl"] = cvxopt_to_julia(sol["sl"]);
    sol["zl"] = cvxopt_to_julia(sol["zl"]);
    for i = 1:length(Gs)
      sol["ss"][i] = cvxopt_to_julia(sol["ss"][i]);
      sol["zs"][i] = cvxopt_to_julia(sol["zs"][i]);
    end
  elseif sol["status"] == "dual infeasible"
    sol["sl"] = cvxopt_to_julia(sol["sl"])
    sol["x"] = cvxopt_to_julia(sol["x"])
    for i = 1:length(Gs)
      sol["ss"][i] = cvxopt_to_julia(sol["ss"][i]);
    end
  elseif sol["status"] == "primal infeasible"
    sol["zl"] = cvxopt_to_julia(sol["zl"])
    sol["y"] = cvxopt_to_julia(sol["y"])
    for i = 1:length(Gs)
      sol["zs"][i] = cvxopt_to_julia(sol["zs"][i]);
    end
  end

  return sol
end

#
# Auxiliary routines
#

"""
Convert Julia array to CVXOPT matrix or spmatrix
"""
function julia_to_cvxopt(A)
  if issparse(A)
    J = zeros(Int64, length(A.rowval));
    for i = 1:size(A,2)
      J[A.colptr[i]:A.colptr[i+1]-1] .= i;
    end
    Ap = cvxopt[:spmatrix](PyVector(A.nzval),PyVector(A.rowval.-1),PyVector(J.-1),(size(A,1),size(A,2)));
  elseif isempty(A)
    Ap = pybuiltin("None");
  else
    sA = size(A)
    if length(sA) == 1
      sA = (sA[1],1)
    end
    Ap = cvxopt[:matrix](A[:],sA);
  end
  return Ap;
end

"""
Convert CVXOPT matrix to Julia array
"""
function cvxopt_to_julia(A)
  m,n = py"$(A).size";
  Aj = Array{Float64}(reshape(py"list($(A)[:])",m,n));
  return Aj;
end

end
