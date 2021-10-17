# 019-TOP-1000-RANKED-MANGAS

Datasets from: [TOP 1000 RANKED MANGAS by MyAnimeList](https://www.kaggle.com/astronautelvis/top-1000-ranked-mangas-by-myanimelist)

### About's Datasets
<p>Top 1000 Ranked Mangas by MyAnimeList เป็นชุดข้อมูลเกี่ยวกับ 1000 อันดับของ Manga ที่ประกอบไปด้วย ชื่อ Manga สถานะตีพิมพ์ จำนวนตอน คะแนนความนิยม ประเภท และเรื่องย่อของ Manga เรื่องนั้น ๆ</p>

## Overview
<p>กลุ่มของเราได้เลือกชุดข้อมูล Top 1000 Ranked Mangas เพื่อต้องการศึกษาความนิยม ความชื่นชอบ ประเภท รวมไปถึงว่าผู้คนส่วนใหญ่ที่ชื่นชอบ Manga ให้ความสนใจกับเรื่องอะไร มากน้อยแค่ไหน</p>
  
### Tools
- R Languange
- RStudio

## Step
1.
2.
3.
4.
5.

## Data Exploration
```
library(readr)
Mangas <- read_csv("Desktop/R-214/top_1000.csv")
View(Mangas)

head(Mangas)
str(Mangas)
colnames(Mangas)
rownames(Mangas)
```

### 1.	Index of Manga
-	ลำดับของมังงะ
-	เก็บข้อมูลในรูปแบบ ...1 = col_double()
-	ตัวอย่างข้อมูล : 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,…

### 2.	(Title) Title of the Manga.
-	ชื่อเรื่องของมังงะ
-	เก็บข้อมูลในรูปแบบ Title = col_character()
-	ตัวอย่างข้อมูล : "Berserk", "JoJo no Kimyou na Bouken Part 7: Steel Ball Run", "One Piece", "Vagabond", "M…

### 3.	(Title_Synonym) Synonym of Title of Manga.
-	ชื่อเรียกแฝงของมังงะ
-	ข้อมูลเก็บในรูปแบบ Title_Synonym = col_character()
-	ตัวอย่างข้อมูล : Doukyuusei ก็จะมีอีกชื่อเรียกว่า Classmates หรือ Tensei shitara Slime Datta Ken ก็จะมีอีกชื่อเรียกว่า That Time I Got Reincarnated as a Slim

### 4.	(Title_Japanese) Title of Manga in Japanese.
-	ชื่อเรื่องของมังงะแบบภาษาญี่ปุ่น
-	เก็บข้อมูลในรูปแบบ Title_Japanese = col_character()
-	ตัวอย่างข้อมูล : "ベルセルク", "ジョジョの奇妙な冒険 Part7 STEEL BALL RUN", "ONE PIECE", "バガボンド", "MO…

### 5.	(Status) Description whether the manga is currently publishing or has completed publication
-	มังงะเรื่องนี้มีสถานะเป็นอย่างไร
-	ข้อมูลจะเก็บในรูปแบบ Status = col_character() มี 3
  1. สถานะ Finished จบแล้ว
  2. สถานะ Publishing อยู่ในระหว่างการตีพิมพ์
  3. สถานะ On Hiatus หยุดตีพิมพ์ชั่วคราว
- ตัวอย่างข้อมูล : "Publishing", "Finished", "Publishing", "On Hiatus", "Finished", "Finished", "Finished", …

### 6.	(Volumns) Number of Volumes of Manga.
-	จำนวนเล่มที่ตีพิมพ์จนจบ
-	ข้อมูลจะเก็บในรูปแบบ Volumns = col_character() หากถ้าเกิดเรื่องไหนยังไม่จบ ช่องนี้จะมีค่าเป็น unknown
-	ตัวอย่างข้อมูล : "unkown", "24.0", "unkown", "37.0", "18.0", "27.0", "13.0", "unkown", "31.0", "unkown", "…

### 7.	(Chapters) Number of Chapters of Manga.
-	จำนวนตอนของมังงะเรื่องนั้น ๆ จนจบ
-	ข้อมูลจะเก็บในรูปแบบ Chapters = col_character() หากถ้าเกิดเรื่องไหนยังไม่จบ ช่องนี้จะมีค่าเป็น unknown
-	ตัวอย่างข้อมูล : "unkown", "96.0", "unkown", "327.0", "162.0", "116.0", "147.0", "unkown", "276.0", "unkow…

### 8.	(Publishing) Publishing Status
-	มังงะเรื่องนั้นยังมีสถานะการออกอากาศอยู่ในปัจจุบันหรือไม่
-	ข้อมูลจะเก็บในรูปแบบของ Publishing = col_logical() เป็น Boolean (True ยังออกอากาศอยู่ / False มังงะเรื่องนั้นจบแล้วเลยไม่ออกอากาศแล้ว) 
-	ตัวอย่างข้อมูล : TRUE, FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRU…

### 9.	(Rank) Ranking of Manga at MAL.
-	อันดับของมังงะ โดยอิงจาก MAL(https://myanimelist.net)
-	ข้อมูลจะเก็บในรูปแบบของ Rank = col_double()
-	ตัวอย่างข้อมูล : 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25…

### 10.	(Score) Score of Manga at MAL
-	คะแนนของมังงะเรื่องนั้น ๆ โดย MAL(https://myanimelist.net)
-	ข้อมูลจะเก็บในรูปแบบของ Score = col_double()
-	ตัวอย่างข้อมูล : 9.39, 9.23, 9.15, 9.13, 9.10, 9.08, 9.05, 9.04, 9.02, 8.98, 8.96, 8.95, 8.94, 8.94, 8.92,…

### 11.	(Scored_by) Number of people who scored the Manga.
-	จำนวนคนที่โหวตให้กับมังงะเรื่องนั้น ๆ 
-	ข้อมูลจะเก็บในรูปแบบของ Scored_by = col_double()
-	ตัวอย่างข้อมูล : 201756, 94427, 249936, 72613, 57801, 130375, 107866, 43573, 47977, 40183, 11864, 72566, 5…

### 12.	(Popularity) Popularity Ranking of Manga.
-	อันดับความนิยมของผู้อ่าน
-	ข้อมูลจะเก็บในรูปแบบของ Popularity = col_double()
-	ตัวอย่างข้อมูล : 2, 29, 3, 19, 33, 16, 10, 61, 73, 67, 240, 23, 37, 24, 369, 743, 32, 60, 231, 149, 63, 19…

### 13.	(Memebers) Number of members/users of MAL who have added the manga to their reading list.
-	จำนวนผู้ใช้งานในเว็บไซต์ MAL(https://myanimelist.net) ที่เพิ่มมังงะเรื่องนั้นเข้าลิสต์มังงะที่อยากอ่าน (reading list) ของตนเอง
-	ข้อมูลจะเก็บในรูปแบบของ Memebers = col_double()
-	ตัวอย่างข้อมูล : 427894, 160782, 410522, 211345, 148764, 236950, 276311, 118761, 103814, 107482, 45128, 18…

### 14.	(Favorites) Number of members/users of MAL who have added the manga to their favorite list.
-	จำนวนผู้ใช้งานในเว็บไซต์ MAL(https://myanimelist.net) ที่เพิ่มมังงะเรื่องนั้นเข้าลิสต์มังงะที่ชื่นชอบ (favorite list) ของตนเอง
-	ข้อมูลจะเก็บในรูปแบบของ Favorites = col_double()
-	ตัวอย่างข้อมูล : 80308, 27459, 82310, 21596, 13049, 26753, 34636, 11740, 10289, 9881, 2422, 18926, 12693, …

### 15.	(Synopsis) Short Summary of Manga.
-	เรื่องย่อของมังงะ
-	ข้อมูลจะเก็บในรูปแบบของ Synopsis = col_character()
-	ตัวอย่างข้อมูล : "Guts, a former mercenary now known as the \"Black Swordsman,\" is out for revenge. After…

### 16.	(Publish_period) Publishing Period of Manga.
-	ช่วงเวลาที่ตีพิมพ์ ตั้งแต่เริ่มต้นถึงสิ้นสุด หากเรื่องไหนยังไม่จบจะเขียนตอนท้ายว่า to present
-	ข้อมูลจะเก็บในรูปแบบของ Publish_period = col_character()
-	ตัวอย่างข้อมูล : "Aug  25, 1989 to present", "Jan  19, 2004 to Apr  19, 2011", "Jul  22, 1997 to present",…

### 17.	(Genre) Genre in which Manga belongs.
-	ประเภทของมังงะเรื่องนั้น ๆ
-	ข้อมูลจะเก็บในรูปแบบของ Genre = col_character()
-	ตัวอย่างข้อมูล : Attack On Titan มีประเภทดังนี้ 'Action', 'Mystery', 'Drama', 'Fantasy', 'Shounen', 'Super Power', 'Military'

## Data Cleaning and Data Transformation
```
โค้ดจงมาอยู่นี่
```

## Data Analysis with Descriptive Statistics

### ❓ Question 1: TOP 5 ความนิยม(Popularity) มังงะที่ตีพิมพ์จบแล้ว
```
โค้ดจงมาอยู่นี่
```
#### Result สามารถนำข้อมูลไปใช้ดูมังงะที่จบแล้วและมีความยอดนิยม(Popularity) สำหรับกลุ่มลูกค้าที่ต้องการอ่านเรื่องที่นิยมและจบแล้ว
```
โค้ดจงมาอยู่นี่
```

### ❓ Question 2: TOP 5 มังงะที่ตีพิมพ์จบแล้ว ที่มีจำนวนตอน(Chapters)ไม่เกิน 24 ตอน
```
โค้ดจงมาอยู่นี่
```
#### Result สามารถนำข้อมูลไปใช้ดูมังงะที่ตีพิมพ์จบแล้ว แต่ไม่จำนวนตอนไม่เยอะมากจนเกินไป สำหรับกลุ่มลูกค้าที่ต้องการหาเวลาว่างมานั่งอ่านมังงะสั้น ๆ สักเรื่อง
```
โค้ดจงมาอยู่นี่
```

### ❓ Question 3: TOP 10 มังงะที่ได้รับคะแนนความนิยม(Score) พร้อมกับเรื่องย่อ(Synopsis)
```
โค้ดจงมาอยู่นี่
```
#### Result สามารถนำข้อมูลความนิยมและเรื่องย่อ ไปใช้ประกอบเว็บไซต์แนะนำมังงะได้
```
โค้ดจงมาอยู่นี่
```

### ❓ Question 4: เปรียบเทียบความนิยมโดยอิงจากค่าเฉลี่ย(AVG)คะแนน(Score)ของมังงะเรื่องนั้น ๆ ตามประเภทว่าระหว่าง 'Action' กับ 'Fantasy' ประเภทไหนได้รับความนิยมมากกว่ากัน
```
โค้ดจงมาอยู่นี่
```
#### Result สามารถนำข้อมูลเปรียบเทียบระหว่างประเภท 'Action' กับ 'Fantasy' มาหาความนิยมในปัจจุบันว่ากลุ่มลูกค้าสนใจประเภทไหนมากกว่ากัน
```
โค้ดจงมาอยู่นี่
```

### ❓ Question 5: TOP 5 มังงะยอดนิยมที่เริ่มต้นตีพิมพ์ในปี 2001
```
โค้ดจงมาอยู่นี่
```
#### Result สามารถนำข้อมูลข้อมูลไปหาความนิยมของคนในยุคนั้นได้ว่าแนวทางอนิเมะที่ดูนั้นเป็นอย่างไร
```
โค้ดจงมาอยู่นี่
```

## About Us

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
