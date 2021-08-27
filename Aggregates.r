---
title: "Aggregates in R"
output: html_notebook
---

```{r message = FALSE, error=TRUE}
# load packages
library(readr)
library(dplyr)
```

```{r message = FALSE, error=TRUE}
# load ad clicks data
ad_clicks <- read_csv("ad_clicks.csv")
```

```{r error=TRUE}
# inspect ad_clicks here:
head(ad_clicks)
```

```{r error=TRUE}
# define views_by_utm here:
views_by_utm <- ad_clicks %>%
  group_by(utm_source) %>%
  summarize(count=n())
head(views_by_utm)


```

```{r error=TRUE}
# define clicks_by_utm here:
clicks_by_utm <- ad_clicks %>%
  group_by(utm_source, ad_clicked) %>%
  summarize(count=n())
head(clicks_by_utm)


```

```{r error=TRUE}
# define percentage_by_utm here:
percentage_by_utm <- clicks_by_utm %>%
  group_by(utm_source) %>%
  mutate(percentage=(count/sum(count)))
head(percentage_by_utm)

percentage_by_utm <- percentage_by_utm %>%
  filter(ad_clicked == TRUE)
head(percentage_by_utm)
```

```{r error=TRUE}
# define experiment_split here:
experiment_split <- ad_clicks %>%
  group_by(experimental_group) %>%
  summarize(count=n())
head(experiment_split)


```

```{r error=TRUE}
# define clicks_by_experiment here:
clicks_by_experiment <- ad_clicks %>%
  group_by(ad_clicked, experimental_group) %>%
  summarize(count=n())
clicks_by_experiment


```

```{r error=TRUE}
# define a_clicks here:
a_clicks <- ad_clicks %>%
  filter(experimental_group == "A")
a_clicks


# define b_clicks here:
b_clicks <- ad_clicks %>%
  filter(experimental_group == "B")
b_clicks

```

```{r error=TRUE}
# define a_clicks_by_day here:
a_clicks_by_day <- a_clicks %>%
  group_by(day, ad_clicked) %>%
  summarize(count = n())

a_clicks_by_day


# define b_clicks_by_day here:
b_clicks_by_day <- b_clicks %>%
  group_by(day, ad_clicked) %>%
  summarize(count = n())

b_clicks_by_day


```

```{r error=TRUE}
# define a_percentage_by_day here:
a_percentage_by_day <- a_clicks_by_day %>%
  group_by(day) %>%
  mutate(percentage= count/(sum(a_clicks_by_day$count,na.rm=TRUE))) %>%
  filter(ad_clicked == TRUE)


a_percentage_by_day


# define b_percentage_by_day here:
b_percentage_by_day <- b_clicks_by_day %>%
  group_by(day) %>%
  mutate(percentage= count/(sum(b_clicks_by_day$count,na.rm=TRUE))) %>%
  filter(ad_clicked == TRUE)


b_percentage_by_day




```