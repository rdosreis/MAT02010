# Sexo

sexo <- c(rep(0, 200000), rep(1, 200000))
sexo <- factor(sexo, labels = c("Mulheres", "Homens"))

# Idade

idade <- c(rep(c(0, 1), each = 100000), rep(c(0, 1), each = 100000))
idade <- factor(idade, labels = c("Jovens", "Idosos"))

# Estrato

df <- data.frame(sexo, idade)

df$estrato <- ifelse(df$sexo == "Homens" & df$idade == "Idosos", 1,
                     ifelse(df$sexo == "Mulheres" & df$idade == "Idosos", 2,
                            ifelse(df$sexo == "Homens" & df$idade == "Jovens", 3, 4)))

# Desfecho

df$desfecho <- 0
df$desfecho[df$estrato == 1][1:40000] <- 1
df$desfecho[df$estrato == 2][1:30000] <- 1
df$desfecho[df$estrato == 3][1:20000] <- 1
df$desfecho[df$estrato == 4][1:10000] <- 1

df$desfecho <- factor(df$desfecho, labels = c("Vivo", "Morto"))

# Grupo de tratamento

df$grupo <- ifelse(df$idade == "Idosos", 
                   rbinom(n = 100000, size = 1, prob = 0.8),
                   rbinom(n = 100000, size = 1, prob = 0.2))
df$grupo <- factor(df$grupo, labels = c("Controle", "Tratado"))

# ------ # -------

df$desfecho <- relevel(df$desfecho, ref = "Morto")

df$estrato <- factor(df$estrato, labels = paste("Estrato", 1:4))

df$grupo <- relevel(df$grupo, ref = "Tratado")

# ------ # -------

# Tabela 5.1 

tab <- table(df$grupo, df$desfecho, df$estrato, dnn = c("Grupo", "Desfecho", "Estrato"))
tab <- addmargins(tab, margin = 2)
tab <- ftable(tab, row.vars = c(3, 1))
tab

tab.df <- as.data.frame(matrix(tab, ncol = 3, byrow = F))
names(tab.df) <- c("Morto", "Vivo", "Total")
tab.df$Taxa.Mortalidade <- round(100 * tab.df$Morto/tab.df$Total, 1)

library(knitr)
library(kableExtra)

tab.df %>% 
  kable() %>% 
  kable_styling(bootstrap_options = "striped")

# Teste de Mantel-Haenszel

mantelhaen.test(tab, exact = T)


# ------ # -------

# Tabela 5.2 (Paradoxo)

tab <- table(df$grupo, df$desfecho, dnn = c("Grupo", "Desfecho"))
tab <- addmargins(tab, margin = 2)
tab <- ftable(tab, row.vars = c(3, 1))
tab

tab.df <- as.data.frame(matrix(tab, ncol = 3, byrow = F))
names(tab.df) <- c("Morto", "Vivo", "Total")
tab.df$Taxa.Mortalidade <- round(100 * tab.df$Morto/tab.df$Total, 1)

library(knitr)
library(kableExtra)

tab.df %>% 
  kable(row.names = T) %>% 
  kable_styling(bootstrap_options = "striped")


# ------ # -------

# Tabela 5.3

tab <- table(df$grupo, df$desfecho, df$idade, dnn = c("Grupo", "Desfecho", "Idade"))
tab <- addmargins(tab, margin = 2)
tab <- ftable(tab, row.vars = c(3, 1))
tab

tab.df <- as.data.frame(matrix(tab, ncol = 3, byrow = F))
names(tab.df) <- c("Morto", "Vivo", "Total")
tab.df$Taxa.Mortalidade <- round(100 * tab.df$Morto/tab.df$Total, 1)

library(knitr)
library(kableExtra)

tab.df %>% 
  kable(row.names = T) %>% 
  kable_styling(bootstrap_options = "striped")

# ------ # -------

# Tabela 5.4 (Paradoxo)

tab <- table(df$grupo, df$desfecho, df$sexo, dnn = c("Grupo", "Desfecho", "Sexo"))
tab <- addmargins(tab, margin = 2)
tab <- ftable(tab, row.vars = c(3, 1))
tab

tab.df <- as.data.frame(matrix(tab, ncol = 3, byrow = F))
names(tab.df) <- c("Morto", "Vivo", "Total")
tab.df$Taxa.Mortalidade <- round(100 * tab.df$Morto/tab.df$Total, 1)

library(knitr)
library(kableExtra)

tab.df %>% 
  kable(row.names = T) %>% 
  kable_styling(bootstrap_options = "striped")

