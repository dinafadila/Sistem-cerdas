library(rgl)

# Acak. Unit mengembalikan n titik dimensi redup dalam interval unit berlabel
# -1 atau 1. Label tergantung pada jumlah vektor atau tidak
# komponen melebihi ambang batas yang diberikan. Yaitu, -1 jika jumlah (vektor) <ambang batas
# dan 1 sebaliknya.

Random.Unit <-function(n, dim, threshold) {
  points <- runif(n * dim)
  points <- matrix(points, ncol = dim)
  label <- ifelse(apply(points, 1, sum) < threshold, -1, 1)
  return(cbind(label, x0 = rep(1, n), points))
}

# Klasifikasi adalah aturan klasifikasi sederhana kami untuk perceptron. Sederhananya
# kembalikan tanda titik-produk dari pengamatan dan bobot kami
Classify <- function(x, weights) {
  return(sign(x %*% weights))
}

# Perceptron adalah implementasi sederhana dari algoritma pembelajaran perceptron.
# Ia menerima data dari formulir data [1] = label, data [2] = x_0 = 1, data [3] = x_1,
# etc. w0 tidak dapat digunakan untuk -threshold dan bobot yang dikembalikan adalah seperti itu
# sign (w_0 * x_0 + w_1 * x_1 + ... + w_n * x_n) == label
Perceptron <- function(data, threshold) {
  w <- c(-threshold, runif(ncol(data) - 2))
  n <- nrow(data)
  label <- data[ , 1]
  obs <- data[ , 2:ncol(data)]
  misclassfied <- TRUE
  while (misclassfied) {
    misclassfied <- FALSE
    for (i in 1:n) {
      if (label[i] * Classify(obs[i , ], w) <= 0) {
        w <- w + label[i] * obs[i , ]
        misclassfied <- TRUE
      }
    }
  }
  return(w)
}

# Plot3D pada dasarnya adalah pembungkus untuk fungsi plot3d paket rgl.
# Ini memplot hasil dari panggilan ke Random.Unit dengan redup = 3
# dan juga bidang yang diparameterisasi oleh ax + oleh + cz + d = 0
Plot3D <- function(points, a, b, c, d) {
  plot3d(points[, 3:5], xlab = "X", ylab = "Y", zlab = "Z",
         pch = ifelse(points[, 1] == 1, 2, 8),
         col = ifelse(points[, 1] == 1, "blue", "red"))
  planes3d(a, b, c, d)
}

# Plot2D memplot hasil dari panggilan ke Random.Unit dengan redup = 2 juga
# sebagai garis yang diparameterisasi oleh y = bx + a, seperti pada panggilan untuk abline.
Plot2D <- function(points, a, b) {
  plot(points[, 3:4], xlab = "X", ylab = "Y",
       pch = ifelse(points[, 1] == 1, 2, 8),
       col = ifelse(points[, 1] == 1, "blue", "red"))
  abline(a, b)
}

THRESHOLD <- 1.5
pts <- Random.Unit(1000, 3, THRESHOLD)
Plot3D(pts, 1, 1, 1, -THRESHOLD)
w <- Perceptron(pts, THRESHOLD)
Plot3D(pts, w[4], w[3], w[2], w[1])

THRESHOLD <- 0.75
pts <- Random.Unit(1000, 2, THRESHOLD)
Plot2D(pts, THRESHOLD, -1)
w <- Perceptron(pts, THRESHOLD)
Plot2D(pts, -w[1]/w[3], -w[2]/ w[3])
