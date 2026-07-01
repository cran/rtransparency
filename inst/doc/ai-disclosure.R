## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  message = FALSE,
  warning = FALSE
)
has_ggplot <- requireNamespace("ggplot2", quietly = TRUE)

## ----setup--------------------------------------------------------------------
library(rtransparency)

## -----------------------------------------------------------------------------
xml_path <- system.file(
  "extdata", "PMID32171256-PMC7071725.xml", package = "rtransparency"
)
ai <- rt_ai_pmc(xml_path, remove_ns = TRUE)
c(year = ai$year, is_ai_pred = ai$is_ai_pred)

## -----------------------------------------------------------------------------
all_indicators <- rt_all_pmc(xml_path, remove_ns = TRUE)
all_indicators[, c("pmid", "year", "is_ai_pred")]

## -----------------------------------------------------------------------------
data(rt_demo)
ai_by_year <- rt_summary(rt_demo, by = "year", indicators = "is_ai_pred")
# Years before 2023 have no assessable articles (all NA), so no denominator;
# keep only the years where the indicator applies.
ai_by_year <- ai_by_year[ai_by_year$n_articles > 0, ]
knitr::kable(
  ai_by_year[, c("year", "n_articles", "n_detected", "percent")],
  digits = 1,
  col.names = c("Year", "Assessed", "Disclosed", "%")
)

## ----eval = has_ggplot, fig.width = 7, fig.height = 3.5, fig.alt = "Line chart of generative-AI-use disclosure prevalence by year from 2023"----
library(ggplot2)
rt_plot(rt_demo, type = "trend", year = "year", indicators = "is_ai_pred") +
  ggtitle("Disclosure of generative-AI use (simulated corpus)")

## ----eval = has_ggplot, fig.width = 7, fig.height = 3.5, fig.alt = "Bar chart of all transparency indicators including AI-use disclosure"----
rt_plot(rt_demo) + ggtitle("Transparency indicators, including AI-use disclosure")

