library(here)
library(haven)
library(compareGroups)

evans <- read_dta(file = here("data", "evans.dta"))

table(evans$chd)

evans2 <- subset(evans, select = names(evans)[c(-1,-2,-10,-11,-12)])

evans2$cat <- factor(evans2$cat, labels = c("Baixo", "Alto"))
evans2$smk <- factor(evans2$smk, labels = c("Nunca fumou", "Fumante"))
evans2$ecg <- factor(evans2$ecg, labels = c("Normal", "Alterado"))

evans <- evans2

# saveRDS(evans, file = here("data", "evans_ex.rds"))

# Aleatorização

set.seed(1158)
evans$trt <- factor(rbinom(n = length(evans$cat), size = 1, prob = 0.5))

# Equilíbrio nas covariáveis?

res <- compareGroups(trt ~ ., data = evans, method = 1)
tab <- createTable(res, show.p.overall = FALSE)
export2md(tab,
          caption = "Equilíbrio das covariáveis")
