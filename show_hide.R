library(shiny)
library(shinyjs)

ui <- tagList(
  useShinyjs(),
  
  navbarPage(
    "Hide/Show Navbar",
    id = "navbar",
    tabPanel(
      title = "Tab 1",
      actionButton("button", "Show/Hide")
    ),
    tabPanel(
      title = "Tab 2",
      value = "mytab2",
      sidebarLayout(
        sidebarPanel(
          selectInput("test", "Choose a variable", choices = c("var1", "var2"), selected = "var1")
        ),
        mainPanel(
          textOutput("testOut")
        )
      )
    )
    
    
  )
)

server <- function(input, output, session) {
  observe({
    hide(selector = "#navbar li a[data-value=mytab2]")
    
  })
  
  observeEvent(input$button, {
    toggle(selector = "#navbar li a[data-value=mytab2]")
    
  })
}
shinyApp(ui = ui, server = server)