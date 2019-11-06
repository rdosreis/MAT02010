#------------------------------
# Confundimento
# c é causa comum de x e y
# x causa y

n <- 1000
c <- rnorm(n)

b0 <- 0
b1 <- 1.5
b2 <- 1
b3 <- 0.5

x <- b0 + b2 * c + rnorm(n, sd = 0.5)
y <- b0 + b1 * x + b3 * c + rnorm(n, sd = 0.5)

par(mfrow = c(1, 1))
plot(y ~ x, pch = 16, col = "steelblue")

fit1 <- lm(y ~ x)
summary(fit1)

fit2 <- lm(y ~ x + c)
summary(fit2)

#------------------------------
# x e y não são associados na população
# x e y causam z
#   logo, x e y são associados em uma subpopulação

x <- rnorm(n)
b0 <- 0
b1 <- 0
y <- b0 + b1 * x + rnorm(n, sd = 0.5)
plot(y ~ x, pch = 16, col = "steelblue")

z <- x + y + rnorm(n, sd = 0.2)

fit1 <- lm(y ~ x)
summary(fit1)
fit2 <- lm(y ~ x + z)
summary(fit2)

z.cat <- cut(z,
             breaks = c(-Inf, quantile(z, probs = c(1 / 4, 2 / 4, 3 / 4, 1))),
             labels = 1:4)
plot(y ~ x)
# "#d0a040", "#40d058", "#d05840", "#40b8d0"
par(mfrow = c(2, 2))
plot(x[z.cat == "1"], y[z.cat == "1"], pch = 16, col = "#d0a040")
plot(x[z.cat == "2"], y[z.cat == "2"], pch = 16, col = "#40d058")
plot(x[z.cat == "3"], y[z.cat == "3"], pch = 16, col = "#d05840")
plot(x[z.cat == "4"], y[z.cat == "4"], pch = 16, col = "#40b8d0")

#------------------------------
# x e y  são associados na população
# x e y causam z

x <- rnorm(n)
b0 <- 0
b1 <- 1.5
y <- b0 + b1 * x + rnorm(n, sd = 0.5)
par(mfrow = c(1, 1))
plot(y ~ x, pch = 16)

z <- x + y + rnorm(n, sd = 0.2)

fit1 <- lm(y ~ x)
summary(fit1)
fit2 <- lm(y ~ x + z)
summary(fit2)

z.cat <- cut(z, breaks = c(-Inf, quantile(z, probs = c(1 / 4, 2 / 4, 3 / 4, 1))), labels = 1:4)
plot(y ~ x)
par(mfrow = c(2, 2))
plot(x[z.cat == "1"], y[z.cat == "1"], pch = 16, col = "#d0a040")
plot(x[z.cat == "2"], y[z.cat == "2"], pch = 16, col = "#40d058")
plot(x[z.cat == "3"], y[z.cat == "3"], pch = 16, col = "#d05840")
plot(x[z.cat == "4"], y[z.cat == "4"], pch = 16, col = "#40b8d0")

# y <- rnorm(1000)
# b0 <- 0
# b1 <- 1.5
# x <- b0 + b1 * y + rnorm(100)
# par(mfrow = c(1, 1))
# plot(y ~ x, pch = 16)
# 
# 
# c <- rnorm(100)
# b0 <- 0
# b1 <- 1.5
# b2 <- 1
# b3 <- 0.5
# x <- b0 + b2 * c + rnorm(100, sd = 0.5)
# y <- b0 + b1 * x + b3 * c + rnorm(100, sd = 0.5)
# par(mfrow = c(1, 1))
# plot(y ~ x, pch = 16)
# 
# fit1 <- lm(y ~ x)
# summary(fit1)
# fit2 <- lm(y ~ x + c)
# summary(fit2)
