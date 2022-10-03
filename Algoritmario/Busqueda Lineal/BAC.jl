using Plots

f(x) = sin(x)

function needGraph()
    
end

function BAC() #Busqueda de ajuste cuadratico
    iteraciones = 1000
    a = π
    b = 2*π
    c = 3*π
    optima = 0
    needPlot = true

    for i in 1:iteraciones
        optima = (1/2)*((f(a)*(b^2-c^2)+f(b)*(c^2-a^2)+f(c)*(a^2-b^2))/(f(a)*(b-c)+f(b)*(c-a)+f(c)*(a-b)))

        if optima > b
            if f(optima) > f(b)
                c = optima
            else
                a = b
                b = optima
            end

        elseif optima < b
            if f(optima) > f(b)
                a = optima
            else
                c = b
                b = optima
            end
        end 
    end

    print("x = ",b, " f(x) = ",f(b))
end

BAC()