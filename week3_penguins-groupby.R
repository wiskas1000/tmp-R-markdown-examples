penguins %>% 
	drop_na() %>% 
	group_by(species) %>%
	summarize(max(flipper_length_mm))

penguins %>% 
	drop_na() %>% 
	group_by(species) %>%
	summarize(min(bill_depth_mm))

