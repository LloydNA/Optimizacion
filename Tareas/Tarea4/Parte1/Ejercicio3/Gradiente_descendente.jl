using Calculus
using Plots
using Statistics

f(x) = 2*(x-3)^2+exp(0.5*x^2) #0-100

function graph(a)
    anim = @animate for i in eachindex(a)
        plot(f,0,100,label="f(x)")
        scatter!([a[i]],[f(a[i])],color="red",label="x")
    end

    gif(anim, "/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/Optimizacion/Tareas/Tarea4/Parte1/Ejercicio3/GIFS/Gradiente.gif", fps = 15)
end

BetterX::Float64 = 0
BetterFx::Float64 = Inf64
WorstX::Float64 = 0
WorstFx::Float64 = -Inf64

BetterXs = []

TotalX = []

function Gradiente() #funciona para cualquier dimension modificando la cantidad de variables en la funcion
    X::Float64 = 2 #vector de valores iniciales (aleatorio)
    alpha = 0.1 #tasa de aprendizaje (de crecimiento)
    iteraciones = 100
    ThisX = [copy(X)]

    for i in 1:iteraciones
        grad::Float64 = derivative(f,X)

        X -= alpha*grad #esto encuentra maximos, si se quieren encontrar minimos basta con restar en lugar de sumar

        append!(ThisX, copy(X))
    end
    
    append!(TotalX,X)

    if f(X) < BetterFx
        global BetterFx = f(X)
        global BetterX = X
        global BetterXs = ThisX
    end

    if f(X) > WorstFx
        global WorstFx = f(X)
        global WorstX = X
    end
end

for i in 1:1000
    Gradiente()
end

print("& ",round(mean(TotalX); digits=5)," & ", round(f(mean(TotalX)); digits=5), " & ", round(BetterX; digits=5), " & ", round(BetterFx; digits=5), " & ", round(WorstX; digits=5), " & ", round(WorstFx, digits=5))
graph(BetterXs)