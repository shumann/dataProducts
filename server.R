# Load required library
library(shiny)
library(ggplot2)

# This function defines the normal plot and the vertical lines with the sample mean boundaries
    normal_prob_area_plot <- function(lb, ub, mean = 0, sd = 1, x_bar=0, limits = c(mean - 4 * sd, mean + 4 * sd)) {
        x <- seq(limits[1], limits[2], length.out = 100)
        xmin <- max(lb, limits[1])
        xmax <- min(ub, limits[2])
     #   areax <- seq(xmin, xmax, length.out = 100)
     #   area <- data.frame(x = areax, ymin = 0, ymax = dnorm(areax, mean = mean, sd = sd))
        (ggplot()
         + geom_line(data.frame(x = x, y = dnorm(x, mean = mean, sd = sd)),
                     mapping = aes(x = x, y = y))
         + geom_vline(xintercept=x_bar)
         + geom_vline(xintercept=mean+(mean-x_bar))
    #     + geom_ribbon(data = area, mapping = aes(x = x, ymin = ymin, ymax = ymax))
         + scale_x_continuous(limits = limits))
    }


# Define server logic required to draw the normal plot
shinyServer(function(input, output) {
  
    # The oid's are for verbatimTextOutput in ui.R
    output$oid1 <- renderPrint({input$id1})
    output$oid2 <- renderPrint({input$id2})
    output$oid3 <- renderPrint({input$id3})
    output$oid4 <- renderPrint({input$id4})    
    
    # Renders the p value in reactive mode
    output$oid5 <- renderPrint({
        mu <- input$id1
        sd <- input$id2
        n  <- input$id3
        x_bar <- input$id4
        z <- (x_bar - mu)/(sd/sqrt(n))
        p_val <- 2*pnorm(-abs(z))
        if (p_val < 0.05) {
            output <- paste(as.character(p_val), "is less than 0.05 and therefore please reject the null hypothesis.", " ")
        }
        else {output <- paste(as.character(p_val), "is greater than 0.05 and therefore please do not reject the null hypothesis.", " ")}
        output})
    
    # Expression that generates a plot. The expression is
    # wrapped in a call to renderPlot to indicate that:
    #
    #  1) It is "reactive" and therefore should re-execute automatically
    #     when inputs change
    #  2) Its output type is a plot
    
    
    output$distPlot <- renderPlot({
#       # input$goButton
#         x    <- faithful[, 2]  # Old Faithful Geyser data
#         bins <- seq(min(x), max(x), length.out = input$bins + 1)
#         
#         # draw the histogram with the specified number of bins
#         hist(x,  breaks = bins, col = 'darkgray', border = 'white')
#         #text(p_val)
        mu <- input$id1;
        sd <- input$id2;
        n  <- input$id3;
        x_bar <- input$id4;
        z <- (x_bar - mu)/(sd/sqrt(n));
        p_val <- 2*pnorm(-abs(z));
        normal_prob_area_plot(0.7*mu, Inf, mean=mu, sd=sd, x_bar=x_bar)
        
  })
})