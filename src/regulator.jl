
# --------------------------------- regulator --------------------------------- #

function regulator(Ar,Br,iRr,Rr,Qr,NX,NU,T)
    
    Kr = buffer(NU,NX)

    PT = collect(I(NX))
    Pr! = solve(ODEProblem(riccati!, PT, (T,0.0), (Ar,Br,Rr,Qr,Kr)))
    Pr = functor((Pr,t) -> Pr!(Pr, t), buffer(NX,NX))

    iRrBr = buffer(NU,NX)
    function _Kr(t)
        mul!(iRrBr, iRr(t), Br(t)')
        mul!(Kr, iRrBr, Pr(t))
        return Kr
    end
    return _Kr
end

function riccati!(dP, P, (Ar,Br,Rr,Qr,Kr), t)
    mul!(Kr, Rr(t)\Br(t)', P)
    dP .= -Ar(t)'P - P*Ar(t) + Kr'*Rr(t)*Kr - Qr(t)
    # dP .= -Ar(t)'P - P*Ar(t) + Kr'*Br'*P - Qr(t)
end
