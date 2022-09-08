using Distributions
using StatsBase
using Plots
using Statistics

f(x,y) = -x*sin(sqrt(abs(x)))-y*sin(sqrt(abs(y)))

function graph(initialize, ranges, X)
    if initialize
        display(contour(ranges,ranges,f))
        return
    end

    display(scatter!([X[1]],[X[2]],label=""))
end

function BAL()
    needPlot = false

    iterations = 10000
    randGenerator = Normal(0,60)
    ranges = range(-500,stop=500,length=1000)
    bestX = [rand(Uniform(0.0,100.0)),rand(Uniform(0.0,100.0))]
    X = copy(bestX)
    bestZ = f(bestX[1],bestX[2])

    if needPlot
        graph(true, ranges, X)
    end

    for i in 1:iterations
        X[1] = bestX[1] + rand(randGenerator)
        X[2] = bestX[2] + rand(randGenerator)
        
        while X[1] < -500 || X[1] > 500
            X[1] = bestX[1] + rand(randGenerator)
        end

        while X[2] < -500 || X[2] > 500
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