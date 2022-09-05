using Distributions
using StatsBase
using Plots

f(x,y) = (1/2)*(x^4-16x^2+5x + y^4-16y^2+5y)

function graph(initialize, ranges, X)
    if initialize
        display(plot(contour(ranges,ranges,f),surface(-4:0.1:4, -4:0.1:4, f), layout = (2,1), legend = false))
        return
    end

    display(scatter!([X[1]],[X[2]],label=""))
end

function BAS()
    needPlot = true

    iterations = 300
    randGenerator = Uniform(-4.0,4.0)
    ranges = range(-4,stop=4,length=100)
    X = [0.0,0.0]
    bestX = [rand(Uniform(4.0,6.4)),rand(Uniform(4.0,6.4))]
    bestZ = f(bestX[1],bestX[2])

    if needPlot
        graph(true, ranges, X)
    end

    for i in 1:iterations
        X = [rand(randGenerator),rand(randGenerator)]

        if f(X[1],X[2]) < bestZ
            bestX = X
            bestZ = f(X[1],X[2])
        end

        if needPlot
            graph(false, ranges, X)
        end  

        println("Iteracion: ",i," | X1: ",X[1]," | X2: ",X[2]," | Z: ",bestZ)
    end
    
    println("Best: Z = ",bestZ," X1 = ",bestX[1]," X2 = ",bestX[2])
end

BAS()