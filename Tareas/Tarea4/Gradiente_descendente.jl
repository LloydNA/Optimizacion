using Calculus

f(X) = sin(X[1]) + cos(X[2])

function Gradiente() #funciona para cualquier dimension modificando la cantidad de variables en la funcion
    X = [π,2*π] #vector de valores iniciales (aleatorio)
    alpha = 1.1 #tasa de aprendizaje (de crecimiento)
    iteraciones = 10000

    for i in 1:iteraciones
        grad = Calculus.gradient(f,X)

        for i in 1:length(X)
            X[i] += alpha*grad[i] #esto encuentra maximos, si se quieren encontrar minimos basta con restar en lugar de sumar
        end

        previous = copy(X)
    end
    
    print("x = ",X[1]," y = ",X[2]," f(x,y) = ", f(X))
end

Gradiente()