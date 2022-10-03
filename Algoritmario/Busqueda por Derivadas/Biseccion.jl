using Calculus
using Makie
using GLMakie

f(x) = sin(x)

image = lines(range(0, stop = 4*π, length = 200),f,color = :blue)

function graph(initialize,first,a,b)
    if !initialize
        if first
            pop!(image.plots)
            pop!(image.plots)
        end
        scatter!(image,[a],[f(a)],label="a")
        scatter!(image,[b],[f(b)],label="b")
    end

    display(image)
end

function BSC()
    a = π
    b = 2π
    error = 0.001
    needGraph = true
    first = false

    if needGraph
        graph(true,true,a,b)
    end

    while abs(a-b)>error
        alpha = (a+b)/2

        if needGraph
            graph(false,first,a,b)
            first = true
            sleep(0.5)
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