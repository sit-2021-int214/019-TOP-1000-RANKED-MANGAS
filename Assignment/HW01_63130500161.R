# Exercise 1
x <- c(10.4,5.6,3.1,6.4,21.7)
mean(x) #9.44
sum(x) #47.2
median(x) #6.4
sd(x) #7.33846
var(x) #53.853

#Exercise2
# List of Marvel movies (Order by Marvel Phase released)
marvel_movies<-list(names,years)
marvel_movies<-data.frame(names,years)
#ใช้datastructure เพื่อเก็บnames และ years ของหนังโดยการใช้data frame เพื่อดูตารางระหว่างnameกับyearsให้ง่ายและเป็นระเบียบยิ่งขึ้น
#และเป็นการเก็บแบบvector เพื่อที่จะสามารถเช็ค lengthได้และเก็บแบบdata.frame เพื่อให้ดูตารางได้ง่าย
names <- c("Iron Man","The Incredible Hulk","Iron Man 2","Thor","Captain America: The First Avenger",
           "The Avengers","Iron Man 3","Thor: The Dark World","Captain America: The Winter Soldier",
           "Guardians of the Galaxy","Avengers: Age of Ultron","Ant-Man","Captain America: Civil War",
           "Doctor Strange","Guardians of the Galaxy 2","Spider-Man: Homecoming","Thor: Ragnarok","Black Panther",
           "Avengers: Infinity War","Ant-Man and the Wasp","Captain Marvel","Avengers: Endgame",
           "Spider-Man: Far From Home","WandaVision","Falcon and the Winter Soldier","Loki","Black Widow")

# List of released year of Marvel movies
years <- c(2008,2008,2010,2011,2011,2012,2013,2013,2014,2014,2015,2015,2016,2016,
           2017,2017,2017,2017,2018,2018,2019,2019,2019,2021,2021,2021,2021)

# Or using Function
years <- c(2008,2008,2010,2011,2011,2012,rep(2013:2016,each=2),
           rep(2017,4),rep(2018,2),rep(2019,3),rep(2021,4))

length(marvel_movies$names) #27
marvel_movies$names[19] #"Avengers: Infinity War"
View(marvel_movies) #2017 and 2021 have 4 movies

