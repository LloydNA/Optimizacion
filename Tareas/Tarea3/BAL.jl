using Distributions
using StatsBase
using Plots
using Statistics

f(x,y) = (1/2)*(x^4-16x^2+5x + y^4-16y^2+5y)

function graph(initialize, ranges, X)
    if initialize
        display(plot(contour(ranges,ranges,f),surface(-4:0.1:4, -4:0.1:4, f), layout = (2,1), legend = false))
        return
    end

    display(scatter!([X[1]],[X[2]],label=""))
end

function BAL()
    needPlot = false

    iterations = 500
    randGenerator = Normal(0,sqrt(3))
    ranges = range(-4,stop=4,length=100)
    bestX = [rand(Uniform(4.0,6.4)),rand(Uniform(4.0,6.4))]
    X = bestX
    bestZ = f(bestX[1],bestX[2])

    if needPlot
        graph(true, ranges, X)
    end

    for i in 1:iterations
        X[1] = bestX[1] + rand(randGenerator)
        X[2] = bestX[2] + rand(randGenerator)
        
        while X[1] < -4 || X[1] > 4
            X[1] = bestX[1] + rand(randGenerator)
        end

        while X[2] < -4 || X[2] > 4
            X[2] = bestX[2] + rand(randGenerator)
        end

        if f(X[1],X[2]) < bestZ
            bestX = X
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


for i in 1:40
    push!(solutions,BAL())
    println(round(minimum(minimum.(solutions))-solutions[i],digits=3))
end

print("[",mean(solutions)-2.023*sqrt(var(solutions)/40)," , ",mean(solutions)+2.023*sqrt(var(solutions)/40),"]")