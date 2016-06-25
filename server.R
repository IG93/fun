library(shiny)
library(data.table)
library(chorddiag)
library(Matrix)
library(RColorBrewer)

pi <- read.csv("data/data.csv")

shinyServer(
    function(input, output) {
      
      numberInput <- reactive({
        input$number
      })

      
        colorInput <- reactive({
        switch(input$colors,
               "Set1" = 'Set1',
               "Set2" = 'Set2',
               "Set3" = 'Set3',
               'Dark2' = 'Dark2',
               'Accent' = 'Accent')
      })
    
        
output$chorddiag <- renderChorddiag({
  length <- numberInput()
  pi <- pi[1:(length+1),] 
  p <- data.table(prev_n = pi[1:(length(pi) - 1)], next_n = pi[2:length(pi)])
  transition_matrix <- xtabs(formula =~ prev_n + next_n, data=p, sparse=T)
  transition_matrix <- transition_matrix / rowSums(transition_matrix)
  pallet <- colorInput()
  Colors <- colorRampPalette(brewer.pal(8, pallet))(17)
  chorddiag(as.matrix(transition_matrix),groupColors = Colors, groupnamePadding = 30, chordedgeColor = 'white')    
  })
})
