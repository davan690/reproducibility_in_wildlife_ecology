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
colnames(plottingdata) <- c("Score", "SD", "upper", "lower", 
                            "Category", "Question", "Response")

#' ### Fill in with Data Availability Question
#' 
#' Yes, graphs
plottingdata$Score[1] <- 
  mean(na.exclude(averages$graphsReproduced[averages$dataAvailable=="True"]))
plottingdata$SD[1] <- 
  sd(na.exclude(averages$graphsReproduced[averages$dataAvailable=="True"]))
plottingdata$Category[1] <- "Figures reproduced"
plottingdata$Question[1] <- "Q5: Data available?"
plottingdata$Response[1] <- "Yes"

#' No, graphs
plottingdata$Score[2] <- 
  mean(na.exclude(averages$graphsReproduced[averages$dataAvailable=="False"]))
plottingdata$SD[2] <- 
  sd(na.exclude(averages$graphsReproduced[averages$dataAvailable=="False"]))
plottingdata$Category[2] <- "Figures reproduced"
plottingdata$Question[2] <- "Q5: Data available?"
plottingdata$Response[2] <- "No"

#' Yes, numbers
plottingdata$Score[3] <- 
  mean(na.exclude(averages$numbersReproduced[averages$dataAvailable=="True"]))
plottingdata$SD[3] <- 
  sd(na.exclude(averages$numbersReproduced[averages$dataAvailable=="True"]))
plottingdata$Category[3] <- "Numbers reproduced"
plottingdata$Question[3] <- "Q5: Data available?"
plottingdata$Response[3] <- "Yes"

#' No, numbers
plottingdata$Score[4] <- 
  mean(na.exclude(averages$numbersReproduced[averages$dataAvailable=="False"]))
plottingdata$SD[4] <- 
  sd(na.exclude(averages$numbersReproduced[averages$dataAvailable=="False"]))
plottingdata$Category[4] <- "Numbers reproduced"
plottingdata$Question[4] <- "Q5: Data available?"
plottingdata$Response[4] <- "No"

#' Yes, conclusions
plottingdata$Score[5] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$dataAvailable=="True"]))
plottingdata$SD[5] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$dataAvailable=="True"]))
plottingdata$Category[5] <- "Conclusions reproduced"
plottingdata$Question[5] <- "Q5: Data available?"
plottingdata$Response[5] <- "Yes"

#' No, conclusions
plottingdata$Score[6] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$dataAvailable=="False"]))
plottingdata$SD[6] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$dataAvailable=="False"]))
plottingdata$Category[6] <- "Conclusions reproduced"
plottingdata$Question[6] <- "Q5: Data available?"
plottingdata$Response[6] <- "No"

#' ### Fill in with Data Raw Question
#' 
#' Yes, graphs
plottingdata$Score[7] <- 
  mean(na.exclude(averages$graphsReproduced[averages$preProcessed=="Raw format"]))
plottingdata$SD[7] <- 
  sd(na.exclude(averages$graphsReproduced[averages$preProcessed=="Raw format"]))
plottingdata$Category[7] <- "Figures reproduced"
plottingdata$Question[7] <- "Q6: Raw data?"
plottingdata$Response[7] <- "Yes"

#' No, graphs
plottingdata$Score[8] <- 
  mean(na.exclude(averages$graphsReproduced[averages$preProcessed=="Pre-processed"]))
plottingdata$SD[8] <- 
  sd(na.exclude(averages$graphsReproduced[averages$preProcessed=="Pre-processed"]))
plottingdata$Category[8] <- "Figures reproduced"
plottingdata$Question[8] <- "Q6: Raw data?"
plottingdata$Response[8] <- "No"

#' Yes, numbers
plottingdata$Score[9] <- 
  mean(na.exclude(averages$numbersReproduced[averages$preProcessed=="Raw format"]))
plottingdata$SD[9] <- 
  sd(na.exclude(averages$numbersReproduced[averages$preProcessed=="Raw format"]))
plottingdata$Category[9] <- "Numbers reproduced"
plottingdata$Question[9] <- "Q6: Raw data?"
plottingdata$Response[9] <- "Yes"

#' No, numbers
plottingdata$Score[10] <- 
  mean(na.exclude(averages$numbersReproduced[averages$preProcessed=="Pre-processed"]))
plottingdata$SD[10] <- 
  sd(na.exclude(averages$numbersReproduced[averages$preProcessed=="Pre-processed"]))
plottingdata$Category[10] <- "Numbers reproduced"
plottingdata$Question[10] <- "Q6: Raw data?"
plottingdata$Response[10] <- "No"

#' Yes, conclusions
plottingdata$Score[11] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$preProcessed=="Raw format"]))
plottingdata$SD[11] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$preProcessed=="Raw format"]))
plottingdata$Category[11] <- "Conclusions reproduced"
plottingdata$Question[11] <- "Q6: Raw data?"
plottingdata$Response[11] <- "Yes"

#' No, conclusions
plottingdata$Score[12] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$preProcessed=="Pre-processed"]))
plottingdata$SD[12] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$preProcessed=="Pre-processed"]))
plottingdata$Category[12] <- "Conclusions reproduced"
plottingdata$Question[12] <- "Q6: Raw data?"
plottingdata$Response[12] <- "No"

#' ### Fill in with Code Based Question
#' 
#' Yes, graphs
plottingdata$Score[13] <- 
  mean(na.exclude(averages$graphsReproduced[averages$codeBased=="True"]))
plottingdata$SD[13] <- 
  sd(na.exclude(averages$graphsReproduced[averages$codeBased=="True"]))
plottingdata$Category[13] <- "Figures reproduced"
plottingdata$Question[13] <- "Q8: Code based?"
plottingdata$Response[13] <- "Yes"

#' No, graphs
plottingdata$Score[14] <- 
  mean(na.exclude(averages$graphsReproduced[averages$codeBased=="False"]))
plottingdata$SD[14] <- 
  sd(na.exclude(averages$graphsReproduced[averages$codeBased=="False"]))
plottingdata$Category[14] <- "Figures reproduced"
plottingdata$Question[14] <- "Q8: Code based?"
plottingdata$Response[14] <- "No"

#' Yes, numbers
plottingdata$Score[15] <- 
  mean(na.exclude(averages$numbersReproduced[averages$codeBased=="True"]))
plottingdata$SD[15] <- 
  sd(na.exclude(averages$numbersReproduced[averages$codeBased=="True"]))
plottingdata$Category[15] <- "Numbers reproduced"
plottingdata$Question[15] <- "Q8: Code based?"
plottingdata$Response[15] <- "Yes"

#' No, numbers
plottingdata$Score[16] <- 
  mean(na.exclude(averages$numbersReproduced[averages$codeBased=="False"]))
plottingdata$SD[16] <- 
  sd(na.exclude(averages$numbersReproduced[averages$codeBased=="False"]))
plottingdata$Category[16] <- "Numbers reproduced"
plottingdata$Question[16] <- "Q8: Code based?"
plottingdata$Response[16] <- "No"

#' Yes, conclusions
plottingdata$Score[17] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$codeBased=="True"]))
plottingdata$SD[17] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$codeBased=="True"]))
plottingdata$Category[17] <- "Conclusions reproduced"
plottingdata$Question[17] <- "Q8: Code based?"
plottingdata$Response[17] <- "Yes"

#' No, conclusions
plottingdata$Score[18] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$codeBased=="False"]))
plottingdata$SD[18] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$codeBased=="False"]))
plottingdata$Category[18] <- "Conclusions reproduced"
plottingdata$Question[18] <- "Q8: Code based?"
plottingdata$Response[18] <- "No"

#' ### Fill in with Code Available Question
#' 
#' Yes, graphs
plottingdata$Score[19] <- 
  mean(na.exclude(averages$graphsReproduced[averages$codeAvailable=="True"]))
plottingdata$SD[19] <- 
  sd(na.exclude(averages$graphsReproduced[averages$codeAvailable=="True"]))
plottingdata$Category[19] <- "Figures reproduced"
plottingdata$Question[19] <- "Q7: Code available?"
plottingdata$Response[19] <- "Yes"

#' No, graphs
plottingdata$Score[20] <- 
  mean(na.exclude(averages$graphsReproduced[averages$codeAvailable=="False"]))
plottingdata$SD[20] <- 
  sd(na.exclude(averages$graphsReproduced[averages$codeAvailable=="False"]))
plottingdata$Category[20] <- "Figures reproduced"
plottingdata$Question[20] <- "Q7: Code available?"
plottingdata$Response[20] <- "No"

#' Yes, numbers
plottingdata$Score[21] <- 
  mean(na.exclude(averages$numbersReproduced[averages$codeAvailable=="True"]))
plottingdata$SD[21] <- 
  sd(na.exclude(averages$numbersReproduced[averages$codeAvailable=="True"]))
plottingdata$Category[21] <- "Numbers reproduced"
plottingdata$Question[21] <- "Q7: Code available?"
plottingdata$Response[21] <- "Yes"

#' No, numbers
plottingdata$Score[22] <- 
  mean(na.exclude(averages$numbersReproduced[averages$codeAvailable=="False"]))
plottingdata$SD[22] <- 
  sd(na.exclude(averages$numbersReproduced[averages$codeAvailable=="False"]))
plottingdata$Category[22] <- "Numbers reproduced"
plottingdata$Question[22] <- "Q7: Code available?"
plottingdata$Response[22] <- "No"

#' Yes, conclusions
plottingdata$Score[23] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$codeAvailable=="True"]))
plottingdata$SD[23] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$codeAvailable=="True"]))
plottingdata$Category[23] <- "Conclusions reproduced"
plottingdata$Question[23] <- "Q7: Code available?"
plottingdata$Response[23] <- "Yes"

#' No, conclusions
plottingdata$Score[24] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$codeAvailable=="False"]))
plottingdata$SD[24] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$codeAvailable=="False"]))
plottingdata$Category[24] <- "Conclusions reproduced"
plottingdata$Question[24] <- "Q7: Code available?"
plottingdata$Response[24] <- "No"

#' ### Fill in with Open Source Question
#' 
#' Yes, graphs
plottingdata$Score[25] <- 
  mean(na.exclude(averages$graphsReproduced[averages$openSource=="True"]))
plottingdata$SD[25] <- 
  sd(na.exclude(averages$graphsReproduced[averages$openSource=="True"]))
plottingdata$Category[25] <- "Figures reproduced"
plottingdata$Question[25] <- "Q9: Open source?"
plottingdata$Response[25] <- "Yes"

#' No, graphs
plottingdata$Score[26] <- 
  mean(na.exclude(averages$graphsReproduced[averages$openSource=="False"]))
plottingdata$SD[26] <- 
  sd(na.exclude(averages$graphsReproduced[averages$openSource=="False"]))
plottingdata$Category[26] <- "Figures reproduced"
plottingdata$Question[26] <- "Q9: Open source?"
plottingdata$Response[26] <- "No"

#' Yes, numbers
plottingdata$Score[27] <- 
  mean(na.exclude(averages$numbersReproduced[averages$openSource=="True"]))
plottingdata$SD[27] <- 
  sd(na.exclude(averages$numbersReproduced[averages$openSource=="True"]))
plottingdata$Category[27] <- "Numbers reproduced"
plottingdata$Question[27] <- "Q9: Open source?"
plottingdata$Response[27] <- "Yes"

#' No, numbers
plottingdata$Score[28] <- 
  mean(na.exclude(averages$numbersReproduced[averages$openSource=="False"]))
plottingdata$SD[28] <- 
  sd(na.exclude(averages$numbersReproduced[averages$openSource=="False"]))
plottingdata$Category[28] <- "Numbers reproduced"
plottingdata$Question[28] <- "Q9: Open source?"
plottingdata$Response[28] <- "No"

#' Yes, conclusions
plottingdata$Score[29] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$openSource=="True"]))
plottingdata$SD[29] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$openSource=="True"]))
plottingdata$Category[29] <- "Conclusions reproduced"
plottingdata$Question[29] <- "Q9: Open source?"
plottingdata$Response[29] <- "Yes"

#' No, conclusions
plottingdata$Score[30] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$openSource=="False"]))
plottingdata$SD[30] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$openSource=="False"]))
plottingdata$Category[30] <- "Conclusions reproduced"
plottingdata$Question[30] <- "Q9: Open source?"
plottingdata$Response[30] <- "No"

#' ### Calculate upper and lower limits for plotting
#' 
plottingdata$upper <- plottingdata$Score + plottingdata$SD
plottingdata$lower <- plottingdata$Score - plottingdata$SD


#' Compile raw data in long format
#'
tempdata1 <- averages[,c("studyID", "graphsReproduced", 
                         "codeRunsAsIs", "dataAvailable", "preProcessed",
                         "codeBased", "codeAvailable","openSource" )]
tempdata2 <- averages[,c("studyID", "numbersReproduced", 
                         "codeRunsAsIs", "dataAvailable", "preProcessed",
                         "codeBased", "codeAvailable","openSource" )]
tempdata3 <- averages[,c("studyID", "conclusionsReproduced", 
                         "codeRunsAsIs", "dataAvailable", "preProcessed",
                         "codeBased", "codeAvailable","openSource" )]
colnames(tempdata1) <- 
  colnames(tempdata2) <- 
  colnames(tempdata3) <- c("studyID", "Score", 
                           "codeRunsAsIs", "dataAvailable", "preProcessed",
                           "codeBased", "codeAvailable","openSource" )
tempdata1$Category <- "Figures reproduced"
tempdata2$Category <- "Numbers reproduced"
tempdata3$Category <- "Conclusions reproduced"
plottingdata.long <- rbind(tempdata1, tempdata2, tempdata3)

tempdata.a <- plottingdata.long[,c("studyID", "Score", "Category", "codeRunsAsIs")]
tempdata.b <- plottingdata.long[,c("studyID", "Score", "Category", "dataAvailable")]
tempdata.c <- plottingdata.long[,c("studyID", "Score", "Category", "preProcessed")]
tempdata.d <- plottingdata.long[,c("studyID", "Score", "Category", "codeBased")]
tempdata.e <- plottingdata.long[,c("studyID", "Score", "Category", "codeAvailable")]
tempdata.f <- plottingdata.long[,c("studyID", "Score", "Category", "openSource")]

tempdata.b$question <- "Q5: Data available?"
tempdata.c$question <- "Q6: Raw data?"
tempdata.d$question <- "Q8: Code based?"
tempdata.e$question <- "Q7: Code available?"
tempdata.f$question <- "Q9: Open source?"

tempdata.b$response <- ifelse(tempdata.b$dataAvailable=="True", yes = "Yes", no = "No")
tempdata.c$response <- ifelse(tempdata.c$preProcessed=="Raw format", yes = "Yes", no = "No")
tempdata.d$response <- ifelse(tempdata.d$codeBased=="True", yes = "Yes", no = "No")
tempdata.e$response <- ifelse(tempdata.e$codeAvailable=="True", yes = "Yes", no = "No")
tempdata.f$response <- ifelse(tempdata.f$openSource=="True", yes = "Yes", no = "No")

colnames(tempdata.f) <-
  colnames(tempdata.e) <- 
  colnames(tempdata.d) <-
  colnames(tempdata.c) <- 
  colnames(tempdata.b) <- c("studyID", "Score", "Category", "originalResponse", 
                            "Question", "Response")

plottingdata.longComplete <- rbind(tempdata.b, tempdata.c, tempdata.d,
                                   tempdata.e, tempdata.f)

# Remove NAs from response column
plottingdata.longComplete <- plottingdata.longComplete[!is.na(plottingdata.longComplete$Response),]

#' _____________________________________________________________________________
#' ## Create figure
#+ figure3, fig.width=7.4, fig.height=5, dpi=200
ggplot(data = plottingdata.longComplete, 
       aes(x = Question, y = Score, shape = Response, colour=Response))+
  geom_pointrange(data = plottingdata,
                  aes(ymin = lower, ymax = upper, shape = Response), 
                 position = position_dodge(width = 0.6))+
  geom_jitter(position = position_jitterdodge(jitter.width = 0.15,
                                              jitter.height = 0.15,
                                              dodge.width = 0.7), color="black")+
  facet_wrap(~Category, nrow=3)+
  #ylim(1,5)+
  theme_classic()+
  theme(legend.position = "top")+
  ylab("Reproducibility score")


#' _____________________________________________________________________________
#' ## Footer
#' 
devtools::session_info()
#' spun with:
#' ezknitr::ezspin(file = "programs/04_reproducibility_criteria_figure.R", keep_md = FALSE, out_dir = "html_reports", fig_dir = "figures")
