source("functions.R", local = FALSE)


instit <- get.inst_data()
    
shinyServer(function(input, output, session) {


    
  datasetInput <- reactive({
    ## En esta seccin se carga la base de datos desde la liga que se proporciona.
     data
  })
  
    output$table <- renderDataTable({
        ## Despliegue de resultados.
    datasetInput()
    })

    
  updateSelectizeInput(session, "inst",choices = instit[,2],server = TRUE)
    

  output$downloadData <- downloadHandler(
    # Nombre del archivo
    filename = function() {
		  paste(input$nombre, input$filetype, sep = ".")
	  },

    # Esta fun. escribe el archivo.
    content = function(file) {
      sep <- switch(input$filetype, "csv" = ",", "tsv" = "\t")

      # Write to a file specified by the 'file' argument
      write.table(datasetInput(), file, sep = sep,
        row.names = FALSE)
    }
  )
})
