# Getting Started

Consider the following problem of finding an $x$ and $y$ such that

```math
\begin{cases}
(x+3)*(y^3-7)+18 = 0\\
sin(y*exp(x)-1 = 0
\end{cases}
```

```julia
(x, y) -> ((x+3)*(y^3-7)+18, sin(y*exp(x)-1))
```

In order to find a zero of this function and display it, you would write the
following program:

```julia
using NLsolve

function f!(F, x)
    F[1] = (x[1]+3)*(x[2]^3-7)+18
    F[2] = sin(x[2]*exp(x[1])-1)
end

function j!(J, x)
    J[1, 1] = x[2]^3-7
    J[1, 2] = 3*x[2]^2*(x[1]+3)
    u = exp(x[1])*cos(x[2]*exp(x[1])-1)
    J[2, 1] = x[2]*u
    J[2, 2] = u
end

nlsolve(f!, j!, [ 0.1; 1.2])
```

First, note that the function `f!` computes the residuals of the nonlinear
system, and stores them in a preallocated vector passed as first argument.
Similarly, the function `j!` computes the Jacobian of the system and stores it
in a preallocated matrix passed as first argument. Residuals and Jacobian
functions can take different shapes, see below.

Second, when calling the `nlsolve` function, it is necessary to give a starting
point to the iterative algorithm.

Finally, the `nlsolve` function returns an object of type `SolverResults`. In
particular, the field `zero` of that structure contains the solution if
convergence has occurred. If `r` is an object of type `SolverResults`, then
`converged(r)` indicates if convergence has occurred.
