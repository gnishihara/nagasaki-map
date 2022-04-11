library(tidyverse)　# Essential package
library(sf)         # Essential for map data manipulation
library(furrr)
library(lubridate)
plan(multisession, workers = 30)
mlit0 = read_sf("~/Lab_Data/Japan_map_data/Japan/N03-20210101_GML/")
# Group by prefecture
t0 = now()
mlit1 = mlit0 |> group_nest(N03_001) |> 
  mutate(data = future_map(data, st_union)) |> 
  unnest(data) |> st_as_sf() 
now() - t0
mlit1 |> write_rds("~/Lab_Data/Japan_map_data/Japan/todofuken.rds")
