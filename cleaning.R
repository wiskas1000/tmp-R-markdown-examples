library(here)
library(skimr)
library(janitor)
library(dplyr)
library(palmerpenguins)

skim_without_charts(penguins)
glimpse(penguins)
head(penguins)

penguins %>% select(species)
penguins %>% select(-species)
penguins %>% select(!species)

penguins %>% rename(island_new=island)
penguins

rename_with(penguins, tolower)

clean_names(penguins)

# Sort descending order
penguins2 <- penguins %>% 
	arrange(-bill_length_mm)

View(penguins2)


library(tidyr)

# Group by
penguins %>% group_by(island) %>% 
	drop_na() %>% 
	summarize(mean_bill_length_mm = mean(bill_length_mm))

penguins %>% group_by(island) %>% 
	drop_na() %>% 
	summarize(max_bill_length_mm = max(bill_length_mm))

penguins %>% 
	group_by(species, island) %>% 
	drop_na() %>% 
	summarize(max_bl = max(bill_length_mm), mean_bl = mean(bill_length_mm))

# Filtering
penguins
penguins %>% 
	filter(species == "Adelie")
	