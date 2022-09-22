using Distributions
using StatsBase
using Plots

f(x,y) = -x*sin(sqrt(abs(x)))-y*sin(sqrt(abs(y)))

function graph(initialize, ranges, X)
    if initialize
        display(contour(ranges,ranges,f))
        return
    end

    display(scatter!([X[1]],[X[2]],label=""))
end

function BALM()
    needPlot = true

    iterations = 10000
    randGenerator = Normal(0,60)
    ranges = range(-500,stop=500,length=1000)
    bestX = [rand(Uniform(0.0,100.0)),rand(Uniform(0.0,100.0))]
    X = copy(bestX)
    randHolder = [0.0,0.0]
    B = [0.0,0.0]
    bestZ = f(bestX[1],bestX[2])

    if needPlot
        graph(true, ranges, X)
    end

    for i in 1:iterations
        randHolder = [rand(randGenerator),rand(randGenerator)]
        X[1] = bestX[1] + randHolder[1] + B[1]
        X[2] = bestX[2] + randHolder[2] + B[2]
        
        while X[1] < -500 || X[1] > 500
            randHolder[1] = rand(randGenerator)
            X[1] = bestX[1] + randHolder[1] + B[1]
        end

        while X[2] < -500 || X[2] > 500
            randHolder[2] = rand(randGenerator)
            X[2] = bestX[2] + randHolder[2] + B[2]
        end

        if f(X[1],X[2]) < bestZ
            bestX = copy(X)

            B[1] = 0.2*B[1] + 0.4*randHolder[1]
            B[2] = 0.2*B[2] + 0.4*randHolder[2]

            bestZ = f(X[1],X[2])

        else
            X[1] = bestX[1] - randHolder[1] + B[1]
            X[2] = bestX[2] - randHolder[2] + B[2]

            while X[1] < -500 || X[1] > 500
                randHolder[1] = rand(randGenerator)
                X[1] = bestX[1] - randHolder[1] + B[1]
            end
    
            while X[2] < -500 || X[2] > 500
                randHolder[2] = rand(randGenerator)
                X[2] = bestX[2] - randHolder[2] + B[2]
            end

            if f(X[1],X[2]) < bestZ
                bestX = copy(X)

                B[1] -= 0.4*randHolder[1]
                B[2] -= 0.4*randHolder[2]

                bestZ = f(X[1],X[2])
            end
        end
    

        if needPlot
            graph(false, ranges, X)
        end  

        #println("Iteracion: ",i," | X1: ",X[1]," | X2: ",X[2]," | Z: ",bestZ)
    end
    
    #println("Best: Z = ",bestZ," X1 = ",bestX[1]," X2 = ",bestX[2])
    return bestZ
end

solutions = []

for i in 1:30
    push!(solutions,BALM())
end

println("peor: ",maximum(solutions)," mejor: ",minimum(solutions)," promedio: ",mean(solutions)," Desviacion: ",std(solutions))