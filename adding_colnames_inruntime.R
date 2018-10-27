test_df <- data.frame(a = seq(1000, 21000, 1000), b = seq(1:21), c = seq(100, 300, 10))

library(shiny)

runApp(list(
  ui=pageWithSidebar(headerPanel("Adding entries to table"),
                     sidebarPanel(uiOutput("select1"),
                                  selectInput("select2", "Choose modification",
                                              choices = c("log", "different"), 
                                              selected = NULL, multiple = F),
                                  actionButton("update", "Update Table")),
                     mainPanel(tableOutput("table1"))),
  
  server=function(input, output, session) {
    
    values <- reactiveValues()
    
    ### specifing the dataset ###
    values$df <- data.frame(test_df)
    nr <<- nrow(test_df)
    
    ### this will contain the modified values ###
    values$d <- data.frame(1:nr)
    
    ### selecting a variable to modify ###
    output$select1 <- renderUI({
      nc <- ncol(values$df)
      nam <- colnames(values$df)
      selectInput("var", label = "Select var:",
                  choices = c(nam), multiple = F,
                  selected = nam[1])
    })
    
    ### calculations needed for modifactions ###
    newEntry <- observeEvent(input$update, {
      
      if(input$select2 == "log") {
        newCol <- isolate(
          c(log(values$df[input$var]))
        )
        newCol <- as.data.frame(newCol)
        colnames(newCol) <- paste0("Log of ", input$var)
      } 
      
      else if(input$select2 == "different") {
        newCol <- isolate(
          c(1-exp(-(values$df[input$var]/100)))
        )
        newCol <- as.data.frame(newCol)
        colnames(newCol) <- paste0(input$var, "Diff of", input$dr1)
      } 
      ### adding new modified columns to the dataframe ###
      isolate(
        values$d <- dplyr::bind_cols(values$d, newCol)
      )
      
    })
    
    output$table1 <- renderTable({
      d1 <- values$d
      nc <- ncol(d1)
      
      ### printing the whole dataframe (initial+modified) - skipping ###
      ### the first column of modified values, as it doesn't contain our data ###
      if(input$update == 0) {
        print(data.frame(test_df))
      } else {
        data.frame(values$df, d1[2:nc])
      }
    })
    
  }))