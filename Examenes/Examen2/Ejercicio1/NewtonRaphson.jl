using Calculus
using LinearAlgebra

f(X) = X[1]^2*exp(X[1])+X[2]^2*exp(X[2])+1 
fg(x,y) = x^2*exp(x)+y^2*exp(y)+1 

BestX = [0.0,0.0]
BestFX = Inf64
WorstX = [0.0,0.0]
WorstFX = -Inf64

BestXs = []

TotalX = []
TotalY = []

function graph()
    anim = @animate for i in eachindex(BestXs)
        contour(-5:0.1:5,-5:0.1:5,fg)
        scatter!([BestXs[i][1]],[BestXs[i][2]],color="green",label="")
    end

    gif(anim, "/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/Optimizacion/Examenes/Examen2/Ejercicio1/GIFS/funcion.gif", fps = 2)
end

Hf = hessian(f)
Gf = Calculus.gradient(f)

function Newton()
    tolfun = 0.01
    tolgrad = 0.01
    X = [1.0,1.0]
    CurrXs = []

    push!(CurrXs,X)

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

print("& (",round(mean(TotalX);digits=5),", ",round(mean(TotalY);digits=5),") & ", round(f([mean(TotalX),mean(TotalY)]);digits=5)," & (",round(BestX[1];digits=5),", ",round(BestX[2];digits=5),") & ", round(BestFX;digits=5), " & (",round(WorstX[1];digits=5),", ",round(WorstX[2];digits=5),") & ",round(WorstFX;digits=5) )

graph()