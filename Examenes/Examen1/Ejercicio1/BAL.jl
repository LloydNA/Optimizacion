using Distributions
using StatsBase
using Plots
using Statistics

f(x,y) = -20*exp(-0.2*sqrt(0.5*(x^2+y^2)))-exp(0.5*(cos(2*π*x)+cos(2*π*y)))+20+exp(1)

function graph(initialize, ranges, X)
    if initialize
        display(plot(contour(ranges,ranges,f),surface(-5:0.1:5, -5:0.1:5, f), layout = (2,1), legend = false))
        return
    end

    display(scatter!([X[1]],[X[2]],label=""))
end

function BAL()
    needPlot = false

    iterations = 1000
    randGenerator = Normal(0,0.4)
    ranges = range(-5,stop=5,length=100)
    bestX = [rand(Uniform(4.0,5.0)),rand(Uniform(4.0,5.0))]
    X = bestX
    bestZ = f(bestX[1],bestX[2])

    if needPlot
        graph(true, ranges, X)
    end

    for i in 1:iterations
        X[1] = bestX[1] + rand(randGenerator)
        X[2] = bestX[2] + rand(randGenerator)
        
        while X[1] < -5 || X[1] > 5
            X[1] = bestX[1] + rand(randGenerator)
        end

        while X[2] < -5 || X[2] > 5
            X[2] = bestX[2] + rand(randGenerator)
        end

        if f(X[1],X[2]) < bestZ
            bestX = copy(X)
            bestZ = f(X[1],X[2])
        end

        if needPlot
            graph(false, ranges, X)
        end  

       # println("Iteracion: ",i," | X1: ",X[1]," | X2: ",X[2]," | Z: ",bestZ)
    end
    
    return bestZ
end

solutions = []


for i in 1:30
    push!(solutions,BAL())
end

println("peor: ",maximum(solutions)," mejor: ",minimum(solutions)," promedio: ",mean(solutions)," Desviacion: ",std(solutions))