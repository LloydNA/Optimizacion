using Calculus
using GLMakie

f(x) = sin(x)

image = lines(range(0,10,length=100),f, color = :blue)
pointa = scatter!([0],[0],color="red")
pointb = scatter!([0],[0],color="red")

function graph(a,b)
    anim = @animate for i in 1:a.

    gif(anim, "/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/Optimizacion/Tareas/Tarea4/Biseccion.gif", fps = 24)
end

function BSC()
    a = π
    b = 2π
    error = 0.001
    needGraph = true
    A = []
    B = []

    while abs(a-b)>error
        alpha = (a+b)/2

        if needGraph
            graph(a,b)
        end

        if derivative(f,a)*derivative(f,alpha) <= 0
            b = alpha
        else
            a = alpha
        end
    end

    print("x = ",a," f(x) = ",f(a))
end

BSC()