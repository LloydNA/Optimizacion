using Calculus

f(x) = sin(x)

function Secante()
    a = π
    b = 6
    error = 0.0001

    alpha = (a+b)/2

    while derivative(f,a)*derivative(f,alpha) >= 0
        a = copy(alpha)
        alpha = (a+b)/2
    end

    b = copy(alpha)

    alpha = b - (derivative(f,b))/((derivative(f,b)-derivative(f,a))/(b-a))

    while abs(derivative(f,alpha))>error
        if derivative(f,alpha) > 0
            b = copy(alpha)
        else
            a = copy(alpha)
        end

        alpha = b - (derivative(f,b))/((derivative(f,b)-derivative(f,a))/(b-a))
    end

    print("X = ",alpha," f(X) = ",f(alpha))
end

Secante()