using Calculus
using Plots
using Statistics

f(x) = -4*x*sin(x) #0-π

BetterX::Float64 = 0
BetterFx::Float64 = Inf64
WorstX::Float64 = 0
WorstFx::Float64 = -Inf64

BetterA = []
BetterB = []

TotalX = []

function graph(a,b)
    anim = @animate for i in eachindex(a)
        plot(f,0,π,label="f(x)")
        scatter!([a[i]],[f(a[i])],color="red",label="a")
        scatter!([b[i]],[f(b[i])],color="blue",label="b")
    end

    gif(anim, "/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/Optimizacion/Tareas/Tarea4/Parte1/Ejercicio2/GIFS/Biseccion.gif", fps = 15)
end

function BSC()
    a::Float64 = 0.1
    b::Float64 = π
    error = 0.05
    needGraph = true
    A = [copy(a)]
    B = [copy(b)]

    while abs(a-b)>error
        alpha = (a+b)/2

        if derivative(f,a)*derivative(f,alpha) <= 0
            b = alpha
        else
            a = alpha
        end

        append!(A,a)
        append!(B,b)
    end

    append!(TotalX,a)

    if f(a) < BetterFx
        global BetterFx = f(a)
        global BetterX = a
        global BetterB = B
        global BetterA = A
    end

    if f(a) > WorstFx
        global WorstFx = f(a)
        global WorstX = a
    end
end

for i in 1:1000
    BSC()
end

graph(BetterA, BetterB)

print("& ",round(mean(TotalX); digits=5)," & ", round(f(mean(TotalX)); digits=5), " & ", round(BetterX; digits=5), " & ", round(BetterFx; digits=5), " & ", round(WorstX; digits=5), " & ", round(WorstFx, digits=5))