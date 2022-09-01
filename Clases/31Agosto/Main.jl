using StatsBase
using Distributions
using Plots

f(x,y)=(1/2)*(x^4-16x^2+5x + y^4-16y^2+5y)

function main()
    k = 300
    X = [4.0,4.0]
    B = [0.0,0.0]
    K = [rand(Normal(0,3)),rand(Normal(0,3))]
    best = typemax(Float64)

    xs = ys = range(-4,stop=4,length=100)

    display(plot(contour(xs,ys,f),surface(-4:0.1:4,-4:0.1:4,f,reuse=false),layout=[1,2]))

    for i in 0:k
        curr = [10.0,10.0]
        while curr[1]<-8 || curr[1]>8
            K[1]=rand(Normal(0,3))
            curr[1]=X[1]+B[1]+K[1]
        end
        while curr[2]<-8 || curr[2]>8
            K[2]=rand(Normal(0,3))
            curr[2]=X[2]+B[2]+K[2]
        end

        if f(curr[1],curr[2])<best
            X[1]=curr[1]
            X[2]=curr[2]
            B[1]=0.2*B[1]+0.4*K[1]
            B[2]=0.2*B[2]+0.4*K[2]
            best=f(curr[1],curr[2])
        

        elseif curr[1]-2*K[1]>=-8 && curr[1]-2*K[1]<=8 && curr[2]-2*K[2]>=-8 && curr[2]-2*K[2]<=8
            curr[1]-=2*K[1]
            curr[2]-=2*K[2]

            if f(curr[1],curr[2])<best
                X[1]=curr[1]
                X[2]=curr[2]
                B[1]-=0.4*K[1]
                B[2]-=0.4*K[2]
                best=f(curr[1],curr[2])
            end
        else
            B[1]/=2
            B[2]/=2
            continue
        end

        display(scatter!([X[1]],[X[2]],label=""))
        #sleep(0.1)
        println("It:",i," X1 = ",X[1]," X2 = ",X[2], " Z = ",best)
    end

end

main()