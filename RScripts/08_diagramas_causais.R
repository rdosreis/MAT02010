## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='40%', paged.print=FALSE----

knitr::include_graphics(here('images', 'ex_dor_cabeca.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='40%', out.height='40%', paged.print=FALSE----

knitr::include_graphics(here('images', 'ex_dor_cabeca2.png'))



## ----echo=FALSE, message=FALSE, warning=FALSE, paged.print=FALSE, fig.cap="Mapa da variável proporção de domicílios com 0-3 salários (Censo do IBGE de 2010) em Porto Alegre por bairros.", results='hide'----
poa_bairro <- readRDS('C:\\Users\\Rodrigo\\Documents\\ELSA Project\\Segregacao\\Apresentacao\\poa_prop3.rds')
library(RColorBrewer)
library(spdep)
# library(maptools)
# library(rgdal)
# library(rgeos)
my.palette <- brewer.pal(n = 7, name = "RdYlBu")
# spplot(poa_bairro, "prop_0_3", col.regions = rev(my.palette), cuts = 6)


## ----echo=FALSE, message=FALSE, warning=FALSE, paged.print=FALSE, results='hide'----
poa_wmat <- nb2mat(poly2nb(poa_bairro), style = "B")
poa_wmat[1:10, 1:10]


## ----echo=FALSE, message=FALSE, warning=FALSE, paged.print=FALSE, out.height="60%", fig.align='center'----
coords <- coordinates(poa_bairro)
par(mar=c(0,0,0,0))
plot(poa_bairro)
plot(poly2nb(poa_bairro, queen = FALSE), coords, add = T, col = "steelblue", lwd = 2)


## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='40%', paged.print=FALSE----

knitr::include_graphics(here('images', 'associa1.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='40%', paged.print=FALSE----

knitr::include_graphics(here('images', 'associa2.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='40%', paged.print=FALSE----

knitr::include_graphics(here('images', 'associa3.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----

knitr::include_graphics(here('images', 'associa6.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='40%', paged.print=FALSE----

knitr::include_graphics(here('images', 'associa4.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='35%', paged.print=FALSE----

knitr::include_graphics(here('images', 'associa5.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='70%', paged.print=FALSE----

knitr::include_graphics(here('images', 'associa7.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----

knitr::include_graphics(here('images', 'terminologia1.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----

knitr::include_graphics(here('images', 'terminologia2.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----

knitr::include_graphics(here('images', 'terminologia3.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----

knitr::include_graphics(here('images', 'terminologia4.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----

knitr::include_graphics(here('images', 'terminologia5.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----

knitr::include_graphics(here('images', 'terminologia6.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----

knitr::include_graphics(here('images', 'terminologia7.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----

knitr::include_graphics(here('images', 'terminologia8.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----

knitr::include_graphics(here('images', 'terminologia9.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----

knitr::include_graphics(here('images', 'terminologia10.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----

knitr::include_graphics(here('images', 'terminologia11.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----

knitr::include_graphics(here('images', 'terminologia12.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----

knitr::include_graphics(here('images', 'terminologia13.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----

knitr::include_graphics(here('images', 'terminologia14.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----

knitr::include_graphics(here('images', 'constroi1.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'constroi2.png'))


## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'constroi3.png'))


## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'constroi4.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'constroi5.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'constroi6.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'constroi7.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'constroi8.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'constroi9.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'constroi10.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'backdoor1.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'backdoor2.png'))


## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'backdoor3.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'backdoor4.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'backdoor5.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'backdoor6.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'backdoor7.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'backdoor8.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'controle1.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'controle2.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'controle3.png'))


## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'controle4.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'controle5.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'controle6.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'controle7.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'controle8.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='60%', paged.print=FALSE----
knitr::include_graphics(here('images', 'controle9.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='100%', paged.print=FALSE----

knitr::include_graphics(here('images', 'cause-effect.png'))


