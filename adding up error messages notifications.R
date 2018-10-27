library(shiny)

shinyApp(
  ui = fluidPage(
    actionButton("show", "Show"),
    actionButton("remove", "Remove"),
    tags$head(
      tags$style(
        HTML(".shiny-notification {background-color: #E24307;color: #ffffff;border: 1px solid #ccc;border-radius: 3px;
             opacity: 0.85;padding: 10px 8px 10px 10px;margin: 5px;font-size:15px;margin-left: -350px;width:365px;}")
        )
      )
  ),
  server = function(input, output) {
    # A queue of notification IDs
    ids <- character(0)
    # A counter
    n <- 0
    
    observeEvent(input$show, {
      # Save the ID for removal later
      id <- showNotification(paste("Hello !!", "Message Count:", n+1,sep = "\t"), duration = NULL)
      ids <<- c(ids, id)
      n <<- n + 1
       
    })
    
    observeEvent(input$remove, {
      if (length(ids) > 0)
        removeNotification(ids[1])
      ids <<- ids[-1]
    })
  }
)
