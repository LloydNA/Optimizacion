using Calculus
using Plots
using Statistics

f(X) = X[1]^3+X[2]^2+X[3] #-2 to 2

BestX = [0.0,0.0,0.0]
BestFX = Inf64
WorstX = [0.0,0.0,0.0]
WorstFX = -Inf64

BestXs = []

TotalX = []
TotalY = []
TotalZ = []

function Gradiente() #funciona para cualquier dimension modificando la cantidad de variables en la funcion
    X = [0.9,0.9,0.9] #vector de valores iniciales (aleatorio)
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
    append!(TotalZ,X[3])

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

print("& (",round(mean(TotalX);digits=5),", ",round(mean(TotalY);digits=5),", ",round(mean(TotalZ);digits=5),") & ", round(f([mean(TotalX),mean(TotalY),mean(TotalZ)]);digits=5)," & (",round(BestX[1];digits=5),", ",round(BestX[2];digits=5),", ",round(BestX[3];digits=5),") & ", round(BestFX;digits=5), " & (",round(WorstX[1];digits=5),", ",round(WorstX[2];digits=5),", ",round(WorstX[3];digits=5),") & ",round(WorstFX;digits=5) )
