library(ggplot2)
library(palmerpenguins)

penguins
data(penguins)

ggplot(data=penguins) + geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species)) + facet_wrap(~species)
										
data("diamonds")							 
ggplot(data=diamonds) + geom_bar(mapping = aes(x = color, fill = cut)) + facet_wrap(~cut)

# Split along 2 variables: facet_grid
ggplot(data=penguins) + geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species)) + facet_grid(sex~species)
