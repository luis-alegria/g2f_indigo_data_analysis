# R steps and commands to create stacked (total count)
data <- read.csv("./genus_transpose.csv")
library(tidyverse)


#1. Select sample to test

test <- data[1,]

#2. Select non-zero
non_zero <- test %>% 
  select(where(~any(.x > 0)))

#3. convert to long format 

test_long <- non_zero %>% 
  pivot_longer(!X, names_to = "genus", values_to = "read_count")

# Generate plot yo

ggplot(test_long, aes(x=X, y=read_count, fill = genus)) +
  geom_bar(stat = "identity", position = "stack")