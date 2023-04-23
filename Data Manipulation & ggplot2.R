v <- 1:5

addrand <- function(x){
  ran <- sample(1:100,1)
  return(x+ran)
}
result<- lapply(v, addrand)
print(result)

times2 <- function(num){
  return(num*2)
}

print(v)
result <- sapply(v, times2)

print(result)



# Anonymous Functions -----------------------------------------------------

v <- 1:5

result <- sapply(v, function(num){num*2})
print(result)



# Apply with multiple inputs ----------------------------------------------

v <- 1:5 

add_choice <- function(num, choice){
  return(num + choice)
}

print(add_choice(2,10))

print(sapply(v, add_choice, choice = 100))



# Regular Expressions -----------------------------------------------------

# grepl <- general regular expressions . Logical
# grep  <- general regular expressions . Index

text <- "Hi there, do you know who you are voting for?"

grepl("voting", text) #term voting is in the text

v <-c('a', 'b', 'c', 'd', 'd')

grepl('b', v) # return boolean value

grep('b', v) # b occurred in 2nd place


# Date and Timestamps -----------------------------------------------------

today <- Sys.Date()
class(today)

my.date <- as.Date("Nov-03-90", format = "%b-%d-%y")

my.date

# %d Day of the month (decimal number)
# %m Month (decimal number)
# %b Month (abbreviated)
# %B Month (full name)
# %y Year (2 digits)
# %Y Year (4 digits)

as.POSIXct("11:02:03", format = "%H:%M:%S") #handles various data types

help(strptime)

strptime("11:02:03", format = "%H:%M:%S") #handles just charaters


# Data Manipulation -------------------------------------------------------
library(dplyr)
library(nycflights13)

head(flights)
summary(flights)

# filter and slice
# arrange
# select and rename
# distinct
# mutate and transmute
# summarise
# sample_n and sample_frac

head(filter(flights, month == 11, day == 3, carrier == "AA"))

slice(flights, 1:10)

head(arrange(flights, year, month, day, arr_time))

head(arrange(flights, year, month, day, desc(arr_time)))

head(select(flights, carrier, arr_time))

head(rename(flights, airline_carrier = carrier))

distinct(select(flights, carrier))

head(mutate(flights, new_col = arr_delay - dep_delay))

#transmute will only bring back the new column created
head(transmute(flights, new_col = arr_delay - dep_delay)) 

#aggregate of all the data
summarise(flights, avg_air_time = mean(air_time, na.rm = TRUE))

#randomly bring back 10 rows
sample_n(flights, 10)

slice_sample(flights, n=5)


#randomly back back 10% of the rows
sample_frac(flights, 0.1)

slice_sample(flights, prop = 0.1)

# Pipe Operator -----------------------------------------------------------

df <- mtcars

#Nesting
result <- arrange(sample_n(filter(df, mpg>20), size = 5), desc(mpg))

#Multiple Assignments
a <- filter(df, mpg>20)
b <- sample_n(a, size = 5)
c <- arrange(b, desc(mpg))

#Pipe Operator
result <- df |> filter(mpg>20) |> sample_n(5) |>  arrange(desc(mpg))



# TidyR -------------------------------------------------------------------

library(tidyr)
install.packages("data.table")
library(data.table)

# gather()

#Create a data frame 
comp <- c(1,1,1,2,2,2,3,3,3)
yr <- c(1998,1999,2000,1998,1999,2000,1998,1999,2000)
q1 <- runif(9, min=0, max=100)
q2 <- runif(9, min=0, max=100)
q3 <- runif(9, min=0, max=100)
q4 <- runif(9, min=0, max=100)

df <- data.frame(comp=comp,year=yr,Qtr1 = q1,Qtr2 = q2,Qtr3 = q3,Qtr4 = q4)

#Gathers columns 
gather(df, Quarter, Revenue, Qtr1:Qtr4)

df |>  gather(Quarter, Revenue, Qtr1:Qtr4)

#More made up data
stocks <- data.frame(
  time = as.Date('2009-01-01') + 0:9,
  X = rnorm(10, 0, 1),
  Y = rnorm(10, 0, 2),
  Z = rnorm(10, 0, 4)
)
stocks

stocks.gathered <- stocks |> gather(stock, price, X:Z)

stocks.gathered |> spread(stock, price)


# Separate
df <- data.frame(new.col = c(NA, "a.x", "b.y", "c.z"))

separate(df, new.col, c("ABC", "XYZ"))

df <- data.frame(new.col = c(NA, "a-x", "b-y", "c-z"))

df.sep <- separate(df, new.col, c("abc", "xyc"), sep = "-")

#Unite
unite(df.sep, new.joined.col, abc, xyc, sep = "---")


# Data Visualisation ------------------------------------------------------

library(ggplot2)

