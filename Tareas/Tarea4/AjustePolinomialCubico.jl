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

function Cubico()
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
    xbar = 0.0

    while true
        z = (3*(f(a)-f(b)))/(b-a) + derivative(f,a) + derivative(f,b)
        w = (b-a)/abs(b-a) + √(z^2-derivative(f,a)*derivative(f,b))
        u = (derivative(f,b)+w-z)/(derivative(f,b)-derivative(f,a)+2*w)

        if needGraph
            graph(a,b)
        end

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

    end

    print("x = ",xbar," f(x) = ",f(xbar))
end

Cubico()