source("functions.r")

shinyServer(function(input, output) {



  output$ui <- renderUI({
    if (is.null(input$inst)){
        return()
    }else{
        ## Depending on input$input_type, we'll generate a different
        ## UI component and send it to the client.
        data <- get_data_inst(input$inst)
        ## dataTableOutput(data)
        column(12,
               column(12,h2(input$inst)),
               br(),
               hr(),
               br(),

               column(4,
                      column(12, h5(data[1,2], style="text-align:justify;color:#3f51b5")),
                      column(12, p(data[1,3],style="text-align:justify"))
                      ),
                              column(4,
                      column(12, h5(data[2,2], style="text-align:justify;color:#3f51b5")),
                      column(12, p(data[2,3],style="text-align:justify"))
                      ),
                              column(4,
                      column(12, h5(data[3,2], style="text-align:justify;color:#3f51b5")),
                      column(12, p(data[3,3],style="text-align:justify"))
                             )

               )
    }
  })

  output$input_type_text <- renderText({
    input$input_type
  })

  output$dynamic_value <- renderPrint({
    str(input$dynamic)
  })

})
