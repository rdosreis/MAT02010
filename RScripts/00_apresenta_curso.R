## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='80%', out.height='80%', paged.print=FALSE----

knitr::include_graphics(here('images', 'rodrigo_cartoon.jpg'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='80%', out.height='80%', paged.print=FALSE----

knitr::include_graphics(here('images', 'hi_my_name_is.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='15%', out.height='20%', paged.print=FALSE----

knitr::include_graphics(here('images', 'AC.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='15%', out.height='20%', paged.print=FALSE----

knitr::include_graphics(here('images', 'feijao.jpg'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='40%', out.height='20%', paged.print=FALSE----

library(cowplot)
library(ggplot2)

p1 <- ggdraw() + draw_image(here('images', 'EC.jpg'), scale = 1)
p2 <- ggdraw() + draw_image(here('images', 'MCPN.jpg'), scale = 0.82)

plot_grid(p1, p2)



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='40%', out.height='20%', paged.print=FALSE----

p1 <- ggdraw() + draw_image(here('images', 'barbeiro_errado.jpg'), scale = 1)
p2 <- ggdraw() + draw_image(here('images', 'barbeiro_certo.jpg'), scale = 1)

plot_grid(p1, p2)



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='40%', out.height='20%', paged.print=FALSE----

library(cowplot)
library(ggplot2)

p1 <- ggdraw() + draw_image(here('images', 'EC.jpg'), scale = 0.95)
p2 <- ggdraw() + draw_image(here('images', 'GG2.jpg'), scale = 1)

plot_grid(p1, p2)



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='90%', out.height='30%', paged.print=FALSE----

knitr::include_graphics(here('images', 'happy_sad.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='20%', out.height='25%', paged.print=FALSE----

knitr::include_graphics(here('images', 'SB.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='40%', out.height='20%', paged.print=FALSE----

knitr::include_graphics(here('images', 'mediation.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='100%', out.height='80%', paged.print=FALSE----

knitr::include_graphics(here('images', 'vio.jpg'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='90%', out.height='50%', paged.print=FALSE----

p1 <- ggdraw() + draw_image(here('images', 'elsa_errado.jpg'), scale = 0.6)
p2 <- ggdraw() + draw_image(here('images', 'logo_elsa.png'), scale = 1)

plot_grid(p1, p2)



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='100%', out.height='80%', paged.print=FALSE----

knitr::include_graphics(here('images', 'hospborges.jpg'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='100%', out.height='70%', paged.print=FALSE----

knitr::include_graphics(here('images', 'cirs.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='100%', out.height='80%', paged.print=FALSE----

knitr::include_graphics(here('images', 'bolsa_elsa.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='30%', paged.print=FALSE----
knitr::include_graphics(here('images','Rlogo.png'))


## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='100%', paged.print=FALSE----
knitr::include_graphics(here('images','books.png'))


## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='100%', out.height='80%', paged.print=FALSE----

knitr::include_graphics(here('images', 'abu_na_causa.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='30%', out.height='30%', paged.print=FALSE----

knitr::include_graphics(here('images', 'silentmonkey.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='100%', out.height='65%', paged.print=FALSE----

knitr::include_graphics(here('images', 'uber_na_causa.png'))



## ----echo=FALSE, fig.align='center', message=FALSE, warning=FALSE, out.width='100%', out.height='80%', paged.print=FALSE----

knitr::include_graphics(here('images', 'caffeine-causality-loop.jpg'))


