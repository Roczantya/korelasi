# ============================================
# 🧪 Practical Class in R: Measuring Correlation
# ============================================

# 1. Load Required Packages -------------------
# Uncomment baris ini kalau belum install
# install.packages("readxl")
# install.packages("ggplot2")
# install.packages("GGally")

# Load libraries
library(readxl)
library(ggplot2)
library(GGally)

# 2. Import Dataset ---------------------------
# Ganti path ke lokasi file CSV
data <- read.csv("correlation_dataset_200_rows.xlsx - Sheet1.csv")

# Bersihkan kolom tidak penting (seperti X, X.1, dll)
data <- data[, !grepl("^X", names(data))]

# Lihat struktur dan nama kolom
str(data)
colnames(data)

# Tambahkan kolom Random_Noise ----------------
if (!"Random_Noise" %in% colnames(data)) {
  data$Random_Noise <- rnorm(n = nrow(data), mean = 0, sd = 1)
}

# 3. Buat folder 'plots' untuk simpan gambar --
if (!dir.exists("plots")) {
  dir.create("plots")
}

# 4. Scatter Plots + Simpan ke PNG ------------

# Hours_Studied vs Test_Score
p1 <- ggplot(data, aes(x = Hours_Studied, y = Test_Score)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Scatterplot: Hours Studied vs Test Score")
ggsave("plots/plot_hours_vs_score.png", plot = p1, width = 8, height = 6)

# Hours_Studied vs Stress_Level
p2 <- ggplot(data, aes(x = Hours_Studied, y = Stress_Level)) +
  geom_point(color = "green") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Scatterplot: Hours Studied vs Stress Level")
ggsave("plots/plot_hours_vs_stress.png", plot = p2, width = 8, height = 6)

# Hours_Studied vs Coffee_Cups
p3 <- ggplot(data, aes(x = Hours_Studied, y = Coffee_Cups)) +
  geom_point(color = "purple") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Scatterplot: Hours Studied vs Coffee Cups")
ggsave("plots/plot_hours_vs_coffee.png", plot = p3, width = 8, height = 6)

# Hours_Studied vs Random_Noise
p4 <- ggplot(data, aes(x = Hours_Studied, y = Random_Noise)) +
  geom_point(color = "orange") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Scatterplot: Hours Studied vs Random Noise")
ggsave("plots/plot_hours_vs_noise.png", plot = p4, width = 8, height = 6)

# Test_Score vs Commute Time
# Perhatikan: nama kolomnya berubah jadi Commute.Time..minute.
p5 <- ggplot(data, aes(x = Test_Score, y = Commute.Time..minute.)) +
  geom_point(color = "brown") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Scatterplot: Test Score vs Commute Time")
ggsave("plots/plot_score_vs_commute.png", plot = p5, width = 8, height = 6)

# 5. Pair Plot --------------------------------

# Pilih hanya kolom numerik yang relevan
data_subset <- data[, c("Hours_Studied", "Test_Score", "Stress_Level",
                        "Coffee_Cups", "Random_Noise", "Commute.Time..minute.")]

# Buat dan simpan pairplot
pair_plot <- GGally::ggpairs(data_subset)
ggsave("plots/plot_pairplot.png", plot = pair_plot, width = 10, height = 10)

# 6. Hitung Korelasi --------------------------

# Fungsi untuk cetak korelasi
check_correlation <- function(x, y, label1, label2) {
  cat("\n---", label1, "vs", label2, "---\n")
  cat("Pearson: ", cor(x, y, method = "pearson"), "\n")
  cat("Spearman: ", cor(x, y, method = "spearman"), "\n")
}

# Korelasi antar variabel
check_correlation(data$Hours_Studied, data$Test_Score, "Hours_Studied", "Test_Score")
check_correlation(data$Hours_Studied, data$Stress_Level, "Hours_Studied", "Stress_Level")
check_correlation(data$Hours_Studied, data$Coffee_Cups, "Hours_Studied", "Coffee_Cups")
check_correlation(data$Hours_Studied, data$Random_Noise, "Hours_Studied", "Random_Noise")
check_correlation(data$Test_Score, data$Commute.Time..minute., "Test_Score", "Commute Time")
