batting <- read.csv('Batting.csv')
str(batting)

head(batting$AB)
head(batting$X2B)

batting$BA <- batting$H / batting$AB
tail(batting$BA, 5)

batting$OBP <- (batting$H + batting$BB + batting$HBP) / (batting$AB + batting$BB + batting$HBP + batting$SF)

batting$X1B <- batting$H - batting$X2B - batting$X3B - batting$HR

batting$SLG <- ((1 * batting$X1B) + (2 * batting$X2B) + (3 * batting$X3B) + (4 * batting$HR)) / batting$AB

str(batting)

sal <- read.csv('Salaries.csv')
summary(batting)

batting <- subset(batting, yearID >= 1985)

combo <- merge(batting, sal, by=c('playerID','yearID'))

summary(combo)


# Analysing the Lost Players ----------------------------------------------

lost_players <- subset(combo, playerID %in% c('giambja01','damonjo01', 'saenzol01'))

lost_players <- subset(lost_players, yearID==2001)

lost_players <- lost_players[,c('playerID','H','X2B','X3B','HR','OBP','SLG','BA','AB')]



# Replacement Players -----------------------------------------------------

combo <- subset(combo, yearID==2001)

ggplot(combo, aes(x=OBP, y=salary)) + geom_point(size=2)

combo <- subset(combo, salary < 8000000 & OBP >0 & AB >= 450)
str(combo)

options <- head(arrange(combo, desc(OBP)), 10)

options <- options[,c('playerID','OBP','AB','salary')]

options <- options[2:4,]
