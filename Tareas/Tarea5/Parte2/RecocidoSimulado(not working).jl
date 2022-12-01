using Distributions
using Plots

limitsX = [0,0]
limitsY = [0,0]
colors = 0

function graph()
    result = scatter([0],[0],color = "black", label = "")

    for i in eachindex(Best[3])
        currentColor = rand(0:255)
        for j in eachindex(Best[3][i])
            scatter!([Best[5][Best[3][i][j]][1]], [Best[5][Best[3][i][j]][2]], color=currentColor, label="")
        end
    end

    savefig(result, "Tareas/Tarea5/Parte2/Codigos/k-center7")
end

function f(X,P,maxcent) #funcion objetivo
    center = findmax(X)[2]

    D = getDistances(P)
    C = findCenters(center,maxcent, D)

    Groups = []

    for i in 1:maxcent
        tempa = []
        append!(tempa,i)
        push!(Groups,tempa)
    end

    GroupsDistances = zeros(maxcent)

    for i in eachindex(P)
        candidate = 0
        dist = Inf

        for j in eachindex(C)
            if D[i][C[j]] < dist
                candidate = j
                dist = D[i][C[j]]
            end
        end

        append!(Groups[candidate],i)
        GroupsDistances[candidate] += dist
    end

    result = sum(GroupsDistances)

    return [result, C, Groups, GroupsDistances, P]
end 

function getDistances(P)
    D = []
    for i in eachindex(P)
        tempD = []
        for j in eachindex(P)
            append!(tempD,sqrt((P[i][1]-P[j][1])^2 + (P[i][1]-P[j][1])^2))
        end

        push!(D,tempD)
    end

    return D
end

function findCenters(center, maxcent,D)
    C = [center]

    for i in 1:maxcent
        tempc = 0
        best = 0

        for j in eachindex(D[center])
            tempsum = 0

            for k in eachindex(C)
                tempsum += D[C[k]][j]
            end

            if tempsum > best
                best = tempsum
                tempc = j
            end
        end

        append!(C,tempc)
    end

    return C
end

function RecSim()
    X = [] #selector de centro
    P = [] #puntos

    restriccion = 0 #numero de centros

    open("/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/Optimizacion/Tareas/Tarea5/Parte2/Datasets/kcenter-7") do f
        d = readline(f)
        
        a, b = split(d," ")
        a = parse(Int64, a)
        b = parse(Int64, b)

        X = zeros(a)
        restriccion = b
        colors = restriccion

        while !eof(f)
            d = readline(f)
        
            a, b, c = split(d," ")
            a = parse(Int64, a)
            b = parse(Int64, b)
            c = parse(Int64, c)

            if b < limitsX[1]
                limitsX[1] = b
            end
            if b > limitsX[2]
                limitsX[2] = b
            end

            if c < limitsY[1]
                limitsY[1] = c
            end
            if c < limitsY[2]
                limitsY[2] = c
            end

            temp = [b,c]

            push!(P,temp)
        end
    end

    iteraciones = 100
    temperatura = 100000.0

    alpha = 0.9 # factor de reduccion de temperatura

    distribucion = Normal(0,1)

    for i in eachindex(X)
        X[i] += rand(distribucion)
    end

    while iteraciones >= 0
        Xk = copy(X) # solucion candidata

        for i in eachindex(Xk)
            Xk[i] += rand(distribucion)
        end

        tempResult = [f(X, P, restriccion)[1], f(Xk, P, restriccion)[1]]

        if tempResult[1] < tempResult[2] #si la solucion es peor, solo se acepta si la temperatura lo permite
            X = if rand(Uniform(0,1)) < exp((tempResult[2] - tempResult[1])/temperatura)
                copy(Xk)
            else
                X
            end
        else
            X = copy(Xk)
        end

        iteraciones -= 1
        temperatura *= alpha
    end

    return f(X, P, restriccion)
end

Best = [] #[result, C, Groups, GroupsDistances]
Worst = []
Average = 0

for i in 1:1
    res=RecSim()

    global Average += res[1]

    if isempty(Best) || res[1] < Best[1]
        global Best = copy(res)
    end

    if isempty(Worst) || res[1] > Worst[1]
        global Worst = copy(res)
    end
end

Average /= 50

graph()

#print("& ",Best[1]," & ",Best[2]," & ",Worst[1]," & ",Worst[2]," & ",Average[1]," & ",Average[2])