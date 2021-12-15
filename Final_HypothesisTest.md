## Analytical Inferential Statistics 🔍

มังงะที่มีจำนวนตอนมากที่สุดใน 100 อันดับแรก มีค่าเฉลี่ยผู้ที่มีความชื่นชอบ(Favorite)มากกว่า 5000 โดยใน 100 อันดับแรกจะมีค่าเฉลี่ยอยู่ที่ 5544.4 และส่วนเบี่ยงเบนมาตรฐานมีค่าเท่ากับ 12391.45 (กำหนดค่า alpha = 0.05)


### STEP 0: Assign variables
``` ruby
# กำหนดค่าตัวแปร n, mean, sd, mue0
n <- 964
ListChapterManga <- Mangas %>% 
  select(Title, Favorites, Chapters) %>% 
  arrange(desc(Chapters)) %>% 
  head(n = 100L)
meanFavorites <- mean(ListChapterManga$Favorites) #5544.4
sdFavorites <- sd(ListChapterManga$Favorites) #12391.45
mue0 <- 5000
```

### STEP 1: State the hypothesis
``` ruby
H0 >= 5000
Ha < 5000
```

### STEP 2: Level of significance
``` ruby
alpha <- 0.05
```

### STEP 3: Test statistic
``` ruby
z <- (meanFavorites - mue0)/(sdFavorites/sqrt(n)) #1.364063
```

### STEP 4: Finding P-value approach or Critical Value approach
``` ruby
# P-value approach
pvalue <- pnorm(z); #0.9137262

# Critical Value approach
zalpha <- qnorm(alpha); #-1.644854
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
if(z<=zalpha){
  print("Reject H0")
}else{
  print("Accept H0")
}
```

### STEP 6: Conclusion
```
มังงะที่มีจำนวนตอนมากที่สุดใน 100 อันดับแรก มีค่าเฉลี่ยผู้ที่มีความชื่นชอบ(Favorite)มากกว่า 5000
```

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
