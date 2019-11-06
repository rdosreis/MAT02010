## ---- echo=FALSE, warning=FALSE, message=FALSE---------------------------
evans <- read.table(file = here("data", "evans.txt"),
                    header = TRUE)
knitr::kable(head(evans))


## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='70%', paged.print=FALSE----
knitr::include_graphics(here('images', 'associa7.png'))


## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='40%', paged.print=FALSE----
knitr::include_graphics(here('images', 'exemplo-odag02.png'))


## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='40%', paged.print=FALSE----
knitr::include_graphics(here('images', 'exemplo-odag02-2.png'))


## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='70%', paged.print=FALSE----
knitr::include_graphics(here('images', 'exemplo-odag02-3.png'))


## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='70%', paged.print=FALSE----
knitr::include_graphics(here('images', 'dagitty-odag02-1.png'))


## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'dagitty-odag02-2.jpg'))


## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='90%', paged.print=FALSE----
knitr::include_graphics(here('images', 'dagitty1.png'))


## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='90%', paged.print=FALSE----
knitr::include_graphics(here('images', 'dagitty2.png'))


## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='90%', paged.print=FALSE----
knitr::include_graphics(here('images', 'dagitty3.png'))


## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='90%', paged.print=FALSE----
knitr::include_graphics(here('images', 'dagitty4.png'))


## ---- warning=FALSE, message=FALSE---------------------------------------
# Instala o pacote dagitty
# install.packages("dagitty")

# Carrega o pacote dagitty
library(dagitty)

# Carrega o DAG a partir do DAGitty
dag1 <- downloadGraph(x = "dagitty.net/mBYpOXW")


## ---- warning=FALSE, message=FALSE, out.width="70%", fig.align='center'----
plot(dag1)


## ---- warning=FALSE, message=FALSE, out.width="70%", fig.align='center'----
dag1.bd <- backDoorGraph(dag1)
plot(dag1.bd)


## ---- warning=FALSE, message=FALSE---------------------------------------
print(adjustmentSets(dag1,
                     effect = "total"))

# impliedConditionalIndependencies(dag1,
#                                  max.results = 2)


## ---- warning=FALSE, message=FALSE---------------------------------------
# Instala o pacote ggdag
# install.packages("ggdag")

# Carrega o pacote ggdag
library(ggdag)

# Carrega o DAG a partir do DAGitty
dag2 <- downloadGraph(x = "dagitty.net/mQLajCg")


## ---- warning=FALSE, message=FALSE, out.width="70%", fig.align='center'----
ggdag(dag2)


## ---- warning=FALSE, message=FALSE, out.width="70%", fig.align='center'----
ggdag_paths(dag2)


## ---- warning=FALSE, message=FALSE, out.width="70%", fig.align='center'----
ggdag_parents(dag2, "D")


## ---- warning=FALSE, message=FALSE, out.width="70%", fig.align='center'----
ggdag_ancestors(dag2, "D")


## ---- warning=FALSE, message=FALSE, out.width="70%", fig.align='center'----
ggdag_ancestors(dag2, "C1")


## ---- warning=FALSE, message=FALSE, out.width="70%", fig.align='center'----
ggdag_children(dag2, "C1")


## ---- warning=FALSE, message=FALSE, out.width="70%", fig.align='center'----
ggdag_adjustment_set(dag2)



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='100%', paged.print=FALSE----

knitr::include_graphics(here('images', 'cause-effect.png'))


