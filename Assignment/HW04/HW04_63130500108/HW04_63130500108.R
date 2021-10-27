
getwd()
setwd("D:/INT214")

sales <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/superstore_sales.csv")
View(sales)


library(dplyr)
library(stringr)
library(readr)
library(ggplot2)

glimpse(sales)


sales %>% group_by(City) %>% summarise(sum(Sales)) %>% 
  rename(Amount = `sum(Sales)`)

sales %>% select(Customer.Name,Sales) %>% filter(Sales > 5000)

sales %>% count(Category) 

sales %>% group_by(State) %>% summarise(TotalCity = n_distinct(City))

maxCus <- sales %>% group_by(Customer.ID) %>% summarise(Total.order = sum(!is.na(Row.ID)))
maxCus %>% select(Customer.ID,Total.order) %>% filter(Total.order == max(maxCus$Total.order,na.rm=TRUE)) 

sales %>% summarise(TotalCustomer = n_distinct(Customer.ID))


city_plot1 <- sales %>% filter(Sales >= 7000) %>% ggplot(aes(x=City,y=Sales)) + geom_point(aes(color=City))
city_plot1 + ggtitle("Sales of each city that more than 7,000")

allCat <-table(sales$`Category`)
barplot(allCat)
barplot(allCat,main = "Number of Category", xlab = "Category", ylab = "Number of Category")


