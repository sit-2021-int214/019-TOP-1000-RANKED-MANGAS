# Install library
install.packages("dplyr")
install.packages("readr")
install.packages("ggplot2")
install.packages("stringr")
install.packages("data.table")
install.packages("tidyr")

# Library
library(dplyr)
library(readr)
library(ggplot2)
library(stringr)
library(data.table)
library(tidyr)

# Dataset
book <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv")
View(books)
glimpse(books)

# Q1
book %>% 
  select(Book_title,Rating) %>% 
  arrange(desc(Rating)) %>% 
  head(n = 5L)

# Q2
book$Reviews <- book$Reviews %>% str_remove(',') 
book$Reviews <- as.numeric(book$Reviews)
findMean <- book %>% 
  select(Book_title,Number_Of_Pages,Reviews) %>% 
  arrange(desc(Reviews)) %>% 
  head(n = 10L)
findMean
findMean$Number_Of_Pages %>% mean()

# Q3
# ค่าเฉลี่ยราคาหนังสือที่มี Rating ต่ำสุด 5 ลำดับท้าย
lowRating <- book %>% 
  select(Book_title,Rating,Price) %>% 
  arrange(Rating) %>% 
  head(n = 5L)
lowRating
meanLowRating <- lowRating$Price %>% mean()
meanLowRating

# ค่าเฉลี่ยราคาหนังสือที่มี Rating สูงสุด 5 ลำดับแรก
highRating <- book %>% 
  select(Book_title,Rating,Price) %>% 
  arrange(desc(Rating)) %>% 
  head(n = 5L)
highRating
meanHighRating <- highRating$Price %>% mean()
meanHighRating

# Q4
AvgBookHardcover <- book %>% 
  select(Book_title,Price,Type) %>% 
  filter(book$Type == "Hardcover")
AvgBookHardcover
AvgBookHardcover$Price %>% mean()

# Q5
BookHardcover <- book %>% 
  select(Book_title,Type,Reviews) %>% 
  filter(book$Type == "Hardcover")
BookHardcover$Reviews %>% sum()

BookKindleEdition <- book %>% 
  select(Book_title,Type,Reviews) %>% 
  filter(book$Type == "Kindle Edition")
BookKindleEdition$Reviews %>% sum()

BookPaperback <- book %>% 
  select(Book_title,Type,Reviews) %>% 
  filter(book$Type == "Paperback")
BookPaperback$Reviews %>% sum()

# Q6
book %>% 
  select(Book_title,Number_Of_Pages,Rating) %>% 
  arrange(Number_Of_Pages) %>% 
  filter(Rating >= 4.00) %>%
  head(n = 5L)

# Graph1
data <- book %>% 
  select(Price,Rating,Type) %>% 
  filter(Price <= 20.00, Rating > 3.00)
graph1 <- table(data$'Type')
barplot(graph1,main = "Book Type (Price<=20.00) and (Rating>3.00)", 
        xlab = "Type", col = c("pink","blue","yellow"))

# Graph2
graph2 <- book %>% 
  filter(Rating >= 4.00, Reviews > 0) %>%
  ggplot(aes(x=Reviews,y=Rating,group=Type))+geom_boxplot()
graph2


