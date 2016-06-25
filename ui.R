library(shiny)
library(shinythemes)
library(chorddiag)

shinyUI(fluidPage(theme = "superhero.css",
  titlePanel("Distribution of digits of Pi"),
  sidebarPanel(
  sliderInput("number", "N of decimal digits:", 
                min=0, max=10000, value=1000, step = 10),
  
  selectInput("colors", label = h3("Select pallete"), 
              choices = list("Set1", "Set2", "Set3", "Dark2", "Accent"), 
              selected = 'Set3')
  )
   ,          
  mainPanel(
            chorddiagOutput('chorddiag',height = 750, width = 750)
  )
  
    ))
