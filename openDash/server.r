shinyServer(function(input, output) {
    ##-----------------------------
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(XML))
suppressPackageStartupMessages(library(stringr))
suppressPackageStartupMessages(library(RCurl))
suppressPackageStartupMessages(library(rjson))
suppressPackageStartupMessages(library(plyr))
suppressPackageStartupMessages(library(httr))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(stringr))
suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(lubridate))
suppressPackageStartupMessages(library(RJSONIO))
suppressPackageStartupMessages(library(plotly))
suppressPackageStartupMessages(library(rCharts))
##---------------------------------------------
## Lectura de datos
all_data <- read.csv("https://raw.githubusercontent.com/lromang/MiningDatosGob/master/Datasets/MAT.csv") %>%
           dplyr::filter(dep != "grupos")

    output$openhist <- renderPlotly({
        data_plot <- plyr::count(all_data$dep)
       plot <- ggplot(data = data_plot, aes(x = x, y = freq)) +
           geom_bar(stat = "identity", fill = "#2196F3", alpha = .8) +
          #geom_text(aes(label = freq, y = freq + 25), col = "#2196F3", size = 3)+
           theme(panel.background = element_blank(),
                axis.text = element_text(color = "#2196F3",
                                        face  = "bold",
                                        size  = 10 ),
                axis.title = element_blank()) #+ coord_flip()
        ggplotly(plot)

    })

    output$dep <- renderText({
    length(unique(all_data$dep))
    })

    output$set <- renderText({
        length(unique(all_data$conj))
    })

    output$rec <- renderText({
        nrow(all_data)
  })

})
