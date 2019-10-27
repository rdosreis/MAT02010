# ---------------------------------------------------

I <- 10000
pi  <- vector(length = I)
r_T <- vector(length = I)
r_C <- vector(length = I)
Z   <- vector(length = I)
R   <- vector(length = I)

# ---------------------------------------------------

id <- seq(from = 1, to = I, by = 2)

for (i in id){
  pi[i:(i+1)] <- runif(n = 1, 0, 1)
  Z[i] <- rbinom(n = 1, size = 1, prob = 0.5)
  Z[i+1] <- 1 - Z[i]
  
  r_T[i:(i+1)] <- r_C[i:(i+1)] <- rbinom(n = 2, size = 1, prob = 0.4)
  # r_T[i:(i+1)] <- rbinom(n = 2, size = 1, prob = 0.4)
  # r_C[i:(i+1)] <- rbinom(n = 2, size = 1, prob = 0.6)
  R[i:(i+1)] <- r_T[i:(i+1)] * Z[i:(i+1)] + r_C[i:(i+1)] * (1 - Z[i:(i+1)])
}

df <- data.frame(pi, r_T, r_C, Z, R)

# ---------------------------------------------------

library(knitr)
library(kableExtra)

head(df, 10) %>% 
  kable() %>% 
  kable_styling(bootstrap_options = "striped")

# ---------------------------------------------------

library(dplyr)

df.res <- df %>% group_by(pi) %>% 
  summarise(Y = (R[1] - R[2]) * Z[1] + (R[2] - R[1]) * (1 - Z[1]))

barplot(table(df.res$Y))

# ---------------------------------------------------

