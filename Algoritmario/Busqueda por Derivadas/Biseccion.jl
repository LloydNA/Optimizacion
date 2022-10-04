using Calculus
using Plots

f(x) = sin(x)

function graph(initialize,a,b)
    if !initialize
        scatter!(image,[a],[f(a)],label="a")
        scatter!(image,[b],[f(b)],label="b")

        sleep(0.5)
        Plots.series_list[end][:linealpha] = 0.0
    else
        plot!(f,0,2*π)
    end

    display(image)
end

function BSC()
    a = π
    b = 2π
    error = 0.001
    needGraph = true

    if needGraph
        graph(true,a,b)
    end

    while abs(a-b)>error
        alpha = (a+b)/2

        if needGraph
            graph(false,a,b)
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