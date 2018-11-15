
library(shiny)

Logged = FALSE;
my_username <- "test"
my_password <- "test"

ui1 <- function(){
  tagList(fluidRow(column(8,offset = 4, h2(("Welcome to Shiny Apps")))  ),
    div(id = "login",
        wellPanel(textInput("userName", "Username"),
                  passwordInput("passwd", "Password"),
                  br(),actionButton("Login", "Log in", style="background-color:#C0C0C0 "))),
    tags$style(type='text/css', ".well { max-width: 90em;background-color: 	#fffdfc }"),
    tags$style(type="text/css", "#login {font-size:15px;text-align:center;position:absolute;  top: 50%;left: 50%;margin-top: -150px;margin-left: -150px;}")
    
    #tags$style(type="text/css", "#login {font-size:15px;   text-align: centre;position:absolute;top: 40%;left: 50%;margin-top: -100px;margin-left: -150px;}")
  )}

ui2 <- function(){tagList(tabPanel(""))}

ui = (htmlOutput("page"))
server = (function(input, output,session) {
  
  USER <- reactiveValues(Logged = Logged)
  
  observe({ 
    if (USER$Logged == FALSE) {
      if (!is.null(input$Login)) {
        if (input$Login > 0) {
          Username <- isolate(input$userName)
          Password <- isolate(input$passwd)
          Id.username <- which(my_username == Username)
          Id.password <- which(my_password == Password)
          if (length(Id.username) > 0 & length(Id.password) > 0) {
            if (Id.username == Id.password) {
              USER$Logged <- TRUE
            } 
          }
        } 
      }
    }    
  })
  observe({
    if (USER$Logged == FALSE) {
      
      output$page <- renderUI({
        div(class="outer",do.call(bootstrapPage,c("",ui1())))
      })
    }
    if (USER$Logged == TRUE) 
    {
      output$page <- renderUI({
        div(class="outer",do.call(navbarPage,c(inverse=TRUE,title = "Login Successful",ui2())))
      })
      print(ui)
    }
  })
})

runApp(list(ui = ui, server = server))
