using Calculus
using Plots
using Statistics

f(x) = 3*x^4 + (x-1)^2 #0-4

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
        plot(f,0,4,label="f(x)")
        scatter!([a[i]],[f(a[i])],color="red",label="a")
        scatter!([b[i]],[f(b[i])],color="blue",label="b")
        scatter!([alpha[i]],[f(alpha[i])],color="green",label="xbar")
    end

    gif(anim, "/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/Optimizacion/Tareas/Tarea4/Parte1/Ejercicio1/GIFS/AjustePolinomialCubico.gif", fps = 5)
end

function Cubico()
    a::Float64 = 0
    b::Float64 = 4
    error = 0.05
    needGraph=true
    A = [copy(a)]
    B = [copy(b)]

    alpha = (a+b)/2
    ALPHA = [copy(alpha)]

    while derivative(f,a)*derivative(f,alpha) >= 0
        a = copy(alpha)
        alpha = (a+b)/2
    end

    b = copy(alpha)
    xbar = 0.0

    while true
        z = (3*(f(a)-f(b)))/(b-a) + derivative(f,a) + derivative(f,b)
        w = (b-a)/abs(b-a) + √(z^2-derivative(f,a)*derivative(f,b))
        u = (derivative(f,b)+w-z)/(derivative(f,b)-derivative(f,a)+2*w)

        xbar = if u < 0
            copy(b)
        elseif u>=0 && u<=1
            b-u*(b-a)
        else
            copy(a)
        end

        if abs(derivative(f,xbar)) < error
            break
        end

        if derivative(f,a)*derivative(f,xbar)<0
            b = copy(xbar)
        else
            a = copy(xbar)
        end

        append!(A,a)
        append!(B,b)
        append!(ALPHA,xbar)
    end

    append!(TotalX,xbar)

    if f(xbar) < BetterFx
        global BetterFx = f(xbar)
        global BetterX = xbar
        global BetterB = B
        global BetterA = A
        global BetterALPHA = ALPHA
    end

    if f(xbar) > WorstFx
        global WorstFx = f(xbar)
        global WorstX = xbar
    end
end

for i in 1:1000
    Cubico()
end

graph(BetterA, BetterB, BetterALPHA)

print("& ",round(mean(TotalX); digits=5)," & ", round(f(mean(TotalX)); digits=5), " & ", round(BetterX; digits=5), " & ", round(BetterFx; digits=5), " & ", round(WorstX; digits=5), " & ", round(WorstFx, digits=5))
