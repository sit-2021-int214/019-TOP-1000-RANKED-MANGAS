install.packages("dplyr")
install.packages("readr")
install.packages("ggplot2")
install.packages("stringr")
install.packages("tidyr")

library(dplyr)
library(readr)
library(ggplot2)
library(stringr)
library(tidyr)

progbook <- read_csv("Desktop/R-214/programingbook.csv")
View(progbook)

progbook %>% glimpse()

#1
progbook %>% 
  select(Book_title,Price,Reviews) %>% 
  arrange(desc(Reviews)) %>% 
  head(n = 5L)

progbook %>% 
  select(Book_title,Price,Reviews) %>% 
  arrange(Reviews) %>% 
  head(n = 5L)

#2
str_subset(progbook$Book_title,"Game")



#3
progbook %>% select(Type) %>% table()


#4
progbook %>% select(Book_title,Number_Of_Pages) %>% 
  filter(Number_Of_Pages < 130) %>% arrange(desc(Number_Of_Pages))

#5
Rate <- progbook %>% 
  select(Book_title,Price,Rating) %>%
filter(Rating > 4) %>% 
  arrange(desc(Rating))
Rate

#6 find percentage of all book per type
countBookType <- progbook %>% group_by(Type) %>% count()
countBookType %>% mutate(average=(n/270)*100)


#part4
showPlot <- progbook%>%ggplot(aes(x=Rating,y=Reviews))+geom_point()
showPlot
#part4.1
booktype <- table(progbook$'Type')
barplot(booktype,main = "BookType", 
        xlab = "Type",  col = c("yellow","lightgreen","lightblue"))


