# 019-TOP-1000-RANKED-MANGAS 📚

Datasets from: [TOP 1000 RANKED MANGAS by MyAnimeList](https://www.kaggle.com/astronautelvis/top-1000-ranked-mangas-by-myanimelist)

### About's Datasets
<p>Top 1000 Ranked Mangas by MyAnimeList เป็นชุดข้อมูลเกี่ยวกับ 1000 อันดับของ Manga ที่ประกอบไปด้วย ชื่อ Manga สถานะตีพิมพ์ จำนวนตอน คะแนนความนิยม ประเภท และเรื่องย่อของ Manga เรื่องนั้น ๆ</p>

## Overview
<p>กลุ่มของเราได้เลือกชุดข้อมูล Top 1000 Ranked Mangas เพื่อต้องการศึกษาความนิยม ความชื่นชอบ ประเภท รวมไปถึงว่าผู้คนส่วนใหญ่ที่ชื่นชอบ Manga ให้ความสนใจกับเรื่องอะไร มากน้อยแค่ไหน</p>
  
### Tools
- R Languange
- RStudio

## Steps
1. Download dataset Top 1000 Mangas and save into folder R-214 on the Desktop
2. Explore the dataset from the original dataset
3. Exploratory Data Analysis
4. Download Library dplyr, stringr, readr
5. Cleaning dataset
6. Define questions

## Data Exploration
```
library(readr)
Mangas <- read_csv("Desktop/R-214/top_1000.csv")
View(Mangas)

head(Mangas)
str(Mangas)
colnames(Mangas)
rownames(Mangas)
glimpse(Mangas)
```

| ลำดับ | ชื่อคอลัมน์              | คำอธิบาย         |  เก็บข้อมูลในรูปแบบ         | ตัวอย่างข้อมูล                        |
| :--: | -------------------- | -----------     |  --------------------   | -------------------------------- |
| 1    | Index of Manga       | ลำดับของมังงะ     | ...1 = col_double()     | 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,... |
| 2    | Title                | ชื่อเรื่องของมังงะ   | Title = col_character() | "Berserk", "JoJo no Kimyou na Bouken Part 7: Steel Ball Run",... |
| 3    | Title_Synonym        | ชื่อเรียกแฝงของมังงะ| Title_Synonym = col_character()     | Doukyuusei ก็จะมีอีกชื่อเรียกว่า Classmates |
| 4    | Title_Japanese       | ชื่อเรื่องของมังงะแบบภาษาญี่ปุ่น   | Title_Japanese = col_character() | "ベルセルク", "ジョジョの奇妙な冒険 Part7 STEEL BALL RUN",... |
| 5    | Status               | มังงะเรื่องนี้มีสถานะเป็นอย่างไร (Finished=จบแล้ว / Publishing=อยู่ในระหว่างการตีพิมพ์ / On Hiatus=หยุดตีพิมพ์ชั่วคราว)    | Status = col_character()     | "Publishing", "Finished", "Publishing", "On Hiatus",… |
| 6    | Volumns              | จำนวนเล่มที่ตีพิมพ์จนจบ หากถ้าเกิดเรื่องไหนยังไม่จบ ช่องนี้จะมีค่าเป็น unknown   | Volumns = col_character() | "unkown", "24.0", "unkown", "37.0",… |
| 7    | Chapters        | จำนวนตอนของมังงะเรื่องนั้น ๆ จนจบ หากถ้าเกิดเรื่องไหนยังไม่จบ ช่องนี้จะมีค่าเป็น unknown| Chapters = col_character()     | "unkown", "96.0", "unkown", "327.0", "162.0", "116.0",... |
| 8    | Publishing       | ชื่อเรื่องของมังงะแบบภาษาญี่ปุ่น   | Publishing = col_logical() | TRUE, FALSE, TRUE, FALSE, FALSE,... |
| 9    | Rank        | อันดับของมังงะ โดยอิงจาก MAL(https://myanimelist.net)| Rank = col_double()     | 1, 2, 3, 4, 5, 6, 7, 8, 9,... |
| 10   | Score        | คะแนนของมังงะเรื่องนั้น ๆ โดย MAL(https://myanimelist.net)| Score = col_double()     | 9.39, 9.23, 9.15, 9.13, 9.10,...|
| 11   | Scored_by       | จำนวนคนที่โหวตให้กับมังงะเรื่องนั้น ๆ   | Scored_by = col_double() | 201756, 94427, 249936, 72613, 57801, 130375,... |
| 12   | Popularity       | อันดับความนิยมของผู้อ่าน   | Popularity = col_double() | 2, 29, 3, 19, 33, 16, 10,... |
| 13   | Memebers        | จำนวนผู้ใช้งานในเว็บไซต์ MAL(https://myanimelist.net) ที่เพิ่มมังงะเรื่องนั้นเข้าลิสต์มังงะที่อยากอ่าน (reading list) ของตนเอง| Memebers = col_double()     | 427894, 160782, 410522, 211345, 148764,... |
| 14   | Favorites        | จำนวนผู้ใช้งานในเว็บไซต์ MAL(https://myanimelist.net) ที่เพิ่มมังงะเรื่องนั้นเข้าลิสต์มังงะที่ชื่นชอบ (favorite list) ของตนเอง| Favorites = col_double()     | 80308, 27459, 82310, 21596, 13049,... |
| 15   | Synopsis       | เรื่องย่อของมังงะ   | Synopsis = col_character() | "Guts, a former mercenary now known as the \"Black... |
| 16   | Publish_period        | ช่วงเวลาที่ตีพิมพ์ ตั้งแต่เริ่มต้นถึงสิ้นสุด หากเรื่องไหนยังไม่จบจะเขียนตอนท้ายว่า to present| Publish_period = col_character()     | "Aug  25, 1989 to present", "Jan  19, 2004 to Apr  19, 2011",... |
| 17   | Genre       | ประเภทของมังงะเรื่องนั้น ๆ   | Genre = col_character() | Attack On Titan มีประเภทดังนี้ 'Action', 'Mystery', 'Drama', 'Fantasy', 'Shounen', 'Super Power', 'Military' |

## Data Cleaning and Data Transformation
```
โค้ดจงมาอยู่นี่
```

## Data Analysis with Descriptive Statistics

### ❓ Question 1: TOP 5 ความนิยม(Popularity) มังงะที่ตีพิมพ์จบแล้ว
``` ruby
Mangas %>% 
  select(Title,Popularity,Publishing) %>% 
  filter(Publishing == TRUE) %>% 
  arrange(Popularity) %>% 
  head(n = 5L)
```
Result: สามารถนำข้อมูลไปใช้ดูมังงะที่จบแล้วและมีความยอดนิยม(Popularity) สำหรับกลุ่มลูกค้าที่ต้องการอ่านเรื่องที่นิยมและจบแล้ว
จะเห็นได้ว่ามังงะที่จบแล้วและได้รับความนิยมเป็น 5 อันดับแรกประกอบด้วย Berserk, One Piece, Boku no Hero Academia, One Punch-Man, Solo Leveling
```
  Title                 Popularity Publishing  
1 Berserk                        2 TRUE      
2 One Piece                      3 TRUE      
3 Boku no Hero Academia          6 TRUE      
4 One Punch-Man                  7 TRUE      
5 Solo Leveling                 13 TRUE 
```

### ❓ Question 2: TOP 5 อันดับ(Rank)มังงะที่ตีพิมพ์จบแล้ว ที่มีจำนวนตอน(Chapters)ไม่เกิน 24 ตอน
```
Mangas %>% 
  select(Title,Chapters,Rank) %>% 
  filter(Mangas$Chapters <= 24) %>% 
  arrange(Rank) %>% 
  head(n = 5L)
```
Result สามารถนำข้อมูลไปใช้ดูมังงะที่ตีพิมพ์จบแล้ว แต่ไม่จำนวนตอนไม่เยอะมากจนเกินไป สำหรับกลุ่มลูกค้าที่ต้องการหาเวลาว่างมานั่งอ่านมังงะสั้น ๆ สักเรื่อง
```
  Title                                                       Chapters  Rank
1 Jumyou wo Kaitotte Moratta. Ichinen ni Tsuki, Ichimanen de.       18    34
2 The Horizon                                                       21    38
3 Violet Evergarden                                                 13    65
4 Watashitachi no Shiawase na Jikan                                  8    72
5 Fate/Zero                                                         18    88
```

### ❓ Question 3: TOP 10 มังงะที่ได้รับคะแนนความนิยม(Score) พร้อมกับเรื่องย่อ(Synopsis)
``` ruby
Mangas %>% 
  select(Title,Score,Synopsis) %>% 
  arrange(desc(Score)) %>% 
  head(n = 10L)
```
Result สามารถนำข้อมูลความนิยมและเรื่องย่อ ไปใช้ประกอบเว็บไซต์แนะนำมังงะได้
```
   Title                                           Score Synopsis                                                                 
 1 Berserk                                          9.39 "Guts, a former mercenary now known as th…
 2 JoJo no Kimyou na Bouken Part 7: Steel Ball Run  9.23 "In the American Old West, the world's gr…
 3 One Piece                                        9.15 "Gol D. Roger, a man referred to as the \…
 4 Vagabond                                         9.13 "In 16th century Japan, Shinmen Takezou i…
 5 Monster                                          9.1  "Kenzou Tenma, a renowned Japanese neuros…
 6 Fullmetal Alchemist                              9.08 "Alchemists are knowledgeable and natural…
 7 Oyasumi Punpun                                   9.05 "Punpun Onodera is a normal 11-year-old b…
 8 Grand Blue                                       9.04 "Among the seaside town of Izu's ocean wa…
 9 Slam Dunk                                        9.02 "Hanamichi Sakuragi, a tall, boisterous t…
10 Kingdom                                          8.98 "During the Warring States period in Chin…
```

### ❓ Question 4: เปรียบเทียบความนิยมโดยอิงจากค่าเฉลี่ย(AVG)คะแนน(Score)ของมังงะเรื่องนั้น ๆ ตามประเภทว่าระหว่าง 'Action' กับ 'Fantasy' ประเภทไหนได้รับความนิยมมากกว่ากัน
``` ruby
# หา Mean ของ Action
ActionMean <- Mangas %>% 
  select(Title,Score,Genre) %>% 
  filter(Mangas$Genre %like% "Action")
ActionMean$Score %>% mean()

# หา Mean ของ Fantasy
FantasyMean <- Mangas %>% 
  select(Title,Score,Genre) %>% 
  filter(Mangas$Genre %like% "Fantasy")
FantasyMean$Score %>% mean()
```
Result สามารถนำข้อมูลเปรียบเทียบระหว่างประเภท 'Action' กับ 'Fantasy' มาหาความนิยมในปัจจุบันว่ากลุ่มลูกค้าสนใจประเภทไหนมากกว่ากัน
```
ActionMean = 8.203588
FantasyMean = 8.175224
```

### ❓ Question 5: TOP 5 มังงะยอดนิยมที่เริ่มต้นตีพิมพ์ในปี 2001
```
Date %>% 
  select(Title,Popularity,Publishing,Publish_date) %>% 
  filter(Date$Publish_date %like% "2001") %>% 
  arrange(Popularity) %>% 
  head(n = 5L)
```
Result สามารถนำข้อมูลข้อมูลไปหาความนิยมของคนในยุคนั้นได้ว่าแนวทางอนิเมะที่ดูนั้นเป็นอย่างไร
```
  Title                  Popularity Publishing Publish_date 
1 Fullmetal Alchemist            16 FALSE      Jul  12, 2001
2 Claymore                       42 FALSE      May  6, 2001 
3 Lovely★Complex                202 FALSE      Aug  13, 2001
4 Full Moon wo Sagashite        376 FALSE      Dec  1, 2001 
5 Shin Angyo Onshi              417 FALSE      Mar  19, 2001
```

### ❓ Question 6: ค่าเฉลี่ย(AVG)คะแนน(Score)ของมังงะที่หยุดตีพิมพ์(Status='On Hiatus')
``` ruby
AvgMangaOnHiatus <- Mangas %>% select(Title,Score,Status) %>% filter(Mangas$Status == "On Hiatus")
AvgMangaOnHiatus
AvgMangaOnHiatus$Score %>% mean()
```
Result สามารถนำข้อมูลค่าเฉลี่ยมาเทียบดูได้ว่าเพราะเหตุอะไรมังงะในกลุ่มนั้นจึงถูกหยุดตีพิมพ์ไป เป็นเพราะว่าได้รับความนิยมที่ไม่เยอะหรือไม่
```
  Title                   Score Status   
1 Vagabond                 9.13 On Hiatus
2 Nana                     8.73 On Hiatus
3 Ultra Heaven             8.27 On Hiatus
4 xxxHOLiC: Rei            8.22 On Hiatus
5 Wild Adapter             8.14 On Hiatus
6 X                        8.11 On Hiatus
7 Dogs: Bullets & Carnage  8.11 On Hiatus
8 Id                       8.08 On Hiatus
9 Kyoukai no Kanata        7.88 On Hiatus

mean = 8.296667
```

### ❓ Question 7: TOP 5 มังงะที่มีจำนวนเล่มเยอะที่สุด(Volumn)พร้อมกับแสดงผลอันดับของเรื่องนั้น ๆ(Rank)
``` ruby
Mangas %>% 
  select(Title,Volumns,Rank) %>% 
  arrange(desc(Volumns)) %>% 
  head(n=5L)
```
Result สามารถนำข้อมูลมาใช้หาได้ว่าการที่มังงะมีจำนวนเล่มเยอะ ส่งผลต่ออันดับความนิยมของผู้อ่านหรือไม่
```
  Title                           Volumns  Rank
1 Major                                78   415
2 Gintama                              77    78
3 Naruto                               72   583
4 Shijou Saikyou no Deshi Kenichi      61   483
5 Hayate no Gotoku!                    52   916
```

### ❓ Question 8: หาสัดส่วนเปอร์เซนต์ของมังงะว่า ส่วนใหญ่แล้วมังงะ TOP 1000 ยังมีสถานะการออกอากาศมากหรือน้อยกว่าเรื่องที่จบไปแล้ว
```
Publishing <- Mangas %>% 
  select(Title) %>% 
  filter(Mangas$Status %like% "Publishing")

Finished <- Mangas %>% 
  select(Title) %>% 
  filter(Mangas$Status %like% "Finished")

PercentPublishing <- (count(Publishing)/1000)*100
PercentFinished <- (count(Finished)/1000)*100
```
Result สามารถนำข้อมูลมาค่าสัดส่วนมังงะเรื่องอาจจบไปแล้วแต่ก็ยังสามารถได้รับความนิยมอยู่จนถึงทุกวันนี้
```
PercentPublishing = 27.1%
PercentFinished = 72%
```

### ❓ Question 9: TOP 5 มังงะที่ผู้ใช้งานเก็บเรื่องนั้นไว้ใน Reading List ของตนเอง
``` ruby
Mangas %>% 
  select(Title,Memebers) %>% 
  arrange(desc(Memebers)) %>% 
  head(n = 5L)
```
Result: สามารถนำข้อมูลมาใช้ดูความนิยมของกลุ่มลูกค้าในเว็บไซต์ MAL ในปัจจุบัน
```
  Title              Memebers
1 Shingeki no Kyojin   498886
2 Berserk              427894
3 One Piece            410522
4 Tokyo Ghoul          370631
5 Naruto               350621
```

### ❓ Question 10: 5 เรื่องที่ไม่ค่อยได้รับความนิยมจากสมาชิก MAL โดยผู้ใช้งานไม่ค่อยเอาเข้าในลิสต์ที่ชื่นชอบ(Favorites)
``` ruby
Mangas %>% 
  select(Title,Favorites) %>% 
  arrange(Favorites) %>% 
  head(n = 5L)
```
Result: สามารถนำข้อมูลมาใช้ดูมังงะที่ไม่ค่อยได้รับความนิยมจากกลุ่มลูกค้าในเว็บไซต์ MAL ในปัจจุบัน
จะเห็นได้ว่ามังงะที่ไม่ได้รับความนิยม 5 เรื่องท้ายได้แก่
```
  Title                          Favorites
1 Boku ga Otto ni Deau made              8
2 Gekijouban One Piece: Stampede        11
3 One Piece: Episode A                  11
4 Moon: Subaru Solitude Standing        12
5 Doraemon Plus                         12
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
