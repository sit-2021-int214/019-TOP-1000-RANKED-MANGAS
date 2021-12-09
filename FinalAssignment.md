# 019-TOP-1000-RANKED-MANGAS 📚

Datasets from: [TOP 1000 RANKED MANGAS by MyAnimeList](https://www.kaggle.com/astronautelvis/top-1000-ranked-mangas-by-myanimelist)

### About's Datasets 📜
<p>Top 1000 Ranked Mangas by MyAnimeList เป็นชุดข้อมูลเกี่ยวกับ 1000 อันดับของ Manga ที่ประกอบไปด้วย ชื่อ Manga สถานะตีพิมพ์ จำนวนตอน คะแนนความนิยม ประเภท และเรื่องย่อของ Manga เรื่องนั้น ๆ</p>

## Overview 💭
<p>กลุ่มของเราได้เลือกชุดข้อมูล Top 1000 Ranked Mangas เพื่อต้องการศึกษาความนิยม ความชื่นชอบ ประเภท รวมไปถึงว่าผู้คนส่วนใหญ่ที่ชื่นชอบ Manga ให้ความสนใจกับเรื่องอะไร มากน้อยแค่ไหน</p>
  
### Tools 🛠
- R Languange
- RStudio
- Power BI

## Steps 🪜
0. Download dataset and Library dplyr, stringr, readr, data.table + Cleaning dataset
1. Analytical Inferential Statistics
2. Data Visualization

## STEP 0
### Download dataset and library ⏳
``` ruby
# library
library(readr)
library(stringr)
library(dplyr)
library(data.table)

# dataset
Mangas <- read_csv("Desktop/R-214/top_1000.csv")
View(Mangas)
```

### Data Cleaning and Data Transformation 🧹
``` ruby
# เปลี่ยนค่าในคอลัมน์ Volumns จาก unkown ให้กลายเป็น 0
Mangas$Volumns <- str_replace(Mangas$Volumns,"unkown","0")

# เปลี่ยนชนิดข้อมูลในคอลัมน์ Volumns และ Chapters จาก String เป็น Numeric
Mangas$Volumns <- as.numeric(Mangas$Volumns)
Mangas$Chapters <- as.numeric(Mangas$Chapters)

# เปลี่ยนคอลัมน์ Publish_period จากที่จะแสดงวันตั้งแต่เริ่มขายจนถึงสิ้นสุด เปลี่ยนเป็นแค่วันเริ่มแรกที่ขายแทนและใช้ชื่อคอลัมน์เป็นPublish_dateแทน
Mangas <- Mangas %>% filter(Publish_period %like% "to")
Mangas$Publish_period <- substr(Mangas$Publish_period, 1, regexpr("to", Mangas$Publish_period)-2)
View(Mangas)
Date <- Mangas
Date <- Mangas %>% rename(Publish_date=Publish_period)
glimpse(Date)

# สร้างตาราง CountGenreManga เพื่อนับ Genre ของมังงะแต่ละเรื่อง
Mangas <- Mangas %>% mutate(CountGenreManga = str_count(Mangas$Genre, ',')+1)

# แก้ไข Column Publish_period เพิ่มเติมโดยสร้างเป็นตารางใหม่ชื่อว่า Year เพื่อเก็บปีที่ตีพิมพ์มังงะเรื่องนั้น ๆ
Mangas$Year <- substr(Mangas$Publish_period, str_length(Mangas$Publish_period)-3 , str_length(Mangas$Publish_period))
```

## STEP 2 Analytical Inferential Statistics 🔍
### ❓ Question 1: ความหลากหลายของประเภทมังงะ มีผลต่อความสนใจของผู้ใช้งานมากขึ้นหรือไม่
Hypothesis: ความหลากหลายของประเภทมังงะมีผลต่อความสนใจของผู้ใช้งาน เพราะ ยิ่งมังงะมีหลายประเภททำให้มีหลายอารมณ์ทำให้เข้าถึงกลุ่มเป้าหมายได้หลากหลายกลุ่มมากขึ้น

``` ruby
# หามังงะที่มีจำนวนความสนใจของผู้ใช้งานสูงสุดในแต่ละจำนวนประเภท
GenreManga <- Mangas %>%
  group_by(CountGenreManga) %>%
  summarize(MaxMember = max(Memebers, na.rm=TRUE))
GenreManga

# หาค่าเฉลี่ยรวมความสนใจของผู้ใช้งานสูงสุด
meanAllGenre <- sum(GenreManga$MaxMember)/12
meanAllGenre

# หาค่าเฉลี่ยของมังงะที่มี 1-6 ประเภท
LowGenre <- GenreManga %>% 
  filter(between(CountGenreManga, 1,6))
meanLowGenre <- sum(LowGenre$MaxMember)/12
meanLowGenre

# หาค่าเฉลี่ยของมังงะที่มี 7-12 ประเภท
HighGenre <- GenreManga %>% 
  filter(between(CountGenreManga, 7,12))
meanHighGenre <- sum(HighGenre$MaxMember)/12
meanHighGenre

# หาเปอร์เซ็นต์ของทั้ง 2 แบบ (1-6 ประเภท และ 7-12 ประเภท)
percent((meanLowGenre/meanAllGenre))
percent((meanHighGenre/meanAllGenre))

# หาเปอร์เซ็นต์ความต่างของการมีประเภทมังงะน้อย ๆ และการมีประเภทมังงะเยอะ ๆ
dif <- meanLowGenre - meanHighGenre
percent((dif/meanAllGenre))
```
Result: ในช่วงจำนวนประเภทมังงะ 1-6 ประเภทมีค่าเฉลี่ยความสนใจอยู่ที่ 52.56%
และในช่วงจำนวนประเภท 7-12 มีค่าเฉลี่ยความสนใจอยู่ที่ 47.44% 
เปอร์เซ็นต์ความต่างอยู่ที่ 5.11%
สรุปได้ว่า จำนวนประเภทของมังงะที่หลากหลายไม่มีผลต่อความสนใจของผู้ใช้งาน ซึ่งไม่ตรงกับสมมติฐานข้างต้น


```
# ตารางแสดงจำนวนประเภทของมังงะและมังงะที่มีจำนวนความสนใจของผู้ใช้งานสูงสุด
   CountGenreManga  MaxMember
 1               1      43798
 2               2     117051
 3               3     254989
 4               4     276311
 5               5     350621
 6               6     410522
 7               7     498886
 8               8     171047
 9               9      88817
10              10     427894
11              11      58064
12              12      67222

# ค่าเฉลี่ยรวมความสนใจของผู้ใช้งาน
mean member = 230435.2

# ข้อมูลของมังงะที่มี 1 - 6 ประเภท (มากกว่า)
mean = 121107.7
percent = 52.56%

# ข้อมูลของมังงะที่มี 7 - 12 ประเภท (น้อยกว่า)
mean = 109327.5
percent = 47.44%

# เปอร์เซ็นต์ความต่างของมังงะที่มี 1-6 ประเภท และมังงะที่มี 7-12 ประเภท
percent = 5.11%
```


### ❓ Question 2: ความนิยมของมังงะในยุคเก่ามีมากกว่ามังงะในยุคใหม่หรือไม่
Hypothesis: มังงะในยุคเก่าจะเป็นที่นิยมมากกว่า (ช่วงปี 1980 - 2000) เพราะ ความคลาสสิกของเนื้อเรื่องในสมัยก่อน อีกทั้งมังงะเก่าๆยังเป็นจุดเริ่มต้นของมังงะเรื่องใหม่ๆอีกด้วย


``` ruby
Mangas$Year <- substr(Mangas$Publish_period, str_length(Mangas$Publish_period)-3 , str_length(Mangas$Publish_period))
YearManga <- Mangas %>%
  group_by(Year) %>%
  summarize(Max = max(Favorites, na.rm=TRUE))
YearManga %>%
  arrange(desc(YearManga$Max)) %>% 
  head(n = 10L)

```
Result: แม้อันดับ 1 จะเป็นของมังงะยุคใหม่ แต่หากเทียบจากทั้ง 10 อันดับแล้วจะเห็นได้ว่าสัดส่วนความนิยมของมังงะยุคใหม่นั้นมีมากกว่าถึง 7:10 ซึ่งไม่ตรงกับสมมติฐานข้างต้น

```
   Year    Max
 1 1997  82310
 2 1989  80308
 3 2009  60533
 4 1999  40200
 5 2011  35247
 6 2007  34636
 7 2018  33419
 8 2003  27864
 9 2004  27459
10 2012  27068
```
### ❓ Question 3: สถานะการออกอากาศ(publishing,finished) มีผลต่อจำนวน members หรือไม่
Hypothesis:สถานะการออกอากาศ(publishing, finished) มีผลต่อจำนวน members เพราะ บางคนก็รอที่จะดูต่อเพราะค้างคา หรือ บางคนก็ชอบที่จะดูเรื่องที่จบไปแล้วจะได้ไม่ต้องรอและไม่ต้องค้างคา

``` ruby
Mangas2 %>% select(Title_Synonym , Status , Memebers)  %>% 
  arrange(desc(Memebers))
```
Result: พบว่าสถานะมีผลต่อ members อย่าง finished members มีจำนวนโดยรวมมากกว่า publishing 


```
 Title_Synonym    Status     Memebers
 1 Attack on Titan  Finished     498886
 2 Berserk          Publishing   427894
 3 One Piece        Publishing   410522
 4 Tokyo Ghoul      Finished     370631
 5 Naruto           Finished     350621
 6 My Hero Academia Publishing   332665
 7 One-Punch Man    Publishing   329615
 8 Death Note       Finished     315924
 9 Goodnight Punpun Finished     276311
10 Horimiya         Finished     259987
```
### ❓ Question 4: จำนวนตอน (Chapters) มีผลต่อจำนวนผู้ใช้ที่ลิสต์มังงะลงใน Favourites หรือไม่
Hypothesis: จำนวนตอน(Chapters) ไม่มีผลต่อจำนวน Favourites เพราะจำนวนตอนเยอะก็ไม่ได้หมายความว่าคนจะชอบเยอะเสมอไป


``` ruby
Mangas$Chapters %>% mean(na.rm=TRUE)

Mangas %>% 
  select(Rank, Title, Favorites, Chapters) %>% 
  arrange(Rank) %>% 
  head(n = 10L)
```
Result: พบว่ามังงะ top 10 ที่อิงจาก Favorites นั้น บางเรื่องก็มีจำนวนตอนที่ต่ำกว่าจำนวนตอนเฉลี่ยของมังงะทั้งหมด ทำให้เป็นไปตามสมมติฐาน

```
[1]101.5196

    Rank Title                                           Favorites Chapters
 1     1 Berserk                                             80308 unkown  
 2     2 JoJo no Kimyou na Bouken Part 7: Steel Ball Run     27459 96.0    
 3     3 One Piece                                           82310 unkown  
 4     4 Vagabond                                            21596 327.0   
 5     5 Monster                                             13049 162.0   
 6     6 Fullmetal Alchemist                                 26753 116.0   
 7     7 Oyasumi Punpun                                      34636 147.0   
 8     8 Grand Blue                                          11740 unkown  
 9     9 Slam Dunk                                           10289 276.0   
10    10 Kingdom                                              9881 unkown 
```

### ❓ Question 5: การ์ตูนที่ได้รับความนิยม 10 อันดับแรก(Rank) สถานะปัจจุบันเป็นอย่างไร หากตีพิมพ์จบไปแล้ว ทำไมจึงยังได้รับความนิยมมาจนถึงปัจจุบันอยู่ 
Hypothesis: การ์ตูนที่ได้รับความนิยม 10 อันดับแรก (Rank) สถานะปัจจุบันยังตีพิมพ์ไม่จบ เพราะ ยังมีความน่าติดตามต่อทำให้ได้รับความนิยมมาจนถึงปัจจุบัน


``` ruby
Mangas %>% 
  select(Rank, Title, Title_Japanese, Favorites, Publish_period, Publishing) %>% 
  arrange(Rank) %>% 
  head(n = 10L)

```
Result:  พบว่ามีมังงะจำนวน 6ใน10 เรื่องที่ติด10อันดับแรกเป็นเรืองที่ตีพิมพ์จบแล้ว ทำให้ไม่ตรงตามสมมติฐาน

```
  Rank Title                                           Title_Japanese        Favorites  Publish_period Publishing
      1 Berserk                                         ベルセルク                80308   Aug  25, 1989    TRUE      
      2 JoJo no Kimyou na Bouken Part 7: Steel Ball Run ジョジョの奇妙な冒険…       27459   Jan  19, 2004   FALSE     
      3 One Piece                                       ONE PIECE                82310   Jul  22, 1997  TRUE      
      4 Vagabond                                        バガボンド                 21596   Sep  3, 1998   FALSE     
      5 Monster                                         MONSTER                   13049  Dec  5, 1994   FALSE     
      6 Fullmetal Alchemist                             鋼の錬金術師                26753  Jul  12, 2001  FALSE     
      7 Oyasumi Punpun                                  おやすみプンプン             34636  Mar  15, 2007  FALSE     
      8 Grand Blue                                      ぐらんぶる                  11740  Apr  7, 2014   TRUE      
      9 Slam Dunk                                       SLAM DUNK                 10289  Sep  18, 1990  FALSE     
     10 Kingdom                                         キングダム                  9881    Jan  26, 2006  TRUE 
```

### ❓ Question 6: อิงจากข้อมูลของ(Rank Favorites Member Popularity) ว่ามีความสัมพันธ์ไปในทิศทางเดียวกันหรือไม่ หากไม่เป็นเพราะอะไร
Hypothesis: ข้อมูลของ(Rank Favorites Member Popularity) มีความสัมพันธ์ไปในทิศทางเดียวกัน เพราะ เมื่อmemberมาดูเยอะ ชอบและได้รับความนิยม(popularity)ทำให้ตั้งfavouritesจึงเกิดrankที่สูงขึ้น


``` ruby
Mangas %>% 
  select(Rank, Title, Popularity, Memebers, Favorites) %>% 
  arrange(Rank) %>% 
  head(n = 10L)

```
Result:  ข้อมูลของ(Rank Favorites Member Popularity) ไม่ได้มีความสัมพันธ์ไปในทิศทางเดียวกัน ทำให้ไม่ตรงตามสมมติฐาน

```
   Rank Title                                           Popularity Memebers Favorites
      1 Berserk                                                  2   427894     80308
      2 JoJo no Kimyou na Bouken Part 7: Steel Ball Run         29   160782     27459
      3 One Piece                                                3   410522     82310
      4 Vagabond                                                19   211345     21596
      5 Monster                                                 33   148764     13049
      6 Fullmetal Alchemist                                     16   236950     26753
      7 Oyasumi Punpun                                          10   276311     34636
      8 Grand Blue                                              61   118761     11740
      9 Slam Dunk                                               73   103814     10289
     10 Kingdom                                                 67   107482      9881
```

### ❓ Question 7: เปรียบเทียบแต่ละปีว่ามีการ์ตูนแนวไหนออกมาเยอะกว่ากัน โดยอิงไปถึงความชื่นชอบได้? จากข้อมูลย้อนหลัง 5 ปีที่แล้ว มังงะทั้ง 3 ประเภท ได้แก่ Action, Drama, Fantasy
Hypothesis: มังงะประเภท Action, Drama, Fantasy ยังคงเป็นที่นิยมอยู่ในปัจจุบัน เพราะ การ์ตูนส่วนใหญ่มีแต่แนวนี้เป็นหลัก


``` ruby
Year_2016 <- Mangas %>% 
  select(Title, Year, Favorites, Genre) %>% 
  filter(Year %like% 2016, (Genre %like% "Action" || Genre %like% "Drama" || Genre %like% "Fantasy"))
mean(Year_2016$Favorites, na.rm=TRUE)

Year_2017 <- Mangas %>% 
  select(Title, Year, Favorites, Genre) %>% 
  filter(Year %like% 2017, (Genre %like% "Action" || Genre %like% "Drama" || Genre %like% "Fantasy"))
mean(Year_2017$Favorites, na.rm=TRUE)

Year_2018 <- Mangas %>% 
  select(Title, Year, Favorites, Genre) %>% 
  filter(Year %like% 2018, (Genre %like% "Action" || Genre %like% "Drama" || Genre %like% "Fantasy"))
mean(Year_2018$Favorites, na.rm=TRUE)

Year_2019 <- Mangas %>% 
  select(Title, Year, Favorites, Genre) %>% 
  filter(Year %like% 2019, (Genre %like% "Action" || Genre %like% "Drama" || Genre %like% "Fantasy"))
mean(Year_2019$Favorites, na.rm=TRUE)

Year_2020 <- Mangas %>% 
  select(Title, Year, Favorites, Genre) %>% 
  filter(Year %like% 2020, (Genre %like% "Action" || Genre %like% "Drama" || Genre %like% "Fantasy"))
mean(Year_2020$Favorites, na.rm=TRUE)

mean(Mangas$Favorite)

```
Result:  จากจำนวนเฉลี่ยผู้ใช้งานที่เพิ่มมังงะเข้าลิสต์ที่ชื่นชอบมีค่าเป็น 2079.29 จะสังเกตเห็นได้ว่าค่าเฉลี่ยของทุกๆปี มีปี 2016 และ 2018 ที่มีค่ามากกว่าค่าเฉลี่ยรวม แต่ปีอื่นๆ มีค่าน้อยกว่า สังเกตเห็นได้ว่า 2019 และ 2020 มีแนวโน้มที่ลดลงอย่างชัดเจน 
สรุปได้ว่าเมื่อเทียบค่าเฉลี่ยรวมทั้ง 5 ปีสรุปได้ว่ามีค่าเฉลี่ยที่น้อยกว่าค่าเฉลี่ยรวมถึง 18.22% ซึ่งไม่ตรงตามสสมติฐาน

```
> mean(Year_2016$Favorites, na.rm=TRUE)
[1] 2462.967
> mean(Year_2017$Favorites, na.rm=TRUE)
[1] 1140.476
> mean(Year_2018$Favorites, na.rm=TRUE)
[1] 3858.594
> mean(Year_2019$Favorites, na.rm=TRUE)
[1] 628.7727
> mean(Year_2020$Favorites, na.rm=TRUE)
[1] 411.3333
> mean(Mangas$Favorites)
[1] 2079.291
```
## STEP 3 Data Visualization 🧐



## About Us 📝

งานนี้เป็นส่วนของวิชา INT214 Statistics for Information technology <br/> ภาคเรียนที่ 1 ปีการศึกษา 2564 คณะเทคโนโลยีสารสนเทศ มหาวิทยาลัยเทคโนโลยีพระจอมเกล้าธนบุรี

### Team: เซ็กซี่ยกกำลังห๊า

| NO   | NAME                 | STUDENTID   |
| :--: | -------------------- | ----------- |
| 1    | นางสาวศศิภา มณีอินทร์    | 63130500108 |
| 2    | นายสาริน วีรกุล         | 63130500115 |
| 3    | นายสิรภพ ไพเราะ       | 63130500118 |
| 4    | นางสาวสุพิชา พิริยะศิริพันธ์ | 63130500124 |
| 5    | นายอุดมชัย นิราศรพ      | 63130500161 |

### Instructor

- ATCHARA TRAN-U-RAIKUL
- JATAWAT XIE (Git: [safesit23](https://github.com/safesit23))
