library(shiny)

shinyApp(
  ui = fluidPage(
    DT::dataTableOutput("mtcarsTable")
  ),
  server = function(input, output) {
    
    output$mtcarsTable <- DT::renderDataTable({
      DT::datatable(datasets::mtcars[,1:3], 
                    options = list(rowCallback = DT::JS(
                      "function(nRow) {",
                      
                      
                      "$('td:eq(3)', nRow).css('cursor', 'pointer').attr('title', 'The particular  shows the Displacement value measured in inches ');",
                      "}"),
                      columnDefs = list(list(className = 'dt-center', targets = 0:3))
                    )
      ) 
      
    })
  }
)