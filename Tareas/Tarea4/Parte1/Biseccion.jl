using Calculus
using Plots

f(x) = sin(x)

function graph(a,b)
    anim = @animate for i in eachindex(a)
        plot(f,0,2*π,label="f(x)")
        scatter!([a[i]],[f(a[i])],color="red",label="a")
        scatter!([b[i]],[f(b[i])],color="blue",label="b")
    end

    gif(anim, "/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/Optimizacion/Tareas/Tarea4/Parte1/GIFS/Biseccion.gif", fps = 5)
end

function BSC()
    a::Float64 = π
    b::Float64 = 2π
    error = 0.001
    needGraph = true
    A = [copy(a)]
    B = [copy(b)]

    while abs(a-b)>error
        alpha = (a+b)/2

        if derivative(f,a)*derivative(f,alpha) <= 0
            b = alpha
        else
            a = alpha
        end

        append!(A,a)
        append!(B,b)
    end

    if needGraph
        graph(A,B)
    end

    print("x = ",a," f(x) = ",f(a))
end

BSC()