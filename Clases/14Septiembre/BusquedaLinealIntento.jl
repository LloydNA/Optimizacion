using Plots

f(x)=sin(x)+0.5*x

function main()
    range = [-10,10]
    tolerance = 0.001
    a = range[1]
    b = range[2]

    display(plot(f,range[1],range[2]))
    while abs(a-b) > tolerance
        if f(a)>f(b)
            a,b = b,a
        end

        mid = (a+b)/2

        if f(mid)<f(a) && f(mid)<f(b)
            a,b = mid,a
        elseif f(mid)>f(a) && f(mid)<f(b)
            b = copy(mid)
            if f(a-mid)<f(a)
                a -= mid
            else
                a += mid
            end
        else
            b = copy(a)
            if f(a-mid)<f(a)
                a -= mid
            else
                a += mid
            end
        end
        display(scatter!([a],[f(a)],label="",color="blue"))
        display(scatter!([b],[f(b)],label="",color="red"))
        sleep(0.1)
    end

    println("f(a) = ",f(a)," x = ",a)
    print("f(b) = ",f(b)," x = ",b)
    
    
end

main()