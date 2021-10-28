#Install packages
install.packages("dplyr")
install.packages("readr")
install.packages("ggplot2")
install.packages("stringr")
install.packages("tidyr")
# Library
library(dplyr)
library(readr)
library(ggplot2)
library(stringr)
library(tidyr)
# Dataset
progbook <- read_csv("RstudioCsv/prog_book.csv")
View(progbook)
progbook %>% glimpse()

#1
progbook %>% 
  select(Book_title,Rating) %>% 
  arrange(desc(Rating)) %>% 
  head(n = 5L)
#2
progbook %>% 
  select(Book_title,Reviews) %>% 
  arrange(desc(Reviews)) %>% 
  head(n = 5L)
#3
progbook %>% 
  select(Book_title,Price,Rating) %>% 
  filter(Price < 20)%>%
  arrange(desc(Rating)) %>% 
  head(n = 5L)
#4
str_subset(progbook$Book_title,"Web")
#5
progbook %>%
  filter(stringr::str_detect(Description,"hack")) %>%
  select(Book_title,Description)
#6
progbook %>% 
  select(Book_title,Number_Of_Pages) %>% 
  filter(Number_Of_Pages<200)%>%
  arrange(Number_Of_Pages) 

#part4

#part4.1
Plot1 <- progbook %>% filter(Price<30) %>% ggplot(aes(x=Price,y=Rating)) + geom_point()
Plot1
#part4.2
bookfiltered <- progbook %>% 
  select(Reviews,Type) %>% 
  filter(Reviews>500)
graph <- table(bookfiltered$Type)
barplot(graph,main = "Book Type", 
        xlab = "BookType", col = c("red","green","blue"))
