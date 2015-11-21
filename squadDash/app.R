library(shiny)
library(shinydashboard)
library(rCharts)
library(dygraphs)
library(httr)
library(twitteR)
library(tm)
require(xts)
require(stringr)
library(rvest)



## ui.r
teams <- c("hola", "como", "estas")



## Encabezado de dashboard
header <- dashboardHeader(title = "Escuadrón de Datos",
                         dropdownMenu(type = "messages",
                                      messageItem(
                                          from = "Escuadrón",
                                          message = "Las intervenciones ha disminiuido."
                                      ),
                                      messageItem(
                                          from = "Preguntas frecuentes",
                                          message = "Panel de preguntas relevantes.",
                                          icon = icon("question"),
                                          time = "13:45"
                                      ),
                                      messageItem(
                                          from = "Soporte",
                                          message = "Preguntanos cualquier cosa.",
                                          icon = icon("life-ring"),
                                          time = "2014-12-01"
                                      )
                                      ),
                         dropdownMenu(type = "tasks", badgeStatus = "success",
                                      taskItem(value = 90, color = "green",
                                               "Tickets abiertos"
                                               ),
                                      taskItem(value = 17, color = "aqua",
                                               "Tickets Resueltos"
                                               ),
                                      taskItem(value = 75, color = "yellow",
                                               "Tickets pendientes"
                                               ),
                                      taskItem(value = 80, color = "red",
                                               "Nivel de satisfacción"
                                               )
                                      )
                         )

## Barra de herramientas de dashboard
side   <- dashboardSidebar(selectInput('dep', 'Dependencia', teams),
                          sliderInput("date", "Fecha de inicio de análisis", 2009, 2015, 1,sep = ""),br(),p(),
                          actionButton("goButton", "Go"),br(),p()
                          )

## Cuerpo del Dashboard
body   <- dashboardBody(
    includeCSS("custom.css"),
    
    tags$head(tags$style(HTML('
        .content-wrapper {
                              background-color: #ffffff;
                              }
        /* logo */
        .skin-blue .main-header .logo {
                              background-color: #616161;
                              }

        /* logo when hovered */
        .skin-blue .main-header .logo:hover {
                              background-color:  #212121;
                              }

        /* navbar (rest of the header) */
        .skin-blue .main-header .navbar {
                              background-color:  #212121;
                              }        

        /* main sidebar */
        .skin-blue .main-sidebar {
                              background-color:  #616161;
                              }

        /* active selected tab in the sidebarmenu */
        .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
                              background-color: #ff0000;
                              }

        /* other links in the sidebarmenu */
        .skin-blue .main-sidebar .sidebar .sidebar-menu a{
                              background-color: #00ff00;
                              color: #000000;
                              }

        /* other links in the sidebarmenu when hovered */
         .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
                              background-color: #ff69b4;
                              }
         .skin-blue .info-box {
                              color: #1DE9B6;
                              }
                              '))),
    ## Contenedor de título principal
    fixedRow(
        column(width = 6, div(class="col-md-7" ,h2("Dashboard Principal")
                              )
               ),
        column(width = 6, div(class = "col-md-1 col-md-offset-9",
                              img(src="mx_logo.png",
                                  align="right",
                                  style= "margin: 0.6cm; width:125px;height:35px")
                              )
               )
    ),
    ## Contenedor primer nivel de paneles
    fixedRow(
        hr(),
        box(status = "info", width = 5, title = "Estado de apertura",
            solidHeader = TRUE, collapsible = TRUE), #dygraphOutput("dygraph")),
        box(status = "info", width = 7, title = "Apertura por dependencia",
            solidHeader = TRUE,collapsible = TRUE),#,showOutput("Chart2", "nvd3"))
        box(status = "warning", width = 12, title = "Apertura en el tiempo",
            solidHeader = TRUE,collapsible = TRUE),#,showOutput("Chart2", "nvd3"))
        box(background = "fuchsia", width = 4, title = "Apertura en el tiempo",
            solidHeader = TRUE,collapsible = TRUE),#,showOutput("Chart2", "nvd3"))
        box(background = "purple", width = 4, title = "Apertura en el tiempo",
            solidHeader = TRUE,collapsible = TRUE),#,showOutput("Chart2", "nvd3"))
        box(background = "black", width = 4, title = "Apertura en el tiempo",
            solidHeader = TRUE,collapsible = TRUE)#,showOutput("Chart2", "nvd3"))


    )
)

ui <- dashboardPage(header, side, body) 

## server.r
server <- function(input, output){
  
}

shinyApp(ui, server)
