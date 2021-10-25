#install library
install.packages("dplyr")
install.packages("readr")
install.packages("ggplot2")
install.packages("stringr")

library(dplyr)
library(readr)
library(ggplot2)
library(stringr)

#Load Data
book <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv")
View(book)

#Part A
#1. Explore the dataset
glimpse(book)
#2 tidyverse (stringr)
 # Book title that about C++
  book %>% 
  filter(stringr::str_detect(Book_title,"C++")) %>% 
  group_by(Type) %>% 
  select(Book_title,Rating,Price,Type) %>%
  arrange(desc(Rating))
#3 Transform data with dplyr and finding insight the data 

 #3.1 Average Price of each book type
  book %>% 
  select(Type, Price) %>% 
  group_by(Type) %>% 
  summarise(Price = mean(Price, na.rm = T))
    
 #3.2 type ebook and show only 5 row
  book %>% 
  select(Book_title,Rating,Price) %>% 
  arrange(desc(Book_title)) %>%
  head(n = 5L) 
  
 #3.3 page last than 150 page 
  book %>%
  select(Book_title,eNumber_Of_Pages)
  filter(Number_Of_Pages <= 150)

 #3.4 max rating  
  book %>% 
  select(Book_title,Rating) %>%
  filter(Rating == max(Rating));
  
 #3.5 Overall average rating and overall average pages
  book %>% 
  select(Book_title,Price) %>% 
  filter(Price == min(Price));
  
 #3.6 count type
  book %>%
  group_by(Type) %>% count()

#Part 4   
 #4.1 all price bar graphs
 ggplot(book,aes(x = Price)) + geom_bar()
  

 #4.2 scatter plot of price and Rating
  book %>% 
  filter(Rating > mean(Rating))%>% 
  ggplot(aes(x=Rating,y=Price))+geom_point(aes(color= Type ))+geom_smooth()
