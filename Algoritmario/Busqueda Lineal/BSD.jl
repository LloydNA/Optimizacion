using Plots

f(x) = sin(x)

function needGraph()
    
end

function BSD() #Busqueda de la seccion dorada
    ϕ = (1+sqrt(big(5)))/2

    error = .0001
    inicialInf = π
    inicialSup = 2*π
    needPlot = true

    alpha1 = inicialInf*(1-1/ϕ) + inicialSup/ϕ
    alpha2 = inicialInf/ϕ + inicialSup*(1-1/ϕ)

    while abs(f(alpha1)-f(alpha2))>error
        if f(alpha1) > f(alpha2)
            inicialSup = alpha1
            alpha1 = alpha2
            alpha2 = inicialInf/ϕ + inicialSup*(1-1/ϕ)
        else
            inicialInf = alpha2
            alpha2 = alpha1
            alpha1 = inicialInf*(1-1/ϕ) + inicialSup/ϕ
        end
    end

    print("x = ",alpha1, " f(x) = ",f(alpha1))
end

BSD()