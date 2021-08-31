library(tidyverse)
library(ggplot2)
library(readr)
library(tidyr)
library(dplyr)
library(skimr)

setwd("/home/wikash/Documenten/Google programme/course7/scripts/challenge/")
flavors_df <- read_csv("flavors_of_cacao.csv")

str(flavors_df)
colnames(flavors_df)

flavors_df

trimmed_flavors_df <- flavors_df %>% 
	rename(Maker = `Company (Maker-if known)`) %>% 
	select(Rating, `Cocoa Percent`, Maker, `Company Location`)
	
trimmed_flavors_df %>%
	summarise(maxrating = max(Rating))

# Parse cocoa percentages as numbers
trimmed_flavors_df$`Cocoa Percent` <- parse_number(trimmed_flavors_df$`Cocoa Percent`)
trimmed_flavors_df$`Cocoa Percent`

# Apply filter rating of at least 3.75 AND at least 80% cocoa rating.
best_trimmed_flavors_df <- trimmed_flavors_df %>% 
	filter(Rating >= 3.75) %>% 
	filter(`Cocoa Percent` >= 80)

best_trimmed_flavors_df

ggplot(data = best_trimmed_flavors_df) + 
	geom_bar(mapping = aes(x = Rating))


ggplot(data = best_trimmed_flavors_df) +
	geom_bar(mapping = aes(x = `Company Location`, fill = Rating))

ggplot(data = best_trimmed_flavors_df) +
	geom_bar(mapping = aes(x = Maker)) + 
	facet_wrap(~Maker)


ggplot(data = trimmed_flavors_df) +
	geom_point(mapping = aes(x = `Cocoa Percent`, y = Rating)) +
	labs(title = "Best Chocolates")


ggplot(data = trimmed_flavors_df) +
	geom_point(mapping = aes(x = `Cocoa Percent`, y = Rating)) 
ggsave("chocolate.png")	
