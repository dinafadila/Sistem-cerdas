install.packages("dbscan")

# variable types
a <- 3  # a = 3, ceil : bulat ke atas, floor : ke bawah

help(signif)

# type data vector
a <- c(1,2,3,4,5)

# akses vektor
a[2]

x <- NULL
y <- NA

b <- numeric(10)

# cek tipe data variable
typeof(a)

# type data string
a <- "hello"
a

# vektor tipe data string
a <- c("hello","yaya","yiyi")
a[2]

# tipe data katagorik
factor(c("A","B","A","B")) # artinya A dan B adalah tipe data katagorik


data <- data.frame(satu = a, dua = b)
data()

# membuat fungsi
f1 <- function(x) {
  x^(2+x)
}

f1(b)

