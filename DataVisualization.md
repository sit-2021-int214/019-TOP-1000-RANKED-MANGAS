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


## STEP 0
### Download dataset and library ⏳
``` ruby
# library
library(readr)
library(stringr)
library(dplyr)
library(data.table)
library(formattable)

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

# เปลี่ยนชื่อตาราง Memebers เป็น Members
Mangas <- rename(Mangas, Members = Memebers)
```

## DETAILS 🔍
### ❓ Question: ความหลากหลายของประเภทมังงะ มีผลต่อความสนใจของผู้อ่านมากขึ้นหรือไม่
``` ruby
# หามังงะที่มีจำนวนความสนใจของผู้ใช้งานสูงสุดในแต่ละจำนวนประเภท
GenreManga <- Mangas %>%
  group_by(CountGenreManga) %>%
  summarize(MaxMember = max(Members, na.rm=TRUE))
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
Result: ในช่วงจำนวนประเภทมังงะ 1-6 ประเภทมีค่าเฉลี่ยความสนใจของผู้อ่านอยู่ที่ 52.56%
และในช่วงจำนวนประเภท 7-12 มีค่าเฉลี่ยความสนใจของผู้อ่านอยู่ที่ 47.44% 
เปอร์เซ็นต์ความต่างอยู่ที่ 5.11%
```
ตารางแสดงจำนวนประเภทของมังงะและมังงะที่มีจำนวนความสนใจของผู้อ่านสูงสุด
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

ค่าเฉลี่ยรวมความสนใจของผู้อ่าน = 230435.2

ข้อมูลของมังงะที่มี 1-6 ประเภท(มากกว่า)
mean = 121107.7
percent = 52.56%

ข้อมูลของมังงะที่มี 7-12 ประเภท(น้อยกว่า)
mean = 109327.5
percent = 47.44%

เปอร์เซ็นต์ความต่างของมังงะที่มี 1-6 ประเภท และมังงะที่มี 7-12 ประเภท = 5.11%
```


### ❓ Question: มังงะในยุคเก่า(ช่วงปี 1980 - 2000)มีความนิยมมากกว่ามังงะในยุคใหม่หรือไม่
``` ruby
# หา 10 อันดับแรกของมังงะที่มีจำนวนความชื่นชอบสูงสุดในแต่ละปี
YearManga <- Mangas %>%
  group_by(Year) %>%
  summarize(MaxFavorites = max(Favorites, na.rm=TRUE)) %>%
  arrange(desc(YearManga$Max)) %>% 
  head(n = 10L)
YearManga

# จำนวนมังงะในยุคเก่า(1980-2000)ใน 10 อันดับแรก
oldManga <- YearManga %>% 
  filter(between(Year, 1980,2000)) %>%
  count()
oldManga

# จำนวนมังงะในยุคใหม่(2001-2021)ใน 10 อันดับแรก
NewManga <- YearManga %>% 
  filter(between(Year, 2001,2021)) %>%
  count()
NewManga
```
Result: แม้อันดับ 1 จะเป็นของมังงะยุคใหม่ แต่หากเทียบจากทั้ง 10 อันดับแล้วจะเห็นได้ว่าสัดส่วนความนิยมของมังงะยุคใหม่นั้นมีมากกว่าถึง 7:10
```
ตารางแสดง 10 อันดับแรกของมังงะที่มีจำนวนความชื่นชอบของผู้อ่านสูงสุดในแต่ละปี
   Year  MaxFavorites
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

จำนวนมังงะในยุคเก่า(1980-2000)ใน 10 อันดับแรก = 3
จำนวนมังงะในยุคใหม่(2001-2021)ใน 10 อันดับแรก = 7
```

### ❓ Question: จำนวนตอน(Chapters)ที่มาก ส่งผลให้จำนวนความชื่นชอบของผู้อ่านลดน้อยลงหรือไม่
``` ruby
# หาตารางแสดงผล 10 อันดับแรกที่มีจำนวนตอนเยอะที่สุด
ListChapterManga <- Mangas %>% 
  select(Title, Favorites, Chapters) %>% 
  arrange(desc(Chapters)) %>% 
  head(n = 10L)
ListChapterManga

# ค่าเฉลี่ยความชื่นชอบในมังงะของตารางข้างต้น
ListChapterManga$Favorites %>% mean(na.rm=TRUE)

