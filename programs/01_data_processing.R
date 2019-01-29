#' # Processing data from Google form
#' 
#' Description: Takes raw csv file from the Google form and updates it for analysis.
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
set.seed(2647)

#' _____________________________________________________________________________
#' ## Load Data
#' 
raw_data <- read.csv(file = "data/google_form_data_raw.csv", stringsAsFactors = F,
                     header = T)
str(raw_data)

#' _____________________________________________________________________________
#' ## Fill in missing data
#' 
#' ### The question "Was this study reviewed?" was added after a few survey
#'  responses were filled in, so I will update those records with "TRUE"
#' 
#' View responses to this column
table(raw_data$Was.this.paper.reviewed..)
#' Replace "" with "True"
raw_data$Was.this.paper.reviewed.. <- ifelse(
  test = raw_data$Was.this.paper.reviewed.. == "", 
  yes = "True", 
  no = raw_data$Was.this.paper.reviewed..)
#' Double check that it worked
table(raw_data$Was.this.paper.reviewed..)

#' _____________________________________________________________________________
#' ## Why weren't studies reviewed?
#' 
#' ### Create and fill out a new column for "Why not reviewed"
raw_data$Why.not.reviewed <- NA
#' 
#' If unsuitable, add this information in:
raw_data$Why.not.reviewed[raw_data$Was.this.paper.reviewed..=="False, unsuitable for review"] <- 
  "Unsuitable for review"
#' 
#' If author never responded, add this information in:
raw_data$Why.not.reviewed[raw_data$Was.this.paper.reviewed..=="False, author never responded"] <- 
  "No correspondence"
#' 
#' In two cases, a study was initially thought to be not reviewed but it was. One 
#' example of this was jwm027, where the author was slow to respond, but eventually
#' did send us data. This was classified incorrectly in Google form as "False, 
#' author never responded." I need to remove this specific data point.
new_data <- raw_data[!(raw_data$Study.ID..e.g...wsb002.or.jwm040. == "jwm027" &
                     raw_data$Was.this.paper.reviewed.. == "False, author never responded"),]
#' In the second case, we had to send in a written proposal to a regulatory agency to get
#' the data. We thought that we would not get the proposal accepted, so we thought 
#' that we would be unable to review this project. But, in the end, the proposal was accepted and
#' we reviewed this study. I will need to remove the data point that incorrectly
#' files wsb038 as "False, for other reasons not stated above"
new_data <- new_data[!(new_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb038" &
                         new_data$Was.this.paper.reviewed.. == "False, for other reasons not stated above"),]

#' ### Track down reasons for "False, author declined to participate..."
#' 
#' 

#' _____________________________________________________________________________
#' ## 3rd Section of Code
#' 
#' 

#' _____________________________________________________________________________
#' ## Save Data
#' 
#' 

#' _____________________________________________________________________________
#' ## Footer
#' 
devtools::session_info()
#' spun with:
#' ezknitr::ezspin(file = "programs/01_data_processing.R", keep_md = FALSE, out_dir = "html_reports", fig_dir = "figures")
