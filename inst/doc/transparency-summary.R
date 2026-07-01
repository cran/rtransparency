## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
has_ggplot <- requireNamespace("ggplot2", quietly = TRUE)

## -----------------------------------------------------------------------------
library(rtransparency)

xml <- system.file(
  "extdata", "PMID32171256-PMC7071725.xml", package = "rtransparency"
)
one <- rt_all_pmc(xml, remove_ns = TRUE)
one[, c("pmid", "is_coi_pred", "is_fund_pred", "is_register_pred")]

## -----------------------------------------------------------------------------
data(rt_demo)
head(rt_demo)

## -----------------------------------------------------------------------------
s <- rt_summary(rt_demo)
knitr::kable(
  s[, c("label", "n_articles", "n_detected", "percent", "conf_low", "conf_high")],
  digits = 1,
  col.names = c("Indicator", "Assessed", "Detected", "%", "CI low", "CI high")
)

## -----------------------------------------------------------------------------
knitr::kable(
  s[, c("label", "percent", "adj_percent", "adj_low", "adj_high")],
  digits = 1,
  col.names = c("Indicator", "Apparent %", "Corrected %", "CI low", "CI high")
)

## -----------------------------------------------------------------------------
rt_accuracy

## -----------------------------------------------------------------------------
my_acc <- rt_accuracy
my_acc$sensitivity[my_acc$variable == "is_open_data"] <- 0.758
rt_summary(rt_demo, indicators = "is_open_data", accuracy = my_acc)[,
  c("label", "percent", "adj_percent")]

## -----------------------------------------------------------------------------
scored <- rt_score(rt_demo)
knitr::kable(
  as.data.frame(table(`Practices met` = scored$n_indicators)),
  col.names = c("Practices met", "Articles")
)

## -----------------------------------------------------------------------------
by_type <- rt_summary(rt_demo, by = "type", adjust = FALSE)
knitr::kable(
  by_type[by_type$indicator == "is_open_data",
          c("type", "label", "n_articles", "percent")],
  digits = 1,
  col.names = c("Type", "Indicator", "Assessed", "%")
)

## ----eval = has_ggplot, fig.width = 7, fig.height = 3.5, fig.alt = "Bar chart of the prevalence of each transparency indicator"----
library(ggplot2)
rt_plot(rt_demo) + ggtitle("Transparency indicators in rt_demo")

## ----eval = has_ggplot, fig.width = 7, fig.height = 4, fig.alt = "Line chart of each transparency indicator's prevalence by year"----
rt_plot(rt_demo, type = "trend", year = "year")

## ----eval = has_ggplot, fig.width = 7, fig.height = 3.5, fig.alt = "Line chart of AI-use disclosure prevalence by year from 2023"----
rt_plot(rt_demo, type = "trend", year = "year", indicators = "is_ai_pred") +
  ggtitle("Disclosure of generative-AI use, 2023 onward")

