using Calculus
using LinearAlgebra

f(X) = sin(X[1]) + cos(X[2])
Hf = hessian(f)
Gf = Calculus.gradient(f)

function Newton()
    tolfun = 0.001
    tolgrad = 0.001
    X = [π,2*π]

    while true
        search = (-inv(Hf(X)))*Gf(X)
        prev = copy(X)

        for i in 1:length(X)
            X[i] += search[i] #maximos con + minimos con -
        end

        if abs(f(X)-f(prev)) < tolfun || norm(Gf(X)) < tolgrad
            break
        end
    end

    print("x = ",X[1]," y = ",X[2]," f(x,y) = ", f(X))
end

Newton()