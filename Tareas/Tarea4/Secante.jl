using Calculus
using GLMakie

f(x) = sin(x)

image = lines(range(0,10,length=100),f, color = :blue)
pointa = scatter!([0],[0],color="red")
pointb = scatter!([0],[0],color="red")

function graph(a,b)
    delete!(image.axis, pointa)
    delete!(image.axis, pointb)

    global pointa = scatter!([a],[f(a)],color="red")
    global pointb = scatter!([b],[f(b)],color="red")

    sleep(0.5)
    display(image)
end

function Secante()
    a = π
    b = 6
    error = 0.0001
    needGraph=true

    alpha = (a+b)/2

    while derivative(f,a)*derivative(f,alpha) >= 0
        a = copy(alpha)
        alpha = (a+b)/2
    end

    b = copy(alpha)

    alpha = b - (derivative(f,b))/((derivative(f,b)-derivative(f,a))/(b-a))

    while abs(derivative(f,alpha))>error
        if needGraph
            graph(a,b)
        end

        if derivative(f,alpha) > 0
            b = copy(alpha)
        else
            a = copy(alpha)
        end

        alpha = b - (derivative(f,b))/((derivative(f,b)-derivative(f,a))/(b-a))
    end

    print("X = ",alpha," f(X) = ",f(alpha))
end

Secante()