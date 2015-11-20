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
header <- dashboardHeader(title = "Escuadrón de Datos")

## Barra de herramientas de dashboard
side   <- dashboardSidebar(selectInput('dep', 'Dependencia', teams),
                          sliderInput("date", "Fecha de inicio de análisis", 2009, 2015, 1,sep = ""),br(),p(),
                          actionButton("goButton", "Go"),br(),p()
                          )

## Cuerpo del Dashboard
body   <- dashboardBody(
    includeCSS("custom.css"),
    
    tags$head(tags$style(HTML('
        /* logo */
        .skin-blue .main-header .logo {
                              background-color: #0D47A1;
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
                              background-color:  #0D47A1;
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
                              '))),
    ## Contenedor de título principal
    fixedRow(
        column(width = 6, div(class="col-md-7" ,h2("Dashboard Principal")
                              )
               ),
        column(width = 6, div(class = "col-md-1 col-md-offset-9",
                              img(src="mx_logo.png",
                                  align="right",
                                  style= "margin: 0.6cm; width:145px;height:45px")
                              )
               )
    ),
    ## Contenedor primer nivel de paneles
    fixedRow(
        box(status = "info", width = 5, title = "Twitter Trends Timeline",
            solidHeader = TRUE,collapsible = TRUE), #dygraphOutput("dygraph")),
        box(status = "info", width = 7, title = "Home team versus Away team scores:",
            solidHeader = TRUE,collapsible = TRUE)#,showOutput("Chart2", "nvd3"))
    )
)

ui <- dashboardPage(header, side, body) 

## server.r
server <- function(input, output){
  
}

shinyApp(ui, server)
