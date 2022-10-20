using Calculus
using Plots
using Statistics
using LazySets

f(x) = x^2+x^4
fp(x) = 2*x+4*x^3
fd(x) = (f(x+0.01)-f(x))/0.01


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
        plot(f,-4,4,label="f(x)")
        scatter!([a[i]],[f(a[i])],color="red",label="a")
        scatter!([b[i]],[f(b[i])],color="blue",label="b")
        scatter!([alpha[i]],[f(alpha[i])],color="green",label="alpha")
    end

    gif(anim, "/Users/lloydna/Projects/School/Optimizacion/Optimizacion/Examenes/Examen2/Ejercicio3/GIFS/Secante.gif", fps = 1)
end

function graphD(a)
    anim = @animate for i in eachindex(a)
        plot(fp,-4.0,4.0,label="f'(x)")
        if i<length(a)
            plot!(LineSegment([a[i],fp(a[i])],[a[i+1],0.0]),color="red", label="Tangente")
        end
    end

    gif(anim, "/Users/lloydna/Projects/School/Optimizacion/Optimizacion/Examenes/Examen2/Ejercicio3/GIFS/SecanteDerivada.gif", fps = 1)
end

function Secante()
    a::Float64 = -4
    b::Float64 = 3
    error = 0.00000001
    A = [copy(a)]
    B = [copy(b)]
    ite=0

    alpha = (a+b)/2
    ALPHA = [copy(alpha)]

    while derivative(f,a)*derivative(f,alpha) >= 0
        a = copy(alpha)
        alpha = (a+b)/2
    end

    b = copy(alpha)

    alpha = b - (derivative(f,b))/((derivative(f,b)-derivative(f,a))/(b-a))

    while abs(derivative(f,alpha))>error && ite<8
        if derivative(f,alpha) > 0
            b = copy(alpha)
        else
            a = copy(alpha)
        end

        alpha = b - (derivative(f,b))/((derivative(f,b)-derivative(f,a))/(b-a))

        append!(A,a)
        append!(B,b)
        append!(ALPHA,alpha)
        ite+=1
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
graphD(BetterALPHA)

print("& ",round(mean(TotalX); digits=5)," & ", round(f(mean(TotalX)); digits=5), " & ", round(BetterX; digits=5), " & ", round(BetterFx; digits=5), " & ", round(WorstX; digits=5), " & ", round(WorstFx, digits=5))