# ค่าเฉลี่ยความชื่นชอบในมังงะของทั้งหมด
Mangas$Favorites %>% mean(na.rm=TRUE)
```
Result: จากผลลัพธ์พบว่าค่าเฉลี่ยความชื่นชอบของผู้อ่านจาก 10 อันดับแรกของมังงะที่มีจำนวนตอนมากที่สุดมีค่าเฉลี่ยมากกว่าค่าเฉลี่ยรวมทั้งหมด ทำให้สรุปได้ว่ามังงะที่มีจำนวนตอนเยอะไม่ส่งผลให้ความชื่นชอบของผู้อ่านลดน้อยลง
```
ตารางแสดง 10 อันดับแรกของมังงะที่มีจำนวนตอนมากที่สุด
   Title                           Favorites Chapters
 1 Crayon Shin-chan                      226     1126
 2 Kyoukaisenjou no Horizon               92      872
 3 Doraemon                              748      821
 4 Major                                 110      747
 5 Initial D                            1114      724
 6 Gintama                              7559      709
 7 Naruto                              40200      700
 8 Shijou Saikyou no Deshi Kenichi      3275      584
 9 Hayate no Gotoku!                    1870      570
10 Usogui                                250      541

ค่าเฉลี่ยความชื่นชอบในมังงะของตารางข้างต้น = 5544.4
ค่าเฉลี่ยความชื่นชอบในมังงะของทั้งหมด = 2079.291
```

### ❓ Question: มังงะที่ได้รับความนิยม 10 อันดับแรก(Rank) สถานะปัจจุบันเป็นอย่างไร หากตีพิมพ์จบไปแล้ว ทำไมจึงยังได้รับความนิยมมาจนถึงปัจจุบันอยู่ 
``` ruby
Mangas %>% 
  select(Rank, Title, Title_Japanese, Favorites, Publish_period, Publishing) %>% 
  arrange(Rank) %>% 
  head(n = 10L)

```
Result: พบว่ามีมังงะจำนวน 6ใน10 เรื่องที่ติด10อันดับแรกเป็นเรืองที่ตีพิมพ์จบแล้ว

```
  Rank Title                                            Title_Japanese        Favorites  Publish_period  Publishing
      1 Berserk                                         ベルセルク                 80308    Aug  25, 1989       TRUE      
      2 JoJo no Kimyou na Bouken Part 7: Steel Ball Run ジョジョの奇妙な冒険…        27459    Jan  19, 2004      FALSE     
      3 One Piece                                       ONE PIECE                82310     Jul  22, 1997       TRUE      
      4 Vagabond                                        バガボンド                 21596     Sep  3, 1998       FALSE     
      5 Monster                                         MONSTER                  13049     Dec  5, 1994       FALSE     
      6 Fullmetal Alchemist                             鋼の錬金術師               26753    Jul  12, 2001       FALSE     
      7 Oyasumi Punpun                                  おやすみプンプン            34636    Mar  15, 2007       FALSE     
      8 Grand Blue                                      ぐらんぶる                 11740     Apr  7, 2014        TRUE      
      9 Slam Dunk                                       SLAM DUNK                10289    Sep  18, 1990       FALSE     
     10 Kingdom                                         キングダム                 9881     Jan  26, 2006        TRUE 
```

### ❓ Question: อิงจากข้อมูลของRank, Favorites, Member, Popularity ว่ามีความสัมพันธ์ไปในทิศทางเดียวกันหรือไม่
``` ruby
Mangas %>% 
  select(Rank, Title, Popularity, Memebers, Favorites) %>% 
  arrange(Rank) %>% 
  head(n = 10L)

```
Result:  ข้อมูลของ Rank, Favorites, Member, Popularity ไม่ได้มีความสัมพันธ์ไปในทิศทางเดียวกัน

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
Result:  จากจำนวนเฉลี่ยผู้ใช้งานที่เพิ่มมังงะเข้าลิสต์ที่ชื่นชอบมีค่าเป็น 2079.29 จะสังเกตเห็นได้ว่าค่าเฉลี่ยของทุกๆปี มีปี 2016 และ 2018 ที่มีค่ามากกว่าค่าเฉลี่ยรวม แต่ปีอื่นๆ มีค่าน้อยกว่า สังเกตเห็นได้ว่า 2019 และ 2020 มีแนวโน้มที่ลดลงอย่างชัดเจน สรุปได้ว่าเมื่อเทียบค่าเฉลี่ยรวมทั้ง 5 ปีสรุปได้ว่ามีค่าเฉลี่ยที่น้อยกว่าค่าเฉลี่ยรวมถึง 18.22%

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
