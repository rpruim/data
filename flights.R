library(tidyverse)
library(nycflights13)
library(mosaic)

some_flights <-
  flights |>
  filter(
    dest %in% c("LAX", "SFO", "BQN"),
    carrier %in% c("B6", "UA")
  ) |>
  mutate(
    status = if_else(arr_delay <= 0, "on time", "delayed")
  ) |>
  drop_na() |>
  select(
    year,
    month,
    day,
    sched_dep_time,
    carrier,
    flight,
    destination = dest,
    status,
    arr_delay
  )

write_csv(some_flights, "~/Courses/data/docs/some-flights.csv")

df_stats(
  status ~ carrier + destination,
  data = some_flights,
  props,
  format = "wide"
) # |> pull(prop_delayed)


df_stats(
  status ~ carrier,
  data = some_flights,
  props,
  format = "wide"
) |>
  pull(prop_delayed)
