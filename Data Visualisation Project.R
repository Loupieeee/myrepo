library(readr)
library(data.table)

df <- fread('Economist_Assignment_Data.csv', drop = 1)

head(df)

#shape = 1 <- different numbers equal different shapes
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

pl <- ggplot(df, aes(x=CPI, y=HDI, color=Region)) + geom_point(size=4,shape=1)
pl2 <- pl + geom_smooth(aes(group=1),method='lm',formula = y~log(x),se=F,color='red')
pl3 <- pl2 + geom_text(aes(label = Country),color="gray20",
                       data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)
pl4 <- pl3 + theme_economist_white() + 
  scale_x_continuous(limits = c(.9,10.5),breaks = 1:10)