#1st layer is the Data. 2nd layer isAesthetics (x,y)
pl <- ggplot(data = mtcars, aes (x=mpg,y = hp))

#3rd layer is the geometry layer
pl + geom_point()

#Optional extra 3 layers: Facets, Statistics & Coordinates
#Facets allow us to put multiple plots on a single canvas
pl <- ggplot(data = mtcars, aes(x=mpg,y = hp)) +geom_point()
#Facet (separate plots on single canvas)) & Stats
pl2 <- pl + facet_grid(cyl ~.) + stat_smooth()
#Coordinates
pl2 + coord_cartesian(xlim = c(15,25))

#Finally, can customise via themes


# Histograms --------------------------------------------------------------
install.packages("ggplot2movies")

library(ggplot2movies)

#DATA & AESTHETICS
pl <- ggplot(movies, aes(x = rating))

#Geometry layer ## alpha = fill transparency
pl2 <- pl + geom_histogram(binwidth = 0.1, color='red', fill = 'pink', alpha=0.4)

#Labels
pl3 <- pl2 + xlab('Movie Rating') + ylab('Count')

#Plot Title
pl3 + ggtitle('MY TITLE')

#Fill out the colour based on the count of the histogram
pl4 <- pl + geom_histogram(binwidth = 0.1, aes(fill = ..count..))



# Scatterplots ------------------------------------------------------------

df <- mtcars

#Data & Aesthetics
pl <- ggplot(df, aes(x=wt, y=mpg))

#Geometry. Size = size of circles
pl + geom_point(alpha = 0.5, size = 5)

pl + geom_point(aes(size = hp))

pl + geom_point(aes(size=factor(cyl)))

pl + geom_point(aes(shape=factor(cyl)), size = 2)

pl + geom_point(aes(shape=factor(cyl), color=factor(cyl)), size = 2)


pl + geom_point(size = 5, color='#43e8d8')

pl5 <- pl + geom_point(size = 5, aes(color=hp))
pl6 <- pl5 + scale_color_gradient(low = '#56ea29', high = 'red')



# Barplots ----------------------------------------------------------------
library(ggplot2)

df <- mpg


#Class is a column in the data. Using categorically data instead of continuous data like in histogram
pl <- ggplot(df, aes(x=class))

pl + geom_bar(aes(fill=drv))

#Shows drv side by side
pl + geom_bar(aes(fill=drv), position = "dodge")

#Shows % instead of instances
pl + geom_bar(aes(fill=drv), position = "fill")



# Boxplots ----------------------------------------------------------------
df <- mtcars

# x axis needs to be a categorical value
pl <- ggplot(df, aes(x=factor(cyl),y=mpg))

pl + geom_boxplot() + coord_flip()

pl + geom_boxplot(aes(fill=factor(cyl))) + theme_dark()




# 2 Variable Plotting -----------------------------------------------------
library(ggplot2movies)

pl <- ggplot(movies, aes(x = year, y = rating))

pl2 <- pl + geom_bin2d(binwidth=c(3,2)) + scale_fill_gradient(high = 'red',low = 'blue')

pl3 <- pl + geom_hex() + scale_fill_gradient(high = 'red',low = 'blue')

pl4 <- pl + geom_density2d()



# Coordinates and Faceting ------------------------------------------------

pl <- ggplot(mpg, aes(x=displ, y=hwy)) + geom_point()
pl2 <- pl + coord_cartesian(xlim = c(1,4), ylim = c(15,30))

#Fixing the aspect ratio. By default it is 1/1
pl <- ggplot(mpg, aes(x=displ, y=hwy)) + geom_point()
pl3 <- pl + coord_fixed(ratio = 1/3)


#Facets - multiple plots
pl <- ggplot(mpg, aes(x=displ, y=hwy)) + geom_point()

#cyl is column want to separate by. Facet by on y axis ~ Facet by on x axis. A full stop = everything
pl + facet_grid(. ~ cyl)

pl + facet_grid(drv ~ .)

pl + facet_grid(drv ~ cyl)



# Themes ------------------------------------------------------------------

library(ggplot2)

#Set theme for all plots
#theme_set(theme_minimal())

pl <- ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()

#Set theme for individual plots
pl + theme_dark()

install.packages('ggthemes')
library(ggthemes)

pl <- ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()
pl + theme_wsj()



# ggplot2 Exercises -------------------------------------------------------

#1.
pl <- ggplot(mpg, aes(x = hwy)) + geom_histogram(bins = 30, fill = 'red', alpha = 0.5)

#2.
pl2 <- ggplot(mpg, aes(x = manufacturer)) + geom_bar(aes(fill = factor(cyl)))

#3.
head(txhousing)

pl3 <- ggplot(txhousing, aes(x = sales, y= volume)) + geom_point(color='blue',alpha=0.3)

pl4 <- pl3 + geom_smooth(color='red')









