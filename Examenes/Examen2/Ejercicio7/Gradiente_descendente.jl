using Calculus
using Plots
using Statistics

f(X) = (100*(X[2]-X[1]^2))^2+(1-X[1])^2+90*(X[4]-X[3]^2)^2+(1-X[3])^2+10.1*((X[2]-1)^2+(X[4]-1)^2)+19.8*(X[2]-1)*(X[4]-1)

BestX = [0.0,0.0,0.0,0.0]
BestFX = Inf64
WorstX = [0.0,0.0,0.0,0.0]
WorstFX = -Inf64

BestXs = []

TotalX = []
TotalY = []
TotalZ = []
TotalA = []

function Gradiente() #funciona para cualquier dimension modificando la cantidad de variables en la funcion
    X = [4.0,4.0,4.0,4.0] #vector de valores iniciales (aleatorio)
    alpha = 0.000001 #tasa de aprendizaje (de crecimiento)
    iteraciones = 1000000
    CurrXs = []

    push!(CurrXs,X)

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
    append!(TotalA,X[4])

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

print("& (",round(mean(TotalX);digits=5),", ",round(mean(TotalY);digits=5),", ",round(mean(TotalZ);digits=5),", ",round(mean(TotalA);digits=5),") & ", round(f([mean(TotalX),mean(TotalY),mean(TotalZ),mean(TotalA)]);digits=5)," & (",round(BestX[1];digits=5),", ",round(BestX[2];digits=5),", ",round(BestX[3];digits=5),", ",round(BestX[4];digits=5),") & ", round(BestFX;digits=5), " & (",round(WorstX[1];digits=5),", ",round(WorstX[2];digits=5),", ",round(WorstX[3];digits=5),", ",round(WorstX[4];digits=5),") & ",round(WorstFX;digits=5) )