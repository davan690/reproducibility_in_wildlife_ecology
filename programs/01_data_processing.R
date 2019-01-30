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
raw_data <- read.csv(file = "data/google_form_data_raw.csv", 
                     stringsAsFactors = F,
                     header = T)
str(raw_data)

#' _____________________________________________________________________________
#' ## Fill in missing data
#' 
#' ### The question "Was this study reviewed?" was added after a few survey
#'  responses were filled in, so I will update those records with "TRUE"
#' 
#' View responses to this column
table(raw_data$Was.this.paper.reviewed.)
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

#' Fill in with "NA-Was reviewed" for all reviewed studies:
raw_data$Why.not.reviewed[raw_data$Was.this.paper.reviewed..=="True"] <- "NA: Study was reviewed"
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
#' What studies was this true for?
new_data$Study.ID..e.g...wsb002.or.jwm040.[new_data$Was.this.paper.reviewed.. == 
                    "False, author declined to participate (e.g., private data, no time, etc)"]

#' I want to classify responses:
#' 
#' - jwm003: proprietary/confidential data
#' - jwm005: no reason given, just declined to participate
#' - jwm011: not enough time to prepare data
#' - jwm016: future articles on same data
#' - jwm031: no reason given, just declined to participate
#' - wsb001: proprietary/confidential data
#' - wsb005: not enough time to prepare data
#' - wsb039: proprietary/confidential data
#' - wsb037: proprietary/confidential data, *noteably, author states the study is not reproducible*
#' - jwm036: not enough time to prepare data, *noteably, author states the study is not reproducible*
#' 
new_data$Why.not.reviewed <- ifelse(test = 
                                      new_data$Study.ID..e.g...wsb002.or.jwm040. == "jwm003" |
                                      new_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb039" |
                                      new_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb037" |
                                      new_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb001",
                                    yes = "Author Declined: Proprietary/confidential data", 
                                    no = ifelse(test = 
                                                  new_data$Study.ID..e.g...wsb002.or.jwm040. == "jwm005" |
                                                  new_data$Study.ID..e.g...wsb002.or.jwm040. == "jwm031",
                                                yes = "Author Declined: No reason given",
                                                no = ifelse(test = 
                                                              new_data$Study.ID..e.g...wsb002.or.jwm040. == "jwm011" |
                                                              new_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb005" |
                                                              new_data$Study.ID..e.g...wsb002.or.jwm040. == "jwm036",
                                                            yes = "Author Declined: Not enough time",
                                                            no = ifelse(test = new_data$Study.ID..e.g...wsb002.or.jwm040. == "jwm016",
                                                                        yes = "Author Declined: Data saved for future article",
                                                                        no = new_data$Why.not.reviewed))
                                    ))

#' ### Track down reasons for "False, for other reasons not stated above"
#' 
#' What studies was this true for?
new_data$Study.ID..e.g...wsb002.or.jwm040.[new_data$Was.this.paper.reviewed.. ==
                                             "False, for other reasons not stated above"]
#' Classify reasons:
#' 
#' - wsb020: unable to contact primary investigator, but co-author informed us also proprietary/confidential data
#' - wsb029: did not hear back from author, incorrectly coded: should have been "No correspondence"
#' - wsb007: author wanted to participate, but did not send data in time
#' - wsb027: author wanted to participate, but did not send data in time
#' - jwm038: unable to find email for author, incorrectly coded: Should have been "No correspondence"
#' 
new_data$Why.not.reviewed <- ifelse(test = 
                                      new_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb020", 
                                    yes = "Author Declined: Proprietary/confidential data",
                                    no = ifelse(test = 
                                                  new_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb029" |
                                                  new_data$Study.ID..e.g...wsb002.or.jwm040. == "jwm038",
                                                yes = "No correspondence",
                                                no = ifelse(test = 
                                                              new_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb007" |
                                                              new_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb027",
                                                            yes = "Author wanted to participate, but did not send data",
                                                            no = new_data$Why.not.reviewed)))

#' Look at results
table(new_data$Why.not.reviewed)
sum(table(new_data$Why.not.reviewed))


#' _____________________________________________________________________________
#' ## Summarize results for studies that were reviewed
#' 
#' There were two reviewers for each reviewed study:
#' 
table(new_data$Study.ID..e.g...wsb002.or.jwm040.[new_data$Was.this.paper.reviewed..=="True"])
#' 
#' So, we need to average the scores to the questions:
#' 
#' - "Were.the.study.s.figures.reproduced.." 
#' - "Were.the.numbers.in.the.study.s.tables.and.or.results.text.quantitatively.reproduced.."
#' - "Were.the.study.s.conclusions.reproduced.." 
#' 
#' Subset data to reviewed studies only and check for missing data, where there should be data:
reviewed_data <- new_data[new_data$Was.this.paper.reviewed..=="True",]
summary(reviewed_data$Were.the.study.s.figures.reproduced..)
summary(reviewed_data$Were.the.numbers.in.the.study.s.tables.and.or.results.text.quantitatively.reproduced..)
summary(reviewed_data$Were.the.study.s.conclusions.reproduced..)
#' For one of these studies with NAs, there were no figures, so I will replace with a "99"
reviewed_data$Were.the.study.s.figures.reproduced..[reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb018"] <- 99
#' For another of these studies, the study was completely unreproducible, so the 
#' reviewer erroneously didn't answer these questions. These should have been "1s"
reviewed_data$Were.the.study.s.figures.reproduced..[reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb008"] <- 1
reviewed_data$Were.the.numbers.in.the.study.s.tables.and.or.results.text.quantitatively.reproduced..[
  reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb008"] <- 1
reviewed_data$Were.the.study.s.conclusions.reproduced..[reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb008"] <- 1


#' Summarize information by reviewed study with a for-loop
study_names <- unique(reviewed_data$Study.ID..e.g...wsb002.or.jwm040.)
for(ss in 1:length(study_names)){
  subsetdata <- reviewed_data[reviewed_data$Study.ID..e.g...wsb002.or.jwm040.==study_names[ss],]
  
  # Check for disagreements amongst answers
  if(length(unique(subsetdata[,"Data.readily.available."]))>=2){
    print(paste(study_names[ss], "error: data readily available"))
  }
  if(length(unique(subsetdata[,"Was.the.data.pre.processed.or.shared.in.original.raw.format." ]))>=2){
    print(paste(study_names[ss], "error: was data pre processed"))
  }
  if(length(unique(subsetdata[,"Code.available" ]))>=2){
    print(paste(study_names[ss], "error: code available"))
  }
  if(length(unique(subsetdata[,"Analysis.was.entirely.code.based" ]))>=2){
    print(paste(study_names[ss], "error: was analysis code based"))
  }
}

#' Fix anomolies listed above:
#' 
#' 1. Data was readily available 
#' 
#' Data was sent by author so "was data readily available" should be "False"
#' 
#' *True for: wsb028, wsb018, wsb006, wsb014, wsb008*
#' 
#' Data was available in paper, so "was data readily available" should be "True"
#' 
#' *True for: wsb035, jwm022*
#' 
reviewed_data$Data.readily.available. <- ifelse(
  test = reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb028" |
    reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb018" |
    reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb006" |
    reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb014" |
    reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb008",
  yes = "False",
  no = ifelse(
    test = reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb035" |
      reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "jwm022",
    yes = "True",
    no = reviewed_data$Data.readily.available.
  )
)
#' 2. Was code available?
#' 
#' For jwm022 and wsb008, code actually was available
#' 
#' For wsb013 and wsb014, analysis was not code-based so should be "Not applicable.."
#' 
reviewed_data$Code.available <- ifelse(
  test = reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "jwm022" |
    reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb008",
  yes = "True",
  no = ifelse(
    test = reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb013" |
      reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb014",
    yes = "Not applicable (e.g., not analyzed with code-based software)",
    no = reviewed_data$Code.available
  ))
#' 3. Analysis was entirely code based
#' 
#' Actually true for wsb035, jwm010, wsb006, wsb023
reviewed_data$Analysis.was.entirely.code.based <- ifelse(
  test = reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb035" |
    reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "jwm010" |
    reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb006" |
    reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb023",
  yes = "True",
  no = reviewed_data$Analysis.was.entirely.code.based)

#' 4. Data was pre-processed
#' 
#' True for wsb004 and wsb010, but raw data for jwm010, wsb006, jwm022
#' 
reviewed_data$Was.the.data.pre.processed.or.shared.in.original.raw.format. <- ifelse(
  test = reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb004" |
    reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb010",
  yes = "Pre-processed",
  no = ifelse(
    test = reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "jwm010" |
      reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "wsb006" |
      reviewed_data$Study.ID..e.g...wsb002.or.jwm040. == "jwm022",
    yes = "Raw format",
    no = reviewed_data$Was.the.data.pre.processed.or.shared.in.original.raw.format.
  ))

#' ### Average numerical results and simultaneously check for errors
#' 
#' New dataset for averaged data
averages <- as.data.frame(matrix(NA, ncol = 4, nrow = length(study_names)))
colnames(averages) <- c("studyID", "graphsReproduced", "numbersReproduced", "conclusionsReproduced")
#' 
for(ss in 1:length(study_names)){
  subsetdata <- reviewed_data[reviewed_data$Study.ID..e.g...wsb002.or.jwm040.==study_names[ss],]
  
  # Check for disagreements amongst answers
  if(length(unique(subsetdata[,"Data.readily.available."]))>=2){
    print(paste(study_names[ss], "error: data readily available"))
  }
  if(length(unique(subsetdata[,"Was.the.data.pre.processed.or.shared.in.original.raw.format." ]))>=2){
    print(paste(study_names[ss], "error: was data pre processed"))
  }
  if(length(unique(subsetdata[,"Code.available" ]))>=2){
    print(paste(study_names[ss], "error: code available"))
  }
  if(length(unique(subsetdata[,"Analysis.was.entirely.code.based" ]))>=2){
    print(paste(study_names[ss], "error: was analysis code based"))
  }
  
  # Average over numerical responses
  averages$studyID[ss] <- study_names[ss]
  averages$graphsReproduced[ss] <- ifelse(study_names[ss] == "wsb018",
                                          yes = NA,
                                          no = mean(subsetdata$Were.the.study.s.figures.reproduced.., na.rm = T))
  averages$numbersReproduced[ss] <- 
    mean(subsetdata$Were.the.numbers.in.the.study.s.tables.and.or.results.text.quantitatively.reproduced..)
  averages$conclusionsReproduced[ss] <- 
    mean(subsetdata$Were.the.study.s.conclusions.reproduced..)
}
# Do results look right?
summary(averages)


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
