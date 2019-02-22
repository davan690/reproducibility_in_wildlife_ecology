#' # Figure 1 Data
#' 
#' Description: Data on overall fate of all 80 studies for Figure 1 of paper
#' 
#' Coder name(s): Althea ArchMiller
#' 
#' 
#' _____________________________________________________________________________
#' ## Preamble
#' 
#' Load libraries
#' 
#+ library, warnings = "hide"
library(ezknitr)
library(knitr)
library(devtools)

#' Clear environment and set seed
#' 
remove(list=ls())
set.seed(8675)

#' _____________________________________________________________________________
#' ## Load Data
#' 
#' 
load(file = "data/processed_data/averages_of_reviewed_studies.Rdata")
load(file = "data/processed_data/reviewed_studies_data.Rdata")
load(file = "data/processed_data/all_studies_data.Rdata")



#' 
#' _____________________________________________________________________________
#' ## Status of all 80 studies
#' 
table(new_data$Why.not.reviewed)

#' Status by Journal: JWM
table(new_data$Why.not.reviewed[new_data$journal=="JWM"])

#' Status by Journal: WSB
table(new_data$Why.not.reviewed[new_data$journal=="WSB"])

#' 
#' _____________________________________________________________________________
#' ## How well were the reviewed studies conclusions met?
#' 
sort(averages$conclusionsReproduced)
hist(averages$conclusionsReproduced)

#' By journal: JWM
sort(averages$conclusionsReproduced[averages$journal=="JWM"])
hist(averages$conclusionsReproduced[averages$journal=="JWM"])

#' By jounral: WSB
sort(averages$conclusionsReproduced[averages$journal=="WSB"])
hist(averages$conclusionsReproduced[averages$journal=="WSB"])

#' _____________________________________________________________________________
#' ## Footer
#' 
devtools::session_info()
#' spun with:
#' ezknitr::ezspin(file = "programs/02_study_overview_figure.R", keep_md = FALSE, out_dir = "html_reports", fig_dir = "figures")
