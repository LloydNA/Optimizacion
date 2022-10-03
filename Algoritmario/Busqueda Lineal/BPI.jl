using Plots

f(x) = sin(x)

function needGraph(initialize,a,b)
    if initialize
        display(plot(f,0,2*π))
    else
        display(scatter!([a],[f(a)],label=""))
        display(scatter!([b],[f(b)],label=""))
    end
end

function BPI() #Busqueda por intervalos para minimos
    paso = 1.1
    inicial = 1.5
    expansion = 1.07
    needPlot = true

    b = inicial + paso

    if f(b) > f(inicial)
        inicial,b=b,inicial
        s*=-1
    end

    if needPlot
        needGraph(true,inicial,b)
    end

    while true
        c = b + paso

        if needPlot
            needGraph(false,inicial,b)
            sleep(0.5)
        end

        if f(c) > f(b)
            if inicial > c
                inicial,c=c,inicial
                break
            end
            continue
        end
        inicial = copy(b)
        b = copy(c)
        paso*=expansion

    end
    
    print("[",inicial,", ",c,"]")
end

BPI()