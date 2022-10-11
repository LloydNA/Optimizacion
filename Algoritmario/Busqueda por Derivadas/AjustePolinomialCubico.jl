using Calculus

f(x) = sin(x)

function Cubico()
    a = π
    b = 6
    error = 0.0001

    alpha = (a+b)/2

    while derivative(f,a)*derivative(f,alpha) >= 0
        a = copy(alpha)
        alpha = (a+b)/2
    end

    b = copy(alpha)
    xbar = 0.0

    while true
        z = (3*(f(a)-f(b)))/(b-a) + derivative(f,a) + derivative(f,b)
        w = (b-a)/abs(b-a) + √(z^2-derivative(f,a)*derivative(f,b))
        u = (derivative(f,b)+w-z)/(derivative(f,b)-derivative(f,a)+2*w)

        xbar = if u < 0
            copy(b)
        elseif u>=0 && u<=1
            b-u*(b-a)
        else
            copy(a)
        end

        if abs(derivative(f,xbar)) < error
            break
        end

        if derivative(f,a)*derivative(f,xbar)<0
            b = copy(xbar)
        else
            a = copy(xbar)
        end

    end

    print("x = ",xbar," f(x) = ",f(xbar))
end

Cubico()