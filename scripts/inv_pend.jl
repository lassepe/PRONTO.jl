using PRONTO
using LinearAlgebra
using GLMakie

## ------------------------------ USER INPUTS ------------------------------ ## 
# desired trajectory


# regulator parameters
Qr = I(2)
Rr = I(1)

# cost parameters
Qc = I(2)
Rc = I(1)

# define dynamics
function fxn(x, u)
    # parameters:
    l = 1; g = 9.8;
    # dynamics:
    [x[2], (g/l)*sin(x[1]) - (u/l) * cos(x[1])]
end

T = 10 # final time

A = Jx(f, ξd)
B = Ju(f, ξd)

# create cost functional
P₁,_ = arec(A(T), B(T)inv(Rᵣ)B(T)', Qc) # solve algebraic riccati eq at time T
l, m = build_LQ_cost(ξd, Qc, Rc, P₁, T) # cost functional


Pr₁,_ = arec(A(T), B(T)inv(Rr)B(T)', Qr) # solve algebraic riccati eq at time T


# ---------------- from newt_invpend ---------------- #
dt = 0.01
T0 = 0:dt:10
tanhT2 = @. tanh(T0-5)
lines(T0, tanhT2)

ϕ₀ = t->tanh(t-5)*(1-tanh(t-5)^2)

lines(T0, ϕ₀.(T0))

amp = (π/2)/maximum(ϕ₀.(T0))

amp = ( 90 *pi/180 )/Phi_0_max

Phi_des   = amp*(tanhT2.*(1-tanhT2.^2))/Phi_0_max;
dPhi_des  = amp*(3*tanhT2.^4 - 4*tanhT2.^2 + 1)/Phi_0_max;
ddPhi_des = amp*(-4*tanhT2.*(3*tanhT2.^4 - 5*tanhT2.^2 + 2))/Phi_0_max;
GG = 9.81;  LL = 0.5;


if  max( abs(Phi_des) ) < 60*pi/180   # be somewhat conservative!
    Udes = ( GG*sin(Phi_des) - LL*ddPhi_des ) ./ cos(Phi_des);
else
    Udes = 0*T0;  # or whatever you might *invent* (??)
end



## ------------------------------ DO PRONTO STUFF ------------------------------ ## 

