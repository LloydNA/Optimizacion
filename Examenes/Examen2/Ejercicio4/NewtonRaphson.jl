using Calculus
using LinearAlgebra
using Plots
using Statistics
using LazySets

f(X) = X[1]^2+X[1]^4
fg(x) = x^2+x^4
fp(x) = 2*x+4*x^3

Hf = hessian(f)
Gf = Calculus.gradient(f)

function graph(a)
    anim = @animate for i in eachindex(a)
        plot(fg,-4,4,label="f(x)")
        scatter!([a[i]],[f(a[i])],color="red",label="x")
    end

    gif(anim, "/Users/lloydna/Projects/School/Optimizacion/Optimizacion/Examenes/Examen2/Ejercicio3/GIFS/Newton.gif", fps = 1)
end

function graphD(a)
    anim = @animate for i in eachindex(a)
        plot(fp,-4.0,4.0,label="f'(x)")
        if i<length(a)
            plot!(LineSegment([a[i],fp(a[i])],[a[i+1],0.0]),color="red", label="Tangente")
        end
    end

    gif(anim, "/Users/lloydna/Projects/School/Optimizacion/Optimizacion/Examenes/Examen2/Ejercicio3/GIFS/NewtonDerivada.gif", fps = 1)
end

BetterX::Float64 = 0
BetterFx::Float64 = Inf64
WorstX::Float64 = 0
WorstFx::Float64 = -Inf64

BetterXs = []

TotalX = []

function Newton()
    tolfun = 0.00000001
    tolgrad = 0.00000001
    X = [-4.0]
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
graphD(BetterXs)