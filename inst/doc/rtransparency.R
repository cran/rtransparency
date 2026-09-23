## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  message = FALSE,
  warning = FALSE
)

## ----setup--------------------------------------------------------------------
library(rtransparency)

## -----------------------------------------------------------------------------
xml_path <- system.file(
  "extdata", "PMID32171256-PMC7071725.xml", package = "rtransparency"
)

## -----------------------------------------------------------------------------
all_indicators <- rt_all_pmc(xml_path)

dplyr::glimpse(
  all_indicators[, c("pmid", "year", "is_coi_pred", "is_fund_pred",
                     "is_register_pred", "is_novelty_pred", "is_replication_pred",
                     "is_open_data", "is_open_code", "is_ai_pred",
                     "is_open_access", "is_reporting_pred")]
)

## -----------------------------------------------------------------------------
coi <- rt_coi_pmc(xml_path)
c(is_coi = coi$is_coi_pred, text = substr(coi$coi_text, 1, 120))

## -----------------------------------------------------------------------------
fund <- rt_fund_pmc(xml_path)
c(is_fund = fund$is_fund_pred, text = substr(fund$fund_text, 1, 120))

## -----------------------------------------------------------------------------
register <- rt_register_pmc(xml_path)
register$is_register_pred

## -----------------------------------------------------------------------------
data_code <- rt_data_code_pmc(xml_path)

dplyr::glimpse(
  data_code[, c("is_open_data", "open_data_statements",
                "is_open_code", "open_code_statements")]
)

## -----------------------------------------------------------------------------
meta <- rt_meta_pmc(xml_path)
dplyr::glimpse(meta[, c("pmid", "doi")])

## -----------------------------------------------------------------------------
ai <- rt_ai_pmc(xml_path)
c(year = ai$year, is_ai = ai$is_ai_pred)

## ----eval = FALSE-------------------------------------------------------------
# pdf_path <- system.file(
#   "extdata", "PMID32171256-PMC7071725.pdf", package = "rtransparency"
# )
# rt_all_pdf(pdf_path)                 # all ten indicators from a PDF
# 
# article <- rt_read_pdf(pdf_path)     # or extract the text once ...
# rt_coi(text = article)               # ... and run any detector on it
# rt_all(text = article)
# 
# rt_all("article.txt")                # a text file works the same way
# rt_all_txt_dir("path/to/articles")   # a directory of TXT and PDF files

## ----eval = FALSE-------------------------------------------------------------
# # Sequential, in memory
# res <- rt_all_pmc_dir("path/to/xml")
# 
# # Resumable and parallel: results are written to a CSV in chunks, a re-run skips
# # files already recorded, and a malformed file yields an is_success = FALSE row
# # instead of aborting the run.
# future::plan("multisession")
# res <- rt_all_pmc_dir(
#   "path/to/xml", output = "results.csv", parallel = TRUE
# )

## -----------------------------------------------------------------------------
data(rt_demo)            # a small simulated example shipped with the package
rt_summary(rt_demo)[, c("indicator", "percent", "adj_percent")]

## ----eval = FALSE-------------------------------------------------------------
# got <- rt_fetch_pmc(c("PMC7071725", "32171256"), dir = "xml")
# res <- rt_all_pmc_dir("xml")

