# Examples
## Fixed Points

A special type of problems are fixed point problems

```math
F(x) = x
```

which can obviously be solved by the same methods by setting $\tilde{F}(x)=F(x)-x$ to zero. At each iteration, we choose a direction

$$
s = J(x)^{-1}F(x)
$$

where $J(x)$ is the Jacobian of $F(x)$, and then we either choose a step size based on a line search (by use of a merit function) or a trust region approach.

Syntax is straight forward:

```julia
nlsolve(F, [J], initial_x; kwargs...)
```

where F fills a vector with the results of the $f_i$'s and $J$ fills the associated Jacobian.

## Butt-cheek function

Consider the following system of equations

```math
\begin{cases}
x = 0\\
y(y^2-1)=0
\end{cases}
```

Define the residual function as

```julia
function bf!(fvec, x)
    fvec[1] = x[1]
    fvec[2] = x[2]*(x[2]^2-1)
end
nlsolve(bf!, [0.0, -2.4])
```

    Results of Nonlinear Solver Algorithm
     * Algorithm: Trust-region with dogleg and autoscaling
     * Starting Point: [0.0, -2.4]
     * Zero: [0.0, -1.0]
     * Inf-norm of residuals: 0.000000
     * Iterations: 7
     * Convergence: true
       * |x - x'| < 0.0e+00: false
       * |f(x)| < 1.0e-08: true
     * Function Calls (f): 8
     * Jacobian Calls (df/dx): 8

We can also supply the Jacobian manually, as to avoid finite differencing.

```julia
function bf!(fvec, x)
    fvec[1] = x[1]
    fvec[2] = x[2]*(x[2]^2-1)
end

function bg!(gvec, x)
    gvec[1,1] = 1.0
    gvec[1,2] = 0.0
    gvec[2,1] = 0.0
    gvec[2,2] = 3x[2]^2-1
end

nlsolve(bf!, bg!, [0.0, -2.4])
```

    Results of Nonlinear Solver Algorithm
     * Algorithm: Trust-region with dogleg and autoscaling
     * Starting Point: [0.0, -2.4]
     * Zero: [0.0, -1.0]
     * Inf-norm of residuals: 0.000000
     * Iterations: 7
     * Convergence: true
       * |x - x'| < 0.0e+00: false
       * |f(x)| < 1.0e-08: true
     * Function Calls (f): 8
     * Jacobian Calls (df/dx): 8
