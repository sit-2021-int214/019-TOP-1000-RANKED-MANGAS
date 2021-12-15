## STEP 2 Analytical Inferential Statistics 🔍

STEP 0: Assign variables
``` ruby
# กำหนดค่าตัวแปร n, mean, sd, alpha
n <- 964
ListChapterManga <- Mangas %>% 
  select(Title, Favorites, Chapters) %>% 
  arrange(desc(Chapters)) %>% 
  head(n = 100L)
ListChapterManga
meanFavorites <- mean(ListChapterManga$Favorites) #5544.4
sdFavorites <- sd(ListChapterManga$Favorites) #12391.45
mue0 <- 5000
```

STEP 1: State the hypothesis
``` ruby
H0 >= 5000
Ha < 5000
```

STEP 2: Level of significance
``` ruby
alpha <- 0.05
```

Step 3: Test statistic
``` ruby
z <- (meanFavorites - mue0)/(sdFavorites/sqrt(n)) #1.364063
```

Step 4: Finding P-value approach or Critical Value approach

``` ruby
# P-value approach
pvalue <- pnorm(z); #0.9137262

# Critical Value approach
zalpha <- qnorm(alpha); #-1.644854
```

Step 5: Compare
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

Step 6: Conclusion
```
ค่าเฉลี่ยผู้ที่ชื่นชอบมังงะที่มีอันดับจำนวนตอนที่มากเป็น 100อันดับแรกมีค่าเฉลี่ยมากกว่า 5000
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
