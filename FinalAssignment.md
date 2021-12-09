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
GenreManga <- Mangas %>%
  group_by(CountGenreManga) %>%
  summarize(MaxMember = max(Memebers, na.rm=TRUE))
GenreManga
```
Result: ในช่วงจำนวนประเภทมังงะ 1-6 ประเภทมีค่าเฉลี่ยความสนใจอยู่ที่ 242,214.33
และในช่วง 7-12 มีค่าเฉลี่ยความสนใจอยู่ที่ 218,655.00 เปอร์เซ็นต์ความต่างอยู่ที่ 9.73% 
สรุปได้ว่า จำนวนประเภทของมังงะที่หลากหลายไม่มีผลต่อความสนใจของผู้ใช้งาน ซึ่งไม่ตรงกับสมมติฐานข้างต้น


```
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
```


### ❓ Question 2: ความนิยมของมังงะในยุคเก่ามีมากกว่ามังงะในยุคใหม่ 
Hypothesis: มังงะในยุคเก่าจะเป็นที่นิยมมากกว่า (ช่วงปี 2000) เพราะ ความคลาสสิกของเนื้อเรื่องในสมัยก่อน อีกทั้งมังงะเก่าๆยังเป็นจุดเริ่มต้นของมังงะเรื่องใหม่ๆอีกด้วย


``` ruby
Mangas$Year <- substr(Mangas$Publish_period, str_length(Mangas$Publish_period)-3 , str_length(Mangas$Publish_period))
YearManga <- Mangas %>%
  group_by(Year) %>%
  summarize(Max = max(Favorites, na.rm=TRUE))
YearManga %>%
  arrange(desc(YearManga$Max)) %>% 
  head(n = 10L)

```
Result: มังงะในยุคเก่าจะเป็นที่นิยมมากกว่ามังงะในยุคใหม่ ซึ่งตรงตามสมมติฐานข้างต้น

```
   Year    Max
 1 sent  82310
 2 2021  60533
 3 2014  40200
 4 2013  34636
 5 2020  33419
 6 2006  27864
 7 2011  27459
 8 2010  26753
 9 2015  21596
10 2018  16210
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
