# PRONTO.jl
A Julia implementation of the **PR**ojection-**O**perator-Based **N**ewton’s Method for **T**rajectory
**O**ptimization (PRONTO). PRONTO is a direct method for trajectory optimization based on variational calculus which computes descent direction directly in infinite-dimensional functional space.


## Usage
Please see the examples folder for usage examples. This API is still very likely to change – especially regarding the symbolic generation of jacobians/hessians and passing them to the solver. Note that upcoming changes in Julia 1.9 should substantially improve the compile time of large generated functions ([#45276](https://github.com/JuliaLang/julia/issues/45276), [#45404](https://github.com/JuliaLang/julia/issues/45404)).

