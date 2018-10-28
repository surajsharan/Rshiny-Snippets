
library(shiny)
library(shinyjs)




ui <- fluidPage(useShinyjs(),
  actionButton("showVideo", "Video")
  
)


server <- function(input, output)
{
  observeEvent(input$showVideo,{
    showModal(
      modalDialog(Title="Intro Video",
                  HTML('<iframe class="youtube-video" width="560" height="315" src="https://www.youtube.com/embed/r44RKWyfcFw?enablejsapi=1&version=3&playerapiid=ytplayer" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen allowscriptaccess="always"></iframe>')
      ,
      footer = tagList(
        actionButton("close","Close")	
      ),easyClose = T)
    )
  })
  
  observeEvent(input$close,{
    removeModal()
  })
  
  
  
  
}


shinyApp(ui, server)