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

function BALM()
    needPlot = false

    iterations = 300
    randGenerator = Normal(0,1)
    ranges = range(-4,stop=4,length=100)
    bestX = [rand(Uniform(-4.0,4.0)),rand(Uniform(-4.0,4.0))]
    X = bestX
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
        
        while X[1] < -4 || X[1] > 4
            randHolder[1] = rand(randGenerator)
            X[1] = bestX[1] + randHolder[1] + B[1]
        end

        while X[2] < -4 || X[2] > 4
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

            while X[1] < -4 || X[1] > 4
                randHolder[1] = rand(randGenerator)
                X[1] = bestX[1] - randHolder[1] + B[1]
            end
    
            while X[2] < -4 || X[2] > 4
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

        println("Iteracion: ",i," | X1: ",X[1]," | X2: ",X[2]," | Z: ",bestZ)
    end
    
    println("Best: Z = ",bestZ," X1 = ",bestX[1]," X2 = ",bestX[2])
end

BALM()