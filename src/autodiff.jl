

# fx = jacobian(x, f, x, u)
function jacobian(dx, f, args...; inplace = false)
    f_sym = Base.invokelatest(f, args...)
    fx_sym = cat(map(1:length(dx)) do i
        map(f_sym) do f
            derivative(f, dx[i])
        end
    end...; dims = ndims(f_sym)+1)

    # return eval(build_function(fx_sym, args...)[inplace ? 2 : 1])
    fx_ex = build_function(fx_sym, args...)[inplace ? 2 : 1]
    return @eval $fx_ex
end

# fxx = hessian(x, u, f, x, u)
hessian(dx1, dx2, f, args...; inplace=false) = jacobian(dx2, jacobian(dx1, f, args...), args...; inplace)
# function hessian(dx1, dx2, f, args...; inplace=false)
#     fx1 = jacobian(dx1, f, args...)
#     jacobian(dx2, Base.invokelatest(jacobian(dx1, f, args...)), args...; inplace)


#MAYBE:
# @kwdef
# struct Model{NX,NU}
# end





# function autodiff(f=(x,u)->(x),l=(x,u)->(x),p=(x)->(x); NX=1, NU=1)
function autodiff(f,l,p; NX,NU)
    model = MStruct()
    model.NX = NX
    model.NU = NU
    autodiff!(model,f,l,p)
    return model
end

function autodiff!(model,f,l,p)
    @variables x[1:model.NX] u[1:model.NU]

    model.f = f
    model.fx! = jacobian(x,f,x,u; inplace=true)
    model.fu! = jacobian(u,f,x,u; inplace=true)
    model.fxx! = hessian(x,x,f,x,u; inplace=true)
    model.fxu! = hessian(x,u,f,x,u; inplace=true)
    model.fuu! = hessian(u,u,f,x,u; inplace=true)
    
    model.l = l
    model.lx! = jacobian(x,l,x,u; inplace=true)
    model.lu! = jacobian(u,l,x,u; inplace=true)
    model.lxx! = hessian(x,x,l,x,u; inplace=true)
    model.lxu! = hessian(x,u,l,x,u; inplace=true)
    model.luu! = hessian(u,u,l,x,u; inplace=true)

    model.p = p
    model.px! = jacobian(x,p,x; inplace=true)
    model.pxx! = hessian(x,x,p,x; inplace=true)

    return model
end