#Generating random data, graphics 

#runif is random uniforms on 01
x = runif(50)

#rnorm is random normal variables (e.g. 1,2,3,4,...)
y = rnorm(50)


#Plot x and y
plot(x,y)

plot(x, y, xlab = "Random Uniform", ylab = "Random Normal", pch = "*", col = "blue")

#Show me two plots/graphs (two rows and one column)
par(mfrow = c(2,1))

plot(x,y)
hist(y)

#Reset to one plot/graph
par(mfrow=c(1,1))


library(ISLR2)

summary(Auto)
names(Auto)
#Data frames are like a matrix except that the columns can be variables of different kinds
class(Auto)

plot(Auto$cylinders, Auto$mpg)

#Attach creates a workspace with all the named variable in your workspace
attach(Auto)

search()

plot(cylinders, mpg)

#If make cylinders as a factor and then plot it, it'll make it into a boxplot
cylinders=as.factor(cylinders)
plot(cylinders, mpg)


