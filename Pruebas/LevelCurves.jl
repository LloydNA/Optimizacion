using Plots

f(x,y)=(1/2)*(x^4-16x^2+5x + y^4-16y^2+5y)

xs = ys = range(-4,stop=4,length=100)

contour(xs,ys,f)