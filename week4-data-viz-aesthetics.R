library(ggplot2)
library(palmerpenguins)

penguins
data(penguins)

plot(penguins$body_mass_g, penguins$flipper_length_mm)
body_mass_g

ggplot(data=penguins) + geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g))
ggplot(data=penguins) + geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species, shape=species, size = bill_depth_mm))
ggplot(data=penguins) + geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species, alpha=species, size = bill_depth_mm))

ggplot(data=penguins) + geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g), color="purple")


ggplot(data=penguins) + geom_point(mapping = aes(x = bill_length_mm, y =  bill_depth_mm, color=species))

ggplot(data=penguins) + geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g))
