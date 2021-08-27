---
title: "ACLU Child Separations"
output: html_notebook
---

```{r message=FALSE, warning=FALSE, error=TRUE}
# load libraries
library(readr)
library(dplyr)

```

```{r error=TRUE}
# load data
aclu <- read_csv("aclu_separations.csv")
```

```{r error=TRUE}
# inspect data
head(aclu)
summary(aclu)
```

```{r error=TRUE}
# select columns
aclu <- aclu %>% select(-addr)


```

```{r error=TRUE}
# view columns
print(aclu)
```

```{r error=TRUE}
# rename columns
aclu <- aclu %>% rename(
  city = program_city,
  state = program_state,
  number_children = n,
  longitude = lon,
  latitude = lat
)






```

```{r error=TRUE}
# add column
border_latitude <- 25.83
aclu <- aclu %>% mutate(lat_change_border = (border_latitude-latitude))
print(aclu)

```

```{r error=TRUE}
# latitude change
further_away <- aclu %>% filter(lat_change_border > 15)  %>% arrange(desc(lat_change_border))
print(further_away)


```

```{r error=TRUE}
# number of children
ordered_by_children <- aclu %>% arrange(desc(number_children))
print(ordered_by_children)

```

```{r error=TRUE}
# state analysis
chosen_state <- "TX"
chosen_state_separations <- aclu %>% filter(state == chosen_state)
print(chosen_state_separations)
chosen_state_separations <- chosen_state_separations %>% arrange(desc(number_children))
print(chosen_state_separations)

```