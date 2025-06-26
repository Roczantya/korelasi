
---
# 🧪 Practical Class in R: Measuring Correlation

Skrip ini dibuat untuk keperluan praktikum analisis data menggunakan R. Fokus utama praktikum ini adalah mengukur korelasi antara variabel, membuat visualisasi scatter plot, dan menghitung nilai korelasi Pearson dan Spearman.



## 📦 Packages yang Digunakan

Beberapa package yang digunakan dalam skrip ini:

- [`readxl`](https://cran.r-project.org/web/packages/readxl/index.html): membaca file Excel
- [`ggplot2`](https://ggplot2.tidyverse.org/): membuat visualisasi grafik
- [`GGally`](https://ggobi.github.io/ggally/): membuat pair plot

### Cara instalasi package (jika belum ada):
```r
install.packages("readxl")
install.packages("ggplot2")
install.packages("GGally")
````



## 📥 Import Dataset

Dataset digunakan dari file lokal:

```
correlation_dataset_200_rows.xlsx - Sheet1.csv
```

Pastikan path file CSV kamu sudah sesuai. Contoh perintah membaca file:

```r
data <- read.csv("correlation_dataset_200_rows.xlsx - Sheet1.csv")
```

Cek struktur dan nama kolom:

```r
str(data)
colnames(data)
```




## 🔀 Penambahan Kolom Random Noise

Skrip akan otomatis menambahkan kolom `Random_Noise` jika belum tersedia:

```r
if (!"Random_Noise" %in% colnames(data)) {
  data$Random_Noise <- rnorm(n = nrow(data), mean = 0, sd = 1)
}
```

---


## 📊 Scatter Plots

Beberapa scatter plot dibuat untuk melihat hubungan antar variabel, seperti:

* Hours Studied vs Test Score
* Hours Studied vs Stress Level
* Hours Studied vs Coffee Cups
* Hours Studied vs Random Noise
* Test Score vs Commute Time

Contoh plot:

```r
ggplot(data, aes(x = Hours_Studied, y = Test_Score)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Scatterplot: Hours Studied vs Test Score")
```

---


## 🧮 Perhitungan Korelasi

Menggunakan dua metode korelasi:

* **Pearson** (hubungan linear)
* **Spearman** (hubungan monotonic)

Fungsi berikut digunakan untuk menampilkan kedua nilai korelasi:

```r
check_correlation <- function(x, y, label1, label2) {
  cat("\n---", label1, "vs", label2, "---\n")
  cat("Pearson: ", cor(x, y, method = "pearson"), "\n")
  cat("Spearman: ", cor(x, y, method = "spearman"), "\n")
}
```

Contoh pemanggilan fungsi:

```r
check_correlation(data$Hours_Studied, data$Test_Score, "Hours_Studied", "Test_Score")
```


## 📊 Pair Plot

Untuk visualisasi korelasi semua variabel secara bersamaan:

```r
GGally::ggpairs(data)
```

---


## 📌 Catatan Tambahan

* Jika file asli dalam bentuk `.xlsx`, kamu bisa menggunakan `read_excel()` dari package `readxl`:
  ```r
  library(readxl)
  data <- read_excel("nama_file.xlsx", sheet = "Sheet1")
  ```
* Jangan lupa menyesuaikan nama kolom jika mengandung spasi atau tanda baca (misal: `Commute Time (minute)` jadi `Commute.Time..minute.` di R).



## 👩‍💻 Dibuat oleh
 
Tiffany
(Fanny untuk tugas praktikum Statistika)


