#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(ggplot2)
library(gridExtra)
library(ggpubr)

data <- read.csv("./genus_transpose.csv")

# Define server logic required to plot
function(input, output, session) {

    output$plot <- renderPlot({

        # generate bins based on input$bins from ui.R
        sampleplot <- data[data$X == input$sample,]
        
        non_zero <- sampleplot %>%
          select(where(~any(.x > 0)))
        
        non_zero_long <- non_zero %>% 
          pivot_longer(!X, names_to = "Genus", values_to = "read_count")
        
        ggplot(non_zero_long, aes(x=X, y=read_count, fill = Genus)) +
          geom_bar(stat = "identity", position = "stack") + 
          guides(fill = guide_legend(ncol = 4)) +
          ylab("Read Count") +
          theme(axis.title.x=element_blank())
        
        # legend_obj <- get_legend(counts)
        # 
        # counts <- ggplot(non_zero_long, aes(x=X, y=read_count, fill = Genus)) +
        #   geom_bar(stat = "identity", position = "stack") + 
        #   guides(fill = guide_legend(ncol = 3)) +
        #   ylab("Read Count") +
        #   theme(legend.position="none", axis.title.x=element_blank())
        # 
        # percent <- ggplot(non_zero_long, aes(x=X, y=read_count, fill = Genus)) +
        #   geom_bar(stat = "identity", position = "fill") +
        #   ylab("Read Percent") +
        #   theme(legend.position="none", axis.title.x=element_blank())
        # 
        # grid.arrange(counts, percent, legend_obj, ncol=2, nrow=3,
        #              layout_matrix = cbind(c(1,3,3), c(2,3,3)))

    })

}
