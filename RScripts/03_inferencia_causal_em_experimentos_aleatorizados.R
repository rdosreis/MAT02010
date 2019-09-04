## ---- echo=TRUE, eval=TRUE, message=FALSE, warning=FALSE-----------------
# Ausência de efeito de tratamento
r_T <- r_C <- c(rep(1, 30), rep(0, 70))

# Atribuição de tratamento
set.seed(2306)
Z <- rbinom(n = 100, size = 1, prob = 0.5)

# Desfecho observado
R <- ifelse(Z == 1, r_T, r_C)
round(prop.table(table(Z, R), margin = 1) * 100, 2)


## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='100%', paged.print=FALSE----

knitr::include_graphics(here('images', 'process_mortality_outcomes_tn.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='100%', paged.print=FALSE----

knitr::include_graphics(here('images', 'small_example.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='100%', paged.print=FALSE----

knitr::include_graphics(here('images', 'small_example_results.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='100%', paged.print=FALSE----

knitr::include_graphics(here('images', 'small_example_t_dist.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='100%', paged.print=FALSE----

knitr::include_graphics(here('images', 'small_example_t_dist_resumo.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='50%', out.height='80%', paged.print=FALSE----

knitr::include_graphics(here('images', 'Fisher_colorido.png'))


