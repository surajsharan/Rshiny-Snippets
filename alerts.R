library(shiny)
library(shinyjs)
library(shinyBS)

ui <- fluidPage(
  tags$style(HTML("
                  input:invalid {
                  background-color: #FFCCCC;
                  }")),
  #### Set up shinyjs ####
  useShinyjs(),
  
  ### shinyBS ###
  bsAlert("alert"),
  
  numericInput("myValue", "My Variable", min = 0, max = 1, value = 0.5),
  numericInput("myValue2", "My Variable2", min = 0, max = 3, step = 0.5, value = 0.5),
  textOutput("text"),
  textOutput("text2")
)

server <- function(session, input, output) {
  output$text <- renderText({
    
    ### shinyBS ###
    if(!(is.na(input$myValue)) && (input$myValue > 1 | input$myValue < 0)) {
      createAlert(session, "alert", "myValueAlert", title = "shinyBS: Invalid input",
                  content = "'My Variable' must be between 0 and 1", style = "danger")
    } else {
      closeAlert(session, "myValueAlert")
      return(input$myValue)
    }
  })
  output$text2 <- renderText(input$myValue2)
  
  ### modalDialog ###
  observeEvent(input$myValue, {
    if(!is.na(input$myValue) && (input$myValue > 1 | input$myValue < 0)) {
      showModal(modalDialog(
        title = "modalDialog: Invalid input",
        "'My Variable' must be between 0 and 1"
      ))   
    }
  })
  
  ### shinyjs ###
  observeEvent(input$myValue, {
    if(!(is.na(input$myValue)) && (input$myValue > 1 | input$myValue < 0)) {
      alert("shinyJS: 'My Variable' must be between 0 and 1")
    }
  })
  
}

shinyApp(ui, server)