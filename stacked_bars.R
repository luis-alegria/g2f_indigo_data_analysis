# Create Plots from Read Count Data
library(tidyverse)
library(gridExtra)
library(ggpubr)

data <- read.csv("./genus_transpose.csv")

#Function for sample data structuring and plots
read_plots <- function(sample) {
  # function body - code that performs the task
  non_zero <- sample %>% 
    select(where(~any(.x > 0)))
  
  non_zero_long <- non_zero %>% 
    pivot_longer(!X, names_to = "Genus", values_to = "read_count")
  
  counts <- ggplot(non_zero_long, aes(x=X, y=read_count, fill = Genus)) +
    geom_bar(stat = "identity", position = "stack") + 
    guides(fill = guide_legend(ncol = 3)) +
    ylab("Read Count") +
    theme(axis.title.x=element_blank())
  
  legend_obj <- get_legend(counts)
  
  counts <- ggplot(non_zero_long, aes(x=X, y=read_count, fill = Genus)) +
    geom_bar(stat = "identity", position = "stack") + 
    guides(fill = guide_legend(ncol = 3)) +
    ylab("Read Count") +
    theme(legend.position="none", axis.title.x=element_blank())
  
  percent <- ggplot(non_zero_long, aes(x=X, y=read_count, fill = Genus)) +
    geom_bar(stat = "identity", position = "fill") +
    ylab("Read Percent") +
    theme(legend.position="none", axis.title.x=element_blank())
  
  plots <- grid.arrange(counts, percent, legend_obj, ncol=3)
  # return value (optional, last evaluated expression is returned by default)
  return()
}


for (sample in 1:nrow(dataframe)) {
  sample_reads <- data[sample,]
  charts <- read_plots(sample_reads)
  plotlist <- append(plotlist, charts)
  } 

# ggarrange(plotlist, nrow = 2, ncol = 1)

# #1. Select sample to test
# 
# test <- data[1,]
# 
# #2. Select non-zero
# non_zero <- test %>% 
#   select(where(~any(.x > 0)))
# 
# #3. convert to long format 
# 
# test_long <- non_zero %>% 
#   pivot_longer(!X, names_to = "genus", values_to = "read_count")
# 
# # Generate plots yo
# # Total 
# ggplot(test_long, aes(x=X, y=read_count, fill = genus)) +
#   geom_bar(stat = "identity", position = "stack") + 
#   theme(axis.title.x=element_blank()) +
#   guides(fill = guide_legend(ncol = 2)) +
#   ylab("Read Count")
# 
# legend_obj <- get_legend()
# # Percent
# ggplot(test_long, aes(x=X, y=read_count, fill = genus)) +
#   geom_bar(stat = "identity", position = "fill") +
#   ylab("Read Percent") +
#   theme(legend.position="none", axis.title.x=element_blank())
