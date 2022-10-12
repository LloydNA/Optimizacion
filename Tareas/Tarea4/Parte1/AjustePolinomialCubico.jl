using Calculus
using Plots

f(x) = sin(x)

function graph(a,b,alpha)
    anim = @animate for i in eachindex(a)
        plot(f,0,2*π,label="f(x)")
        scatter!([a[i]],[f(a[i])],color="red",label="a")
        scatter!([b[i]],[f(b[i])],color="blue",label="b")
        scatter!([alpha[i]],[f(alpha[i])],color="green",label="xbar")
    end

    gif(anim, "/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/Optimizacion/Tareas/Tarea4/Parte1/GIFS/AjustePolinomialCubico.gif", fps = 5)
end

function Cubico()
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
    xbar = 0.0

    while true
        z = (3*(f(a)-f(b)))/(b-a) + derivative(f,a) + derivative(f,b)
        w = (b-a)/abs(b-a) + √(z^2-derivative(f,a)*derivative(f,b))
        u = (derivative(f,b)+w-z)/(derivative(f,b)-derivative(f,a)+2*w)

        xbar = if u < 0
            copy(b)
        elseif u>=0 && u<=1
            b-u*(b-a)
        else
            copy(a)
        end

        if abs(derivative(f,xbar)) < error
            break
        end

        if derivative(f,a)*derivative(f,xbar)<0
            b = copy(xbar)
        else
            a = copy(xbar)
        end

        append!(A,a)
        append!(B,b)
        append!(ALPHA,xbar)
    end

    if needGraph
        graph(B,A,ALPHA)
    end
    print("x = ",xbar," f(x) = ",f(xbar))
end

Cubico()