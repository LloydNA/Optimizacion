using Calculus
using LinearAlgebra

f(X) = 4*X[1]^2-4*X[1]*X[2]+3*X[2]^2+X[1] # -5 to 5
fg(x,y) = 4*x^2-4*x*y+3*y^2+x # -5 to 5

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

    gif(anim, "/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/Optimizacion/Tareas/Tarea4/Parte2/Ejercicio2/GIFS/NewtonRaphson.gif", fps = 15)
end

Hf = hessian(f)
Gf = Calculus.gradient(f)

function Newton()
    tolfun = 0.01
    tolgrad = 0.01
    X = [-5.0,5.0]
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