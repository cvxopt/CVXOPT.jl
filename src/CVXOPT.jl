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
  sol = solvers.conelp(cp,Gp,hp,py_dims,A=Ap,b=bp,options=py_opts);

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
  sol = solvers.coneqp(Pp,qp,Gp,hp,py_dims,A=Ap,b=bp,options=py_opts);

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
  sol = solvers.lp(cp,Gp,hp;A=Ap,b=bp,options=py_opts);

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
  sol = solvers.qp(Pp,qp,Gp,hp,A=Ap,b=bp,options=py_opts);

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
  sol = solvers.socp(cp, Gl=Glp, hl=hlp, Gq=Gqp, hq=hqp, A=Ap, b=bp, options=py_opts);

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
  sol = solvers.sdp(cp, Gl=Glp, hl=hlp, Gs=Gsp, hs=hsp, A=Ap, b=bp, options=py_opts);

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
      J[A.colptr[i]:A.colptr[i+1]-1] .= i - 1;
    end
    I = A.rowval .- 1
    V = A.nzval
    Ap = @pycall  cvxopt.spmatrix(py"list($$V)"o,py"list($$I)"o,py"list($$J)"o,(size(A,1),size(A,2)))::PyObject;
  elseif isempty(A)
    Ap = pybuiltin("None");
  else
    sA = size(A)
    if length(sA) == 1
      sA = (sA[1],1)
    end
    Ap = @pycall cvxopt.matrix(py"list($(A[:]))"o,sA)::PyObject;
  end
  return Ap;
end

end
