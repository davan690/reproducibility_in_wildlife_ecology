#' # Figure 2
#' 
#' Description: Scores by journal
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
plottingdata <- as.data.frame(matrix(NA, nrow = 9, ncol = 6))
colnames(plottingdata) <- c("Score", "SD", "upper", "lower", 
                            "Category", "journal")

#' ### Fill in with reproducibility of figures scores
#' 
#' JWM
plottingdata$Score[1] <- 
  na.exclude(mean(averages$graphsReproduced[averages$journal=="JWM"]))
plottingdata$SD[1] <- 
  sd(na.exclude(averages$graphsReproduced[averages$journal=="JWM"]))
plottingdata$Category[1] <- "Figures"
plottingdata$journal[1] <- "JWM"

#' WSB
plottingdata$Score[2] <- 
  mean(na.exclude(averages$graphsReproduced[averages$journal=="WSB"]))
plottingdata$SD[2] <- 
  sd(na.exclude(averages$graphsReproduced[averages$journal=="WSB"]))
plottingdata$Category[2] <- "Figures"
plottingdata$journal[2] <- "WSB"

#' Overall
plottingdata$Score[3] <- mean(na.exclude(averages$graphsReproduced))
plottingdata$SD[3] <- sd(na.exclude(averages$graphsReproduced))
plottingdata$Category[3] <- "Figures"
plottingdata$journal[3] <- "Overall"


#' ### Fill in with reproducibility of numbers scores
#' 
#' JWM
plottingdata$Score[4] <- 
  mean(na.exclude(averages$numbersReproduced[averages$journal=="JWM"]))
plottingdata$SD[4] <- 
  sd(na.exclude(averages$numbersReproduced[averages$journal=="JWM"]))
plottingdata$Category[4] <- "Numbers"
plottingdata$journal[4] <- "JWM"

#' WSB
plottingdata$Score[5] <- 
  mean(na.exclude(averages$numbersReproduced[averages$journal=="WSB"]))
plottingdata$SD[5] <- 
  sd(na.exclude(averages$numbersReproduced[averages$journal=="WSB"]))
plottingdata$Category[5] <- "Numbers"
plottingdata$journal[5] <- "WSB"

#' Overall
plottingdata$Score[6] <- mean(na.exclude(averages$numbersReproduced))
plottingdata$SD[6] <- sd(na.exclude(averages$numbersReproduced))
plottingdata$Category[6] <- "Numbers"
plottingdata$journal[6] <- "Overall"


#' ### Fill in with reproducibility of conclusions scores
#' 
#' JWM
plottingdata$Score[7] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$journal=="JWM"]))
plottingdata$SD[7] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$journal=="JWM"]))
plottingdata$Category[7] <- "Conclusions"
plottingdata$journal[7] <- "JWM"

#' WSB
plottingdata$Score[8] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$journal=="WSB"]))
plottingdata$SD[8] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$journal=="WSB"]))
plottingdata$Category[8] <- "Conclusions"
plottingdata$journal[8] <- "WSB"

#' Overall
plottingdata$Score[9] <- mean(na.exclude(averages$conclusionsReproduced))
plottingdata$SD[9] <- sd(na.exclude(averages$conclusionsReproduced))
plottingdata$Category[9] <- "Conclusions"
plottingdata$journal[9] <- "Overall"

#' ### Calculate lower and upper limits for all categories
plottingdata$upper <- plottingdata$Score + plottingdata$SD
plottingdata$lower <- plottingdata$Score - plottingdata$SD

#' Compile raw data in long format
#'
tempdata1 <- averages[,c("studyID", "graphsReproduced", "journal")]
tempdata2 <- averages[,c("studyID", "numbersReproduced", "journal")]
tempdata3 <- averages[,c("studyID", "conclusionsReproduced", "journal")]
colnames(tempdata1) <- 
  colnames(tempdata2) <- 
  colnames(tempdata3) <- c("studyID", "Score", "journal")
tempdata1$Category <- "Figures"
tempdata2$Category <- "Numbers"
tempdata3$Category <- "Conclusions"
plottingdata.long <- rbind(tempdata1, tempdata2, tempdata3)

#' _____________________________________________________________________________
#' ## Create figure
#' 
#' 
#+ figure2, fig.width=3.46, fig.height=3, dpi=200
ggplot(data = plottingdata.long, aes(x = Category, y = Score, 
                                     colour = journal, shape = journal))+
  geom_pointrange(data = plottingdata,
                  aes(ymin = lower, ymax = upper, shape = journal), 
                  position = position_dodge(width = 0.6))+
  geom_jitter(position = position_jitterdodge(jitter.width = 0.15, 
                                              jitter.height = 0.15, 
                                              dodge.width = 0.7), 
              color = "black")+
  #ylim(1,5)+
  theme_classic()+
  theme(legend.position = "top", legend.title = element_blank())+
  xlab("Reproducibility criterion")+
  ylab("Reproducibility score")

#' _____________________________________________________________________________
#' ## Footer
#' 
devtools::session_info()
#' spun with:
#' ezknitr::ezspin(file = "programs/03_scores_by_journal_figure.R", keep_md = FALSE, out_dir = "html_reports", fig_dir = "figures")
