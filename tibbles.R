library(tidyverse)
data(diamonds)
View(diamonds)
as_tibble(diamonds)
data()

% For Excel files
library(readxl)
read_excel(readxl_example("type-me.xlsx"))
excel_sheets(readxl_example("type-me.xlsx"))
read_excel(readxl_example("type-me.xlsx"), sheet = "numeric_coercion")
