using Calculus
using Plots

f(x) = sin(x)

function graph(a,b,alpha)
    anim = @animate for i in eachindex(a)
        plot(f,0,2*π,label="f(x)")
        scatter!([a[i]],[f(a[i])],color="red",label="a")
        scatter!([b[i]],[f(b[i])],color="blue",label="b")
        scatter!([alpha[i]],[f(alpha[i])],color="green",label="alpha")
    end

    gif(anim, "/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/Optimizacion/Tareas/Tarea4/Parte1/GIFS/Secante.gif", fps = 5)
end

function Secante()
    a::Float64 = π
    b::Float64 = 6
    error = 0.0001
    needGraph=true
    A = [copy(a)]
    B = [copy(b)]

    alpha = (a+b)/2
    ALPHA = [copy(alpha)]

    while derivative(f,a)*derivative(f,alpha) >= 0
        a = copy(alpha)
        alpha = (a+b)/2
    end

    b = copy(alpha)

    alpha = b - (derivative(f,b))/((derivative(f,b)-derivative(f,a))/(b-a))

    while abs(derivative(f,alpha))>error
        if derivative(f,alpha) > 0
            b = copy(alpha)
        else
            a = copy(alpha)
        end

        alpha = b - (derivative(f,b))/((derivative(f,b)-derivative(f,a))/(b-a))

        append!(A,a)
        append!(B,b)
        append!(ALPHA,alpha)
    end

    if needGraph
        graph(A,B,ALPHA)
    end
    print("X = ",alpha," f(X) = ",f(alpha))
end

Secante()