using Calculus
using Plots
using Statistics

f(x) = 2*(x-3)^2+exp(0.5*x^2) #0-100

BetterX::Float64 = 0
BetterFx::Float64 = Inf64
WorstX::Float64 = 0
WorstFx::Float64 = -Inf64

BetterA = []
BetterB = []
BetterALPHA = []

TotalX = []

function graph(a,b,alpha)
    anim = @animate for i in eachindex(a)
        plot(f,0,100,label="f(x)")
        scatter!([a[i]],[f(a[i])],color="red",label="a")
        scatter!([b[i]],[f(b[i])],color="blue",label="b")
        scatter!([alpha[i]],[f(alpha[i])],color="green",label="alpha")
    end

    gif(anim, "/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/Optimizacion/Tareas/Tarea4/Parte1/Ejercicio1/GIFS/Secante.gif", fps = 15)
end

function Secante()
    a::Float64 = 0
    b::Float64 = 3
    error = 0.05
    A = [copy(a)]
    B = [copy(b)]

    alpha = (a+b)/2
    ALPHA = [copy(alpha)]

    while derivative(f,a)*derivative(f,alpha) >= 0
        a = copy(alpha)
        alpha = (a+b)/2
    end

    b = copy(alpha)

    alpha = b - (derivative(f,b))/((derivative(f,b)-derivative(f,a))/(b-a))

    while abs(derivative(f,alpha))>error
        if derivative(f,alpha) > 0
            b = copy(alpha)
        else
            a = copy(alpha)
        end

        alpha = b - (derivative(f,b))/((derivative(f,b)-derivative(f,a))/(b-a))

        append!(A,a)
        append!(B,b)
        append!(ALPHA,alpha)
    end

    append!(TotalX,alpha)

    if f(alpha) < BetterFx
        global BetterFx = f(alpha)
        global BetterX = alpha
        global BetterB = B
        global BetterA = A
        global BetterALPHA = ALPHA
    end

    if f(alpha) > WorstFx
        global WorstFx = f(alpha)
        global WorstX = alpha
    end
end

for i in 1:1000
    Secante()
end

graph(BetterA, BetterB, BetterALPHA)

print("& ",round(mean(TotalX); digits=5)," & ", round(f(mean(TotalX)); digits=5), " & ", round(BetterX; digits=5), " & ", round(BetterFx; digits=5), " & ", round(WorstX; digits=5), " & ", round(WorstFx, digits=5))
