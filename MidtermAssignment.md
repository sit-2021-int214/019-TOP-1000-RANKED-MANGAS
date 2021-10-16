# 019-TOP-1000-RANKED-MANGAS

Datasets from: [TOP 1000 RANKED MANGAS by MyAnimeList](https://www.kaggle.com/astronautelvis/top-1000-ranked-mangas-by-myanimelist)

### About's Datasets
<p>Top 1000 Ranked Mangas by MyAnimeList เป็นชุดข้อมูลเกี่ยวกับ 1000 อันดับของ Manga ที่ประกอบไปด้วย ชื่อ Manga สถานะตีพิมพ์ จำนวนตอน คะแนนความนิยม ประเภท และเรื่องย่อของ Manga เรื่องนั้น ๆ</p>

## Overview
<p>กลุ่มของเราได้เลือกชุดข้อมูล Top 1000 Ranked Mangas เพื่อต้องการศึกษาความนิยม ความชื่นชอบ ประเภท รวมไปถึงว่าผู้คนส่วนใหญ่ที่ชื่นชอบ Manga ให้ความสนใจกับเรื่องอะไร มากน้อยแค่ไหน</p>
  
### Tools
- R Languange
- RStudio


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

### 2.	(Title) Title of the Manga.
-	ชื่อเรื่องของมังงะ
-	เก็บข้อมูลในรูปแบบ Title = col_character()

### 3.	(Title_Synonym) Synonym of Title of Manga.
-	ชื่อเรียกแฝง อย่างยกตัวอย่างเช่นว่า Doukyuusei ก็จะมีอีกชื่อเรียกว่า Classmates หรือ Tensei shitara Slime Datta Ken ก็จะมีอีกชื่อเรียกว่า That Time I Got Reincarnated as a Slim
-	ข้อมูลเก็บในรูปแบบ Title_Synonym = col_character()

### 4.	(Title_Japanese) Title of Manga in Japanese.
-	ชื่อเรื่องของมังงะแบบภาษาญี่ปุ่น
-	เก็บข้อมูลในรูปแบบ Title_Japanese = col_character()

### 5.	(Status) Description whether the manga is currently publishing or has completed publication
-	มังงะเรื่องนี้มีสถานะเป็นอย่างไร
-	ข้อมูลจะเก็บในรูปแบบ Status = col_character() มี 3
1. สถานะ Finished จบแล้ว
2. สถานะ Publishing อยู่ในระหว่างการตีพิมพ์
3. สถานะ On Hiatus หยุดตีพิมพ์ชั่วคราว

### 6.	(Volumns) Number of Volumes of Manga.
-	จำนวนเล่มที่ตีพิมพ์จนจบ
-	ข้อมูลจะเก็บในรูปแบบ Volumns = col_character() หากถ้าเกิดเรื่องไหนยังไม่จบ ช่องนี้จะมีค่าเป็น unknown

### 7.	(Chapters) Number of Chapters of Manga.
-	จำนวนตอนของมังงะเรื่องนั้น ๆ จนจบ
-	ข้อมูลจะเก็บในรูปแบบ Chapters = col_character() หากถ้าเกิดเรื่องไหนยังไม่จบ ช่องนี้จะมีค่าเป็น unknown

### 8.	(Publishing) Publishing Status
-	มังงะเรื่องนั้นยังมีสถานะการออกอากาศอยู่ในปัจจุบันหรือไม่
-	ข้อมูลจะเก็บในรูปแบบของ Publishing = col_logical() เป็น Boolean (True ยังออกอากาศอยู่ / False มังงะเรื่องนั้นจบแล้วเลยไม่ออกอากาศแล้ว) 

### 9.	(Rank) Ranking of Manga at MAL.
-	อันดับของมังงะ โดยอิงจาก MAL(https://myanimelist.net)
-	ข้อมูลจะเก็บในรูปแบบของ Rank = col_double()

### 10.	(Score) Score of Manga at MAL
-	คะแนนของมังงะเรื่องนั้น ๆ โดย MAL(https://myanimelist.net)
-	ข้อมูลจะเก็บในรูปแบบของ Score = col_double()

### 11.	(Scored_by) Number of people who scored the Manga.
-	จำนวนคนที่โหวตให้กับมังงะเรื่องนั้น ๆ 
-	ข้อมูลจะเก็บในรูปแบบของ Scored_by = col_double()

### 12.	(Popularity) Popularity Ranking of Manga.
-	อันดับความนิยมของผู้อ่าน
-	ข้อมูลจะเก็บในรูปแบบของ Popularity = col_double()

### 13.	(Memebers) Number of members/users of MAL who have added the manga to their reading list.
-	จำนวนผู้ใช้งานในเว็บไซต์ MAL(https://myanimelist.net) ที่เพิ่มมังงะเรื่องนั้นเข้าลิสต์มังงะที่อยากอ่าน (reading list) ของตนเอง
-	ข้อมูลจะเก็บในรูปแบบของ Memebers = col_double()

### 14.	(Favorites) Number of members/users of MAL who have added the manga to their favorite list.
-	จำนวนผู้ใช้งานในเว็บไซต์ MAL(https://myanimelist.net) ที่เพิ่มมังงะเรื่องนั้นเข้าลิสต์มังงะที่ชื่นชอบ (favorite list) ของตนเอง
-	ข้อมูลจะเก็บในรูปแบบของ Favorites = col_double()

### 15.	(Synopsis) Short Summary of Manga.
-	เรื่องย่อของมังงะ
-	ข้อมูลจะเก็บในรูปแบบของ Synopsis = col_character()

### 16.	(Publish_period) Publishing Period of Manga.
-	ช่วงเวลาที่ตีพิมพ์ ตั้งแต่เริ่มต้นถึงสิ้นสุด หากเรื่องไหนยังไม่จบจะเขียนตอนท้ายว่า to present
-	ข้อมูลจะเก็บในรูปแบบของ Publish_period = col_character()

### 17.	(Genre) Genre in which Manga belongs.
-	ประเภทของมังงะเรื่องนั้น ๆ ยกตัวอย่างเช่น มังงะ Attack On Titan มีประเภทดังนี้ 'Action', 'Mystery', 'Drama', 'Fantasy', 'Shounen', 'Super Power', 'Military'
-	ข้อมูลจะเก็บในรูปแบบของ Genre = col_character()

## Result

## Resources

## About Us

งานนี้เป็นส่วนของวิชา INT214 Statistics for Information technology <br/> ภาคเรียนที่ 1 ปีการศึกษา 2564 คณะเทคโนโลยีสารสนเทศ มหาวิทยาลัยเทคโนโลยีพระจอมเกล้าธนบุรี

### Team: เซ็กซี่ยกกำลังห๊า

1. นางสาวศศิภา มณีอินทร์ StudentID: 63130500108
2. นายสาริน วีรกุล StudentID: 63130500115
3. นายสิรภพ ไพเราะ StudentID: 63130500118
4. นางสาวสุพิชา พิริยะศิริพันธ์ StudentID: 63130500124
5. นายอุดมชัย นิราศรพ StudentID: 63130500161

### Instructor

- ATCHARA TRAN-U-RAIKUL
- JATAWAT XIE (Git: [safesit23](https://github.com/safesit23))
