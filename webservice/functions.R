###################################################
## Las rutinas en este script, tienen como finalidad
## automatizar el proceso de validación de datos.
## Se revisan distintos tipos de datos como fechas,
## entidades federativas y coordenadas.
###################################################


###################################################
## Librerías utilizadas
###################################################
suppressPackageStartupMessages(library(lubridate))
suppressPackageStartupMessages(library(plyr))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(stringr))
suppressPackageStartupMessages(library(xlsx))
suppressPackageStartupMessages(library(stringdist))
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(RCurl))
suppressPackageStartupMessages(library(rjson))

###################################################

###################################################
##---------------------------------
## Funciones
##---------------------------------
###################################################

###################################################
##---------------------------------
## get.inst_data
##---------------------------------
###################################################
get.inst_data <- function(){
    ##Esta función recorre todas las páginas de organizaciones dentro de
    ##Adela. Regresa una matriz con los nombres, los slugs de cada una y
    ##las ligas a su plan de apertura.
    i        <- 1
    inst     <- c()
    slug     <- c()
    url_plan <- c()
    url      <- paste0("http://adela.datos.gob.mx/api/v1/organizations?page=",i)
    json     <- fromJSON(getURL(url))
    while(length(json$results) > 0){
        ## Nombre de la institución
        inst <- c(inst, laply(json$results, function(t) t <- t$title))
        ## Slug de la institución
        slug <- c(slug, laply(json$results, function(t) t <- t$slug))
        ## Liga plan de apertura
        i <- i + 1
        url  <- paste0("http://adela.datos.gob.mx/api/v1/organizations?page=",i)
        json <- fromJSON(getURL(url))
    }
    data.frame(inst     = inst ,
               slugs    = slug,
               url_plan =
                   laply(slug,
                         function(t) t <-
                                         paste0("http://adela.datos.gob.mx/",
                                                t,
                                                "/plan.json")),
               url_plan =
                   laply(slug,
                         function(t) t <-
                                         paste0("http://adela.datos.gob.mx/",
                                                t,
                                                "/catalogo.json"))
                                              )
}

###################################################
##---------------------------------
## get.plan
##---------------------------------
###################################################
get.plan <- function(url){
    plan <- fromJSON(getURL(url))
    name <- laply(plan$opening_plans, function(t)t <- t$name)
    desc <- laply(plan$opening_plans, function(t)t <- t$description)
    date <- laply(plan$opening_plans, function(t)t <- t$publish_date)
    data.frame(recurso = name, desc = desc, fecha = date)
}

###################################################
##---------------------------------
## get.catalog
##---------------------------------
###################################################
get.catalog <- function(url){
    catalog   <- fromJSON(getURL(url))
    ## Nombres de conjuntos
    conj_nom  <-
        laply(catalog$dataset,
              function(t) t <- t$title)
    ## Descripciones conjuntos
    conj_desc <-
        laply(catalog$dataset,
              function(t) t <- t$description)
    ## Recursos
    recs <-
        llply(catalog$dataset,
              function(t) t <- t$distribution)
    ## Construcción catálogo
    cat.data <- c()
    for(i in 1:length(recs)){
        rec_title <- laply(recs[[i]], function(t) t <- t$title)
        rec_URL   <- laply(recs[[i]], function(t) t <- t$downloadURL)
        rec_type  <- laply(recs[[i]], function(t) t <- t$mediaType)
        rec_size  <- laply(recs[[i]], function(t) t <- t$byteSize)
        rec_date  <- laply(recs[[i]], function(t) t <- t$temporal)
        rec_conj  <- rep(conj_nom[i], length(rec_title))
        rec_desc  <- rep(conj_desc[i], length(rec_title))
        ## Juntar todo
        cat.data  <- rbind(cat.data,
                          data.frame(
                              conjunto = rec_conj,
                              recurso  = rec_title,
                              desc     = rec_desc,
                              date     = rec_date,
                              type     = rec_type,
                              size     = rec_size,
                              url      = rec_URL
                          ))
    }
 cat.data
}
