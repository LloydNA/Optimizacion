using Plots

f(x)=x^4-20*x^3+0.1*x

df(x,h)=((f(x+h)-f(x))/h)

function main()
    limits=[0,20]
    steps = 4.0
    delta = .01
    best = [0.0,df(0.0,delta)]

    display(plot(f,0,20))
    while steps>0.001
        if df(best[1]+steps,delta)<0.0
            best[1]+=steps
            best[2]=df(best[1],delta)

            display(scatter!([best[1]],[f(best[1])],label="",color="blue"))
            sleep(0.2)
        else
            steps/=2
        end
    end
    
    println("f(",best[1],") = ",f(best[1]))
end

main()