#' # Figure 3
#' 
#' Description: Scores by reproducibility criterion
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
library(ggplot2)

#' Clear environment and set seed
#' 
remove(list=ls())
set.seed(8675)

#' _____________________________________________________________________________
#' ## Load Data
#' 
#' 
load(file = "data/processed_data/averages_of_reviewed_studies.Rdata")



#' 
#' _____________________________________________________________________________
#' ## Empty dataset to fill in for plotting
#' 
#' 
plottingdata <- as.data.frame(matrix(NA, nrow = 30, ncol = 7))
colnames(plottingdata) <- c("Score", "SE", "upper", "lower", 
                            "Category", "Criterion", "CriterionStatus")

#' ### Fill in with Data Availability Criterion
#' 
#' Yes, graphs
plottingdata$Score[1] <- 
  mean(na.exclude(averages$graphsReproduced[averages$dataAvailable=="True"]))
plottingdata$SE[1] <- 
  sd(na.exclude(averages$graphsReproduced[averages$dataAvailable=="True"]))/
  sqrt(na.exclude(length(averages$graphsReproduced[averages$dataAvailable=="True"])))
plottingdata$Category[1] <- "Graphs Reproduced"
plottingdata$Criterion[1] <- "Data Available?"
plottingdata$CriterionStatus[1] <- "Yes"

#' No, graphs
plottingdata$Score[2] <- 
  mean(na.exclude(averages$graphsReproduced[averages$dataAvailable=="False"]))
plottingdata$SE[2] <- 
  sd(na.exclude(averages$graphsReproduced[averages$dataAvailable=="False"]))/
  sqrt(na.exclude(length(averages$graphsReproduced[averages$dataAvailable=="False"])))
plottingdata$Category[2] <- "Graphs Reproduced"
plottingdata$Criterion[2] <- "Data Available?"
plottingdata$CriterionStatus[2] <- "No"

#' Yes, numbers
plottingdata$Score[3] <- 
  mean(na.exclude(averages$numbersReproduced[averages$dataAvailable=="True"]))
plottingdata$SE[3] <- 
  sd(na.exclude(averages$numbersReproduced[averages$dataAvailable=="True"]))/
  sqrt(na.exclude(length(averages$numbersReproduced[averages$dataAvailable=="True"])))
plottingdata$Category[3] <- "Numbers Reproduced"
plottingdata$Criterion[3] <- "Data Available?"
plottingdata$CriterionStatus[3] <- "Yes"

#' No, numbers
plottingdata$Score[4] <- 
  mean(na.exclude(averages$numbersReproduced[averages$dataAvailable=="False"]))
plottingdata$SE[4] <- 
  sd(na.exclude(averages$numbersReproduced[averages$dataAvailable=="False"]))/
  sqrt(na.exclude(length(averages$numbersReproduced[averages$dataAvailable=="False"])))
plottingdata$Category[4] <- "Numbers Reproduced"
plottingdata$Criterion[4] <- "Data Available?"
plottingdata$CriterionStatus[4] <- "No"

#' Yes, conclusions
plottingdata$Score[5] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$dataAvailable=="True"]))
plottingdata$SE[5] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$dataAvailable=="True"]))/
  sqrt(na.exclude(length(averages$conclusionsReproduced[averages$dataAvailable=="True"])))
plottingdata$Category[5] <- "Conclusions Reproduced"
plottingdata$Criterion[5] <- "Data Available?"
plottingdata$CriterionStatus[5] <- "Yes"

#' No, conclusions
plottingdata$Score[6] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$dataAvailable=="False"]))
plottingdata$SE[6] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$dataAvailable=="False"]))/
  sqrt(na.exclude(length(averages$conclusionsReproduced[averages$dataAvailable=="False"])))
plottingdata$Category[6] <- "Conclusions Reproduced"
plottingdata$Criterion[6] <- "Data Available?"
plottingdata$CriterionStatus[6] <- "No"

#' ### Fill in with Data Raw Criterion
#' 
#' Yes, graphs
plottingdata$Score[7] <- 
  mean(na.exclude(averages$graphsReproduced[averages$preProcessed=="Raw format"]))
plottingdata$SE[7] <- 
  sd(na.exclude(averages$graphsReproduced[averages$preProcessed=="Raw format"]))/
  sqrt(na.exclude(length(averages$graphsReproduced[averages$preProcessed=="Raw format"])))
plottingdata$Category[7] <- "Graphs Reproduced"
plottingdata$Criterion[7] <- "Data raw?"
plottingdata$CriterionStatus[7] <- "Yes"

#' No, graphs
plottingdata$Score[8] <- 
  mean(na.exclude(averages$graphsReproduced[averages$preProcessed=="Pre-processed"]))
plottingdata$SE[8] <- 
  sd(na.exclude(averages$graphsReproduced[averages$preProcessed=="Pre-processed"]))/
  sqrt(na.exclude(length(averages$graphsReproduced[averages$preProcessed=="Pre-processed"])))
plottingdata$Category[8] <- "Graphs Reproduced"
plottingdata$Criterion[8] <- "Data raw?"
plottingdata$CriterionStatus[8] <- "No"

#' Yes, numbers
plottingdata$Score[9] <- 
  mean(na.exclude(averages$numbersReproduced[averages$preProcessed=="Raw format"]))
plottingdata$SE[9] <- 
  sd(na.exclude(averages$numbersReproduced[averages$preProcessed=="Raw format"]))/
  sqrt(na.exclude(length(averages$numbersReproduced[averages$preProcessed=="Raw format"])))
plottingdata$Category[9] <- "Numbers Reproduced"
plottingdata$Criterion[9] <- "Data raw?"
plottingdata$CriterionStatus[9] <- "Yes"

#' No, numbers
plottingdata$Score[10] <- 
  mean(na.exclude(averages$numbersReproduced[averages$preProcessed=="Pre-processed"]))
plottingdata$SE[10] <- 
  sd(na.exclude(averages$numbersReproduced[averages$preProcessed=="Pre-processed"]))/
  sqrt(na.exclude(length(averages$numbersReproduced[averages$preProcessed=="Pre-processed"])))
plottingdata$Category[10] <- "Numbers Reproduced"
plottingdata$Criterion[10] <- "Data raw?"
plottingdata$CriterionStatus[10] <- "No"

#' Yes, conclusions
plottingdata$Score[11] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$preProcessed=="Raw format"]))
plottingdata$SE[11] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$preProcessed=="Raw format"]))/
  sqrt(na.exclude(length(averages$conclusionsReproduced[averages$preProcessed=="Raw format"])))
plottingdata$Category[11] <- "Conclusions Reproduced"
plottingdata$Criterion[11] <- "Data raw?"
plottingdata$CriterionStatus[11] <- "Yes"

#' No, conclusions
plottingdata$Score[12] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$preProcessed=="Pre-processed"]))
plottingdata$SE[12] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$preProcessed=="Pre-processed"]))/
  sqrt(na.exclude(length(averages$conclusionsReproduced[averages$preProcessed=="Pre-processed"])))
plottingdata$Category[12] <- "Conclusions Reproduced"
plottingdata$Criterion[12] <- "Data raw?"
plottingdata$CriterionStatus[12] <- "No"

#' ### Fill in with Code Based Criterion
#' 
#' Yes, graphs
plottingdata$Score[13] <- 
  mean(na.exclude(averages$graphsReproduced[averages$codeBased=="True"]))
plottingdata$SE[13] <- 
  sd(na.exclude(averages$graphsReproduced[averages$codeBased=="True"]))/
  sqrt(na.exclude(length(averages$graphsReproduced[averages$codeBased=="True"])))
plottingdata$Category[13] <- "Graphs Reproduced"
plottingdata$Criterion[13] <- "Code based?"
plottingdata$CriterionStatus[13] <- "Yes"

#' No, graphs
plottingdata$Score[14] <- 
  mean(na.exclude(averages$graphsReproduced[averages$codeBased=="False"]))
plottingdata$SE[14] <- 
  sd(na.exclude(averages$graphsReproduced[averages$codeBased=="False"]))/
  sqrt(na.exclude(length(averages$graphsReproduced[averages$codeBased=="False"])))
plottingdata$Category[14] <- "Graphs Reproduced"
plottingdata$Criterion[14] <- "Code based?"
plottingdata$CriterionStatus[14] <- "No"

#' Yes, numbers
plottingdata$Score[15] <- 
  mean(na.exclude(averages$numbersReproduced[averages$codeBased=="True"]))
plottingdata$SE[15] <- 
  sd(na.exclude(averages$numbersReproduced[averages$codeBased=="True"]))/
  sqrt(na.exclude(length(averages$numbersReproduced[averages$codeBased=="True"])))
plottingdata$Category[15] <- "Numbers Reproduced"
plottingdata$Criterion[15] <- "Code based?"
plottingdata$CriterionStatus[15] <- "Yes"

#' No, numbers
plottingdata$Score[16] <- 
  mean(na.exclude(averages$numbersReproduced[averages$codeBased=="False"]))
plottingdata$SE[16] <- 
  sd(na.exclude(averages$numbersReproduced[averages$codeBased=="False"]))/
  sqrt(na.exclude(length(averages$numbersReproduced[averages$codeBased=="False"])))
plottingdata$Category[16] <- "Numbers Reproduced"
plottingdata$Criterion[16] <- "Code based?"
plottingdata$CriterionStatus[16] <- "No"

#' Yes, conclusions
plottingdata$Score[17] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$codeBased=="True"]))
plottingdata$SE[17] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$codeBased=="True"]))/
  sqrt(na.exclude(length(averages$conclusionsReproduced[averages$codeBased=="True"])))
plottingdata$Category[17] <- "Conclusions Reproduced"
plottingdata$Criterion[17] <- "Code based?"
plottingdata$CriterionStatus[17] <- "Yes"

#' No, conclusions
plottingdata$Score[18] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$codeBased=="False"]))
plottingdata$SE[18] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$codeBased=="False"]))/
  sqrt(na.exclude(length(averages$conclusionsReproduced[averages$codeBased=="False"])))
plottingdata$Category[18] <- "Conclusions Reproduced"
plottingdata$Criterion[18] <- "Code based?"
plottingdata$CriterionStatus[18] <- "No"

#' ### Fill in with Code Available Criterion
#' 
#' Yes, graphs
plottingdata$Score[19] <- 
  mean(na.exclude(averages$graphsReproduced[averages$codeAvailable=="True"]))
plottingdata$SE[19] <- 
  sd(na.exclude(averages$graphsReproduced[averages$codeAvailable=="True"]))/
  sqrt(na.exclude(length(averages$graphsReproduced[averages$codeAvailable=="True"])))
plottingdata$Category[19] <- "Graphs Reproduced"
plottingdata$Criterion[19] <- "Code available?"
plottingdata$CriterionStatus[19] <- "Yes"

#' No, graphs
plottingdata$Score[20] <- 
  mean(na.exclude(averages$graphsReproduced[averages$codeAvailable=="False"]))
plottingdata$SE[20] <- 
  sd(na.exclude(averages$graphsReproduced[averages$codeAvailable=="False"]))/
  sqrt(na.exclude(length(averages$graphsReproduced[averages$codeAvailable=="False"])))
plottingdata$Category[20] <- "Graphs Reproduced"
plottingdata$Criterion[20] <- "Code available?"
plottingdata$CriterionStatus[20] <- "No"

#' Yes, numbers
plottingdata$Score[21] <- 
  mean(na.exclude(averages$numbersReproduced[averages$codeAvailable=="True"]))
plottingdata$SE[21] <- 
  sd(na.exclude(averages$numbersReproduced[averages$codeAvailable=="True"]))/
  sqrt(na.exclude(length(averages$numbersReproduced[averages$codeAvailable=="True"])))
plottingdata$Category[21] <- "Numbers Reproduced"
plottingdata$Criterion[21] <- "Code available?"
plottingdata$CriterionStatus[21] <- "Yes"

#' No, numbers
plottingdata$Score[22] <- 
  mean(na.exclude(averages$numbersReproduced[averages$codeAvailable=="False"]))
plottingdata$SE[22] <- 
  sd(na.exclude(averages$numbersReproduced[averages$codeAvailable=="False"]))/
  sqrt(na.exclude(length(averages$numbersReproduced[averages$codeAvailable=="False"])))
plottingdata$Category[22] <- "Numbers Reproduced"
plottingdata$Criterion[22] <- "Code available?"
plottingdata$CriterionStatus[22] <- "No"

#' Yes, conclusions
plottingdata$Score[23] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$codeAvailable=="True"]))
plottingdata$SE[23] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$codeAvailable=="True"]))/
  sqrt(na.exclude(length(averages$conclusionsReproduced[averages$codeAvailable=="True"])))
plottingdata$Category[23] <- "Conclusions Reproduced"
plottingdata$Criterion[23] <- "Code available?"
plottingdata$CriterionStatus[23] <- "Yes"

#' No, conclusions
plottingdata$Score[24] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$codeAvailable=="False"]))
plottingdata$SE[24] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$codeAvailable=="False"]))/
  sqrt(na.exclude(length(averages$conclusionsReproduced[averages$codeAvailable=="False"])))
plottingdata$Category[24] <- "Conclusions Reproduced"
plottingdata$Criterion[24] <- "Code available?"
plottingdata$CriterionStatus[24] <- "No"

#' ### Fill in with Open Source Criterion
#' 
#' Yes, graphs
plottingdata$Score[25] <- 
  mean(na.exclude(averages$graphsReproduced[averages$openSource=="True"]))
plottingdata$SE[25] <- 
  sd(na.exclude(averages$graphsReproduced[averages$openSource=="True"]))/
  sqrt(na.exclude(length(averages$graphsReproduced[averages$openSource=="True"])))
plottingdata$Category[25] <- "Graphs Reproduced"
plottingdata$Criterion[25] <- "Open source?"
plottingdata$CriterionStatus[25] <- "Yes"

#' No, graphs
plottingdata$Score[26] <- 
  mean(na.exclude(averages$graphsReproduced[averages$openSource=="False"]))
plottingdata$SE[26] <- 
  sd(na.exclude(averages$graphsReproduced[averages$openSource=="False"]))/
  sqrt(na.exclude(length(averages$graphsReproduced[averages$openSource=="False"])))
plottingdata$Category[26] <- "Graphs Reproduced"
plottingdata$Criterion[26] <- "Open source?"
plottingdata$CriterionStatus[26] <- "No"

#' Yes, numbers
plottingdata$Score[27] <- 
  mean(na.exclude(averages$numbersReproduced[averages$openSource=="True"]))
plottingdata$SE[27] <- 
  sd(na.exclude(averages$numbersReproduced[averages$openSource=="True"]))/
  sqrt(na.exclude(length(averages$numbersReproduced[averages$openSource=="True"])))
plottingdata$Category[27] <- "Numbers Reproduced"
plottingdata$Criterion[27] <- "Open source?"
plottingdata$CriterionStatus[27] <- "Yes"

#' No, numbers
plottingdata$Score[28] <- 
  mean(na.exclude(averages$numbersReproduced[averages$openSource=="False"]))
plottingdata$SE[28] <- 
  sd(na.exclude(averages$numbersReproduced[averages$openSource=="False"]))/
  sqrt(na.exclude(length(averages$numbersReproduced[averages$openSource=="False"])))
plottingdata$Category[28] <- "Numbers Reproduced"
plottingdata$Criterion[28] <- "Open source?"
plottingdata$CriterionStatus[28] <- "No"

#' Yes, conclusions
plottingdata$Score[29] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$openSource=="True"]))
plottingdata$SE[29] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$openSource=="True"]))/
  sqrt(na.exclude(length(averages$conclusionsReproduced[averages$openSource=="True"])))
plottingdata$Category[29] <- "Conclusions Reproduced"
plottingdata$Criterion[29] <- "Open source?"
plottingdata$CriterionStatus[29] <- "Yes"

#' No, conclusions
plottingdata$Score[30] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$openSource=="False"]))
plottingdata$SE[30] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$openSource=="False"]))/
  sqrt(na.exclude(length(averages$conclusionsReproduced[averages$openSource=="False"])))
plottingdata$Category[30] <- "Conclusions Reproduced"
plottingdata$Criterion[30] <- "Open source?"
plottingdata$CriterionStatus[30] <- "No"

#' ### Calculate upper and lower limits for plotting
#' 
plottingdata$upper <- plottingdata$Score + plottingdata$SE
plottingdata$lower <- plottingdata$Score - plottingdata$SE

#' _____________________________________________________________________________
#' ## Create figure
#+ figure3
ggplot(data = plottingdata, 
       aes(x = Criterion, y = Score, colour = CriterionStatus))+
  geom_pointrange(aes(ymin = lower, ymax = upper, shape = CriterionStatus), 
                 position = position_dodge(width = 0.6))+
  facet_wrap(~Category, nrow=3)+
  ylim(1,5)


#' _____________________________________________________________________________
#' ## Footer
#' 
devtools::session_info()
#' spun with:
#' ezknitr::ezspin(file = "programs/04_reproducibility_criteria_figure.R", keep_md = FALSE, out_dir = "html_reports", fig_dir = "figures")
