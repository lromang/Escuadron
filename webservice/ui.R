shinyUI(fluidPage(
  theme = "theme.css",
  titlePanel("Valida datos"),

  sidebarLayout(
      sidebarPanel(
          tabsetPanel(
              tabPanel(
                  h4("Selección"),
                  br(),
                  selectizeInput("inst", h4("Institución"),
                                 choices = '',
                                 options =
                                     list(placeholder = 'Escriba el nombre de una institución',
                                                maxItems = 1,
                                          maxOptions = 5,
                                 create = FALSE)
      ),
                  radioButtons("set",
                               h4("Elija fuente:"),
                               choices = list("Plan" = 1, "Catálogo" = 2),
                            selected = 1),
                  br(),
                  submitButton("Buscar"),
                  br(),
                  h3("Ayuda"),
                  helpText("Nota: Ingresar una fecha y una Entidad Federativa para poner a prueba el algoritmo de corrección. Estas deben ser no vacías.")
              ),
              tabPanel(
                  h4("Análisis")
              )
          )       
                   ),
      mainPanel(h3("Datos")
      )
  )
))
