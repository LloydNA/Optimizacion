using Calculus
using Plots
using Statistics

f(X) = (1/10)*(12+X[1]^2+(1+X[1]^2)/(X[1]^2)+(100+(X[1]^2)*(X[2]^2))/((X[1]*X[2])^4)) #0 to 10
fg(x,y) = (1/10)*(12+x^2+(1+x^2)/(x^2)+(100+(x^2)*(y^2))/((x*y)^4)) #0 to 10

BestX = [0.0,0.0]
BestFX = Inf64
WorstX = [0.0,0.0]
WorstFX = -Inf64

BestXs = []

TotalX = []
TotalY = []

function graph()
    anim = @animate for i in eachindex(BestXs)
        contour(0:0.1:10,0:0.1:10,fg)
        scatter!([BestXs[i][1]],[BestXs[i][2]],color="green",label="")
    end

    gif(anim, "/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/Optimizacion/Tareas/Tarea4/Parte2/Ejercicio3/GIFS/Gradiente.gif", fps = 60)
end

function Gradiente() #funciona para cualquier dimension modificando la cantidad de variables en la funcion
    X = [5.0,5.0] #vector de valores iniciales (aleatorio)
    alpha = 0.1 #tasa de aprendizaje (de crecimiento)
    iteraciones = 1000
    CurrXs = []

    for i in 1:iteraciones
        grad = Calculus.gradient(f,X)

        for i in 1:length(X)
            X[i] -= alpha*grad[i] #esto encuentra maximos, si se quieren encontrar minimos basta con restar en lugar de sumar
        end

        push!(CurrXs,X)
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
    Gradiente()
end

print("& (",round(mean(TotalX);digits=5),", ",round(mean(TotalY);digits=5),") & ", round(f([mean(TotalX),mean(TotalY)]);digits=5)," & (",round(BestX[1];digits=5),", ",round(BestX[2];digits=5),") & ", round(BestFX;digits=5), " & (",round(WorstX[1];digits=5),", ",round(WorstX[2];digits=5),") & ",round(WorstFX;digits=5) )

graph()