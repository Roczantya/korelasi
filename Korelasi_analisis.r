# ============================================
# 🧪 Practical Class in R: Measuring Correlation
# ============================================

# 1. Load Required Packages -------------------
# Install jika belum ada
# install.packages("readxl")
# install.packages("ggplot2")
# install.packages("GGally")

# Load libraries
library(readxl)
library(ggplot2)
library(GGally)

# 2. Import Dataset ---------------------------
# Ganti path ke lokasi file Anda
data <- read.csv("correlation_dataset_200_rows.xlsx - Sheet1.csv")

# Lihat struktur data
str(data)

# Lihat nama kolom
colnames(data)

# Tambahkan kolom Random_Noise ----------------
# Jika belum ada di dataset
if (!"Random_Noise" %in% colnames(data)) {
  data$Random_Noise <- rnorm(n = nrow(data), mean = 0, sd = 1)
}

# 3. Create Scatter Plots ---------------------

# Hours_Studied vs Test_Score
ggplot(data, aes(x = Hours_Studied, y = Test_Score)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Scatterplot: Hours Studied vs Test Score")

# Hours_Studied vs Stress_Level
ggplot(data, aes(x = Hours_Studied, y = Stress_Level)) +
  geom_point(color = "green") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Scatterplot: Hours Studied vs Stress Level")

# Hours_Studied vs Coffee_Cups
ggplot(data, aes(x = Hours_Studied, y = Coffee_Cups)) +
  geom_point(color = "purple") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Scatterplot: Hours Studied vs Coffee Cups")

# Hours_Studied vs Random_Noise
ggplot(data, aes(x = Hours_Studied, y = Random_Noise)) +
  geom_point(color = "orange") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Scatterplot: Hours Studied vs Random Noise")

# Test_Score vs Commute Time
ggplot(data, aes(x = Test_Score, y = `Commute Time (minute)`)) +
  geom_point(color = "brown") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Scatterplot: Test Score vs Commute Time")

# Pair plot untuk semua variabel
GGally::ggpairs(data)

# 4. Calculate Pearson and Spearman Correlation ------------------

# Function untuk cetak korelasi
check_correlation <- function(x, y, label1, label2) {
  cat("\n---", label1, "vs", label2, "---\n")
  cat("Pearson: ", cor(x, y, method = "pearson"), "\n")
  cat("Spearman: ", cor(x, y, method = "spearman"), "\n")
}

check_correlation(data$Hours_Studied, data$Test_Score, "Hours_Studied", "Test_Score")
check_correlation(data$Hours_Studied, data$Stress_Level, "Hours_Studied", "Stress_Level")
check_correlation(data$Hours_Studied, data$Coffee_Cups, "Hours_Studied", "Coffee_Cups")
check_correlation(data$Hours_Studied, data$Random_Noise, "Hours_Studied", "Random_Noise")
check_correlation(data$Test_Score, data$Commute.Time..minute., "Test_Score", "Commute Time")
