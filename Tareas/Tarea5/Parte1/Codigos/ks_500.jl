using Distributions

function f(X,P) #funcion objetivo
    result = 0

    for i in eachindex(X)
        if X[i] == 1
            result += P[i]
        end
    end

    return result
end 

function g(X,W) #funcion de restriccion
    result = 0

    for i in eachindex(X)
        if X[i] == 1
            result += W[i]
        end
    end

    return result
end  

function RecSim()
    X = []
    P = []
    W = []

    restriccion = 0

    open("/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/Optimizacion/Tareas/Tarea5/Parte1/Datasets/ks_500_0") do f
        d = readline(f)
        
        a, b = split(d," ")
        a = parse(Int64, a)
        b = parse(Int64, b)

        X = zeros(a)
        restriccion = b

        while !eof(f)
            d = readline(f)
        
            a, b = split(d," ")
            a = parse(Int64, a)
            b = parse(Int64, b)

            append!(P,a)
            append!(W,b)
        end
    end

    iteraciones = 1000000
    temperatura = 100000.0

    alpha = 0.9 # factor de reduccion de temperatura

    distribucion = Normal(0,1)

    while temperatura > 1 && iteraciones >= 0
        Xk = copy(X) # solucion candidata

        for i in eachindex(Xk)
            Xk[i] = if rand(distribucion) > 2
                1
            else
                0
            end
        end

        if g(Xk, W) > restriccion
            temperatura *= alpha
            continue
        end

        if f(X, P) > f(Xk, P) #si la solucion es peor, solo se acepta si la temperatura lo permite
            X = if rand(Uniform(0,1)) < exp((f(Xk, P) - f(X, P))/temperatura)
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

    return [f(X,P),g(X,W)]
end

Best = [-1,-1]
Worst = [Inf,Inf]
Average = [0.0,0.0]

for i in 1:50
    res=RecSim()

    Average[1] += res[1]
    Average[2] += res[2]

    if res[1] > Best[1]
        Best[1] = copy(res[1])
        Best[2] = copy(res[2])
    end

    if res[1] < Worst[1]
        Worst[1] = copy(res[1])
        Worst[2] = copy(res[2])
    end
end

Average[1] /= 50
Average[2] /= 50

print("& ",Best[1]," & ",Best[2]," & ",Worst[1]," & ",Worst[2]," & ",Average[1]," & ",Average[2])