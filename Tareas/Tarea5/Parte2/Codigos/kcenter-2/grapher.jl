using Plots

limitsX = [0,0]
limitsY = [0,0]

function graph()
    P,C=dataGetter()
    colors = []
    for i in eachindex(C)
        curr = rand(0:255)
        while curr in colors
            curr = rand(0:255)
        end
        append!(colors,curr)
    end

    centers=plot(bg=:black)
    tiny=plot(bg=:black)
    result=plot(bg=:black)

    for i in eachindex(C)
        X = []
        Y = []

        current = split(C[i]," ")

        for j in eachindex(current)
            if j==1
                continue
            end

            if current[j] == ""
                continue
            end

            append!(X,P[parse(Int64,current[j])+1][1])
            append!(Y,P[parse(Int64,current[j])+1][2])
        end

        scatter!(result,X,Y,label="",color=colors[i])
        scatter!(tiny,X,Y,label="",color=colors[i],markersize=0.2)
        scatter!(centers,[X[1]],[Y[1]],label="",color=colors[i])
    end

    savefig(result,"/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/Optimizacion/Tareas/Tarea5/Parte2/Codigos/kcenter-2/GraficaColors.png")
    savefig(tiny,"/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/Optimizacion/Tareas/Tarea5/Parte2/Codigos/kcenter-2/GraficaTiny.png")
    savefig(centers,"/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/Optimizacion/Tareas/Tarea5/Parte2/Codigos/kcenter-2/GraficaCenters.png")
end

function dataGetter()
    P = [] #puntos
    bC = [] #mejores centros

    sum = 0.0
    bsum = Inf64*1.0
    wsum = 0.0
    psum = 0.0

    open("/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/Optimizacion/Tareas/Tarea5/Parte2/Datasets/kcenter-2") do f
        d = readline(f)

        while !eof(f)
            d = readline(f)
            d = replace(d,"\t"=>" ")

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

    for i in 1:1:49
        open("/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/Optimizacion/Tareas/Tarea5/Parte2/Codigos/kcenter-2/kcenter2/kcenter-2r"*string(i)*".txt") do f
            d = readline(f)
            sum = parse(Float64, d)

            wsum = max(sum,wsum)
            psum += sum

            if sum < bsum
                bC = []
                bsum = copy(sum)

                while !eof(f)
                    d = readline(f)
                    push!(bC,d)
                end
            end
        end
    end

    print(bsum," & ",psum/50," & ",wsum)
    return [P,bC]
end

graph()