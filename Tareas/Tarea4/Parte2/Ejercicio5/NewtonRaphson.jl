using Calculus
using LinearAlgebra

f(X) = (1/3)(X[1]^3-16*X[1]^2+5*X[1]+X[2]^3-16*X[2]^2+5*X[2]+X[3]^3-16*X[3]^2+5*X[3]) #-8 to 8

BestX = [0.0,0.0,0.0]
BestFX = Inf64
WorstX = [0.0,0.0,0.0]
WorstFX = -Inf64

BestXs = []

TotalX = []
TotalY = []
TotalZ = []

Hf = hessian(f)
Gf = Calculus.gradient(f)

function Newton()
    tolfun = 0.01
    tolgrad = 0.01
    X = [-2.0,2.0,1.0]
    CurrXs = []

    while true
        search = (-inv(Hf(X)))*Gf(X)
        prev = copy(X)

        for i in 1:length(X)
            X[i] += search[i] #maximos con + minimos con -
        end

        push!(CurrXs,X)

        if abs(f(X)-f(prev)) < tolfun || norm(Gf(X)) < tolgrad
            break
        end
    end

    append!(TotalX,X[1])
    append!(TotalY,X[2])
    append!(TotalZ,X[3])

    if f(X) < BestFX
        global BestFX = f(X)
        global BestX = copy(X)
        global BestXs = copy(CurrXs)
    end

    if f(X) > WorstFX
        global WorstFX = f(X)
        global WorstX = X
    end
end

for i in 1:1000
    Newton()
end

print("& (",round(mean(TotalX);digits=5),", ",round(mean(TotalY);digits=5),", ",round(mean(TotalZ);digits=5),") & ", round(f([mean(TotalX),mean(TotalY),mean(TotalZ)]);digits=5)," & (",round(BestX[1];digits=5),", ",round(BestX[2];digits=5),", ",round(BestX[3];digits=5),") & ", round(BestFX;digits=5), " & (",round(WorstX[1];digits=5),", ",round(WorstX[2];digits=5),", ",round(WorstX[3];digits=5),") & ",round(WorstFX;digits=5) )
