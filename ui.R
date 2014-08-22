library(shiny)

# Define UI for application for a significance test of a normal distribution
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Test for Significance of a Normal Distribution"),
  p('This app can be useful for testing a null hypothesis that a given population mean is TRUE or FALSE from the observed sample mean.'),
  p('It is assumed that you have been given a population mean (mu) and a population standard deviation (sd).'),
  p('Now you conduct experiment and observe a sample mean with n number of observations.'),
  p('Given this information you are trying to find out whether the given population mean is TRUE or FALSE by p value test.'),
  
  # Sidebar panel for the inputs
  sidebarLayout(
    sidebarPanel( 
        h3('Input Panel'),
        numericInput('id1', 'Enter the population mean (mu) of the normal distribution', 0),
        h6(c('Null hypothesis: population mean is mu = '), verbatimTextOutput("oid1")),
        h6('Alternate hypothesis: population mean is not mu'),

        
        numericInput('id2', 'Enter population standard deviation ', 1),
        verbatimTextOutput("oid2"),
        
        numericInput('id3', 'Enter number of sample observation(s) ', 10),
        verbatimTextOutput("oid3"),
        
        numericInput('id4', 'Enter observed sample mean', 0),
        verbatimTextOutput("oid4")
        
   ),
    
    # Show a plot of the generated distribution and p-value with the conclusion drawn
    mainPanel(
        h3('Output Panel'),
        p('Normal distribution plot with the given population mean and standard deviation '),
        plotOutput("distPlot"),
        p('p-Value for the sample mean'),
        verbatimTextOutput("oid5")
    )
  )
))
