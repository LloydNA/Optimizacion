f(x,y)=125*x+150*y
a(x,y)=6*x+11*y
b(x,y)=8*x+9*y

function main()
    best=0.0
    better=[0.0,0.0]

    for x in 0:0.1:20
        for y in 0:0.1:20
            if a(x,y)<=66 && b(x,y)<=72 && f(x,y)>best
                best=f(x,y)
                better=[x,y]
            end

        end
    end

    println("X: ",better[1]," Y: ",better[2]," Z: ",best)
end

main()