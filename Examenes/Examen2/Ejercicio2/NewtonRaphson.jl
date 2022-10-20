using Calculus
using LinearAlgebra
using Plots
using Statistics

f(X) = 120+1.5*X[1]+200/X[1]
fg(x) = 120+1.5*x+200/x

Hf = hessian(f)
Gf = Calculus.gradient(f)

function graph(a)
    anim = @animate for i in eachindex(a)
        plot(fg,0,12,label="f(x)")
        scatter!([a[i]],[f(a[i])],color="red",label="x")
    end

    gif(anim, "/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/Optimizacion/Examenes/Examen2/Ejercicio2/GIFS/funcion.gif", fps = 2)
end

BetterX::Float64 = 0
BetterFx::Float64 = Inf64
WorstX::Float64 = 0
WorstFx::Float64 = -Inf64

BetterXs = []

TotalX = []

function Newton()
    tolfun = 0.01
    tolgrad = 0.01
    X = [2.0]
    ThisX = [copy(X[1])]

    while true
        search = (-inv(Hf(X)))*Gf(X)
        prev = copy(X)

        for i in 1:length(X)
            X[i] += search[i] #maximos con + minimos con -
        end

        append!(ThisX,X[1])

        if abs(f(X)-f(prev)) < tolfun || norm(Gf(X)) < tolgrad
            break
        end
    end

    append!(TotalX,X[1])

    if f(X) < BetterFx
        global BetterFx = f(X)
        global BetterX = X[1]
        global BetterXs = ThisX
    end

    if f(X) > WorstFx
        global WorstFx = f(X)
        global WorstX = X[1]
    end
end


for i in 1:1000
    Newton()
end

print("& ",round(mean(TotalX); digits=5)," & ", round(f(mean(TotalX)); digits=5), " & ", round(BetterX; digits=5), " & ", round(BetterFx; digits=5), " & ", round(WorstX; digits=5), " & ", round(WorstFx, digits=5))
graph(BetterXs)