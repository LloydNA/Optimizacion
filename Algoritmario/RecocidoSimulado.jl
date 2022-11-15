using Calculus
using LinearAlgebra
using Plots
using Statistics
using Distributions

f(X) = X #funcion objetivo
g(X) = X #funcion de restriccion

function RecSim()
    X = [0,0] #vector de soluciones
    iteraciones = 100
    temperatura = 100
    restriccion = 50 #valor maximo de la funcion de reestriccion
    alpha = 0.9 # factor de reduccion de temperatura

    distribucion = Normal(0,1)

    while temperatura > 2 && iteraciones >= 0
        Xk = copy(X) # solucion candidata

        for i in size(Xk)
            Xk[i] += rand(distribucion)
        end

        if g(Xk) > restriccion
            temperatura *= alpha
            continue
        end

        if f(X) > f(Xk) #si la solucion es peor, solo se acepta si la temperatura lo permite
            X = if rand(Uniform(0,1)) < exp((f(Xk) - f(X))/temperatura)
                Xk
            else
                X
            end
        else
            X = Xk
        end

        iteraciones -= 1
        temperatura *= alpha
    end
    
end