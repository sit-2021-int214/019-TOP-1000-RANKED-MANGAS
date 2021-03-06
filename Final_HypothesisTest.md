## Analytical Inferential Statistics 🔍

มังงะที่มีจำนวนตอนมากที่สุดใน 100 อันดับแรก จะมีค่าเฉลี่ยผู้ที่มีความชื่นชอบ (Favorite) มากกว่า 3500 โดยใน 100 อันดับแรกจะมีค่าเฉลี่ยอยู่ที่ 3735.17 และส่วนเบี่ยงเบนมาตรฐานมีค่าเท่ากับ 12391.45 (กำหนดค่า alpha = 0.05)


### STEP 0: Assign variables
``` ruby
# กำหนดค่าตัวแปร n, mean, sd, mue0
n <- 964
ListChapterManga <- Mangas %>% 
  select(Title, Favorites, Chapters) %>% 
  arrange(desc(Chapters)) %>% 
  head(n = 100L)
meanFavorites <- mean(ListChapterManga$Favorites) #3735.17
sdFavorites <- sd(ListChapterManga$Favorites) #12391.45
mue0 <- 3500
```

### STEP 1: State the hypothesis
``` ruby
H0 >= 3500
Ha < 3500
```

### STEP 2: Level of significance
``` ruby
alpha <- 0.05
```

### STEP 3: Test statistic
``` ruby
t <- (meanFavorites - mue0)/(sdFavorites/sqrt(n)) #1.226481
```

### STEP 4: Finding P-value approach or Critical Value approach
``` ruby
# P-value approach
pvalue <- pt(t, (n-1), lower.tail = TRUE) #0.8898413

# Critical Value approach
talpha <- qt(alpha, (n-1), lower.tail = TRUE) #-1.646437
```

### STEP 5: Compare
``` ruby
# Using p-value approach = "Accept H0"
if(pvalue<=alpha){
  print("Reject H0")
}else{
  print("Accept H0")
}

# Using critical value = "Accept H0"
if(t<=talpha){
  print("Reject H0")
}else{
  print("Accept H0")
}
```

### STEP 6: Conclusion
```
มังงะที่มีจำนวนตอนมากที่สุดใน 100 อันดับแรก มีค่าเฉลี่ยผู้ที่มีความชื่นชอบ (Favorite) มากกว่า 3500 ("Accept H0")
```

## About Us 📝

งานนี้เป็นส่วนของวิชา INT214 Statistics for Information technology <br/> ภาคเรียนที่ 1 ปีการศึกษา 2564 คณะเทคโนโลยีสารสนเทศ มหาวิทยาลัยเทคโนโลยีพระจอมเกล้าธนบุรี

### Team: เซ็กซี่ยกกำลังห๊า 🎒

| NO   | NAME                 | STUDENTID   |
| :--: | -------------------- | ----------- |
| 1    | นางสาวศศิภา มณีอินทร์    | 63130500108 |
| 2    | นายสาริน วีรกุล         | 63130500115 |
| 3    | นายสิรภพ ไพเราะ       | 63130500118 |
| 4    | นางสาวสุพิชา พิริยะศิริพันธ์ | 63130500124 |
| 5    | นายอุดมชัย นิราศรพ      | 63130500161 |

### Instructor 🍀

- ATCHARA TRAN-U-RAIKUL
- JATAWAT XIE (Git: [safesit23](https://github.com/safesit23))
