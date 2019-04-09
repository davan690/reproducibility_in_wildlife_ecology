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
colnames(plottingdata) <- c("Score", "SE", "upper", "lower", 
                            "Category", "journal")

#' ### Fill in with reproducibility of figures scores
#' 
#' JWM
plottingdata$Score[1] <- 
  na.exclude(mean(averages$graphsReproduced[averages$journal=="JWM"]))
plottingdata$SE[1] <- 
  sd(na.exclude(averages$graphsReproduced[averages$journal=="JWM"]))/
  sqrt(na.exclude(length(averages$graphsReproduced[averages$journal=="JWM"])))
plottingdata$Category[1] <- "Figures"
plottingdata$journal[1] <- "JWM"

#' WSB
plottingdata$Score[2] <- 
  mean(na.exclude(averages$graphsReproduced[averages$journal=="WSB"]))
plottingdata$SE[2] <- 
  sd(na.exclude(averages$graphsReproduced[averages$journal=="WSB"]))/
  sqrt(na.exclude(length(averages$graphsReproduced[averages$journal=="WSB"])))
plottingdata$Category[2] <- "Figures"
plottingdata$journal[2] <- "WSB"

#' Overall
plottingdata$Score[3] <- mean(na.exclude(averages$graphsReproduced))
plottingdata$SE[3] <- sd(na.exclude(averages$graphsReproduced))/
  sqrt(na.exclude(length(averages$graphsReproduced)))
plottingdata$Category[3] <- "Figures"
plottingdata$journal[3] <- "Overall"


#' ### Fill in with reproducibility of numbers scores
#' 
#' JWM
plottingdata$Score[4] <- 
  mean(na.exclude(averages$numbersReproduced[averages$journal=="JWM"]))
plottingdata$SE[4] <- 
  sd(na.exclude(averages$numbersReproduced[averages$journal=="JWM"]))/
  sqrt(na.exclude(length(averages$numbersReproduced[averages$journal=="JWM"])))
plottingdata$Category[4] <- "Numbers"
plottingdata$journal[4] <- "JWM"

#' WSB
plottingdata$Score[5] <- 
  mean(na.exclude(averages$numbersReproduced[averages$journal=="WSB"]))
plottingdata$SE[5] <- 
  sd(na.exclude(averages$numbersReproduced[averages$journal=="WSB"]))/
  sqrt(na.exclude(length(averages$numbersReproduced[averages$journal=="WSB"])))
plottingdata$Category[5] <- "Numbers"
plottingdata$journal[5] <- "WSB"

#' Overall
plottingdata$Score[6] <- mean(na.exclude(averages$numbersReproduced))
plottingdata$SE[6] <- sd(na.exclude(averages$numbersReproduced))/
  sqrt(na.exclude(length(averages$numbersReproduced)))
plottingdata$Category[6] <- "Numbers"
plottingdata$journal[6] <- "Overall"


#' ### Fill in with reproducibility of conclusions scores
#' 
#' JWM
plottingdata$Score[7] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$journal=="JWM"]))
plottingdata$SE[7] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$journal=="JWM"]))/
  sqrt(na.exclude(length(averages$conclusionsReproduced[averages$journal=="JWM"])))
plottingdata$Category[7] <- "Conclusions"
plottingdata$journal[7] <- "JWM"

#' WSB
plottingdata$Score[8] <- 
  mean(na.exclude(averages$conclusionsReproduced[averages$journal=="WSB"]))
plottingdata$SE[8] <- 
  sd(na.exclude(averages$conclusionsReproduced[averages$journal=="WSB"]))/
  sqrt(na.exclude(length(averages$conclusionsReproduced[averages$journal=="WSB"])))
plottingdata$Category[8] <- "Conclusions"
plottingdata$journal[8] <- "WSB"

#' Overall
plottingdata$Score[9] <- mean(na.exclude(averages$conclusionsReproduced))
plottingdata$SE[9] <- sd(na.exclude(averages$conclusionsReproduced))/
  sqrt(na.exclude(length(averages$conclusionsReproduced)))
plottingdata$Category[9] <- "Conclusions"
plottingdata$journal[9] <- "Overall"

#' ### Calculate lower and upper limits for all categories
plottingdata$upper <- plottingdata$Score + plottingdata$SE
plottingdata$lower <- plottingdata$Score - plottingdata$SE

#' _____________________________________________________________________________
#' ## Create figure
#+ figure2, fig.width=3.46, fig.height=3, dpi=200
ggplot(data = plottingdata, aes(x = Category, y = Score, colour = journal))+
  geom_pointrange(aes(ymin = lower, ymax = upper, shape = journal), 
                 position = position_dodge(width = 0.6))+
  ylim(1,5)+
  theme_classic()+
  theme(legend.position = "top", legend.title = element_blank())+
  xlab("Reproducibility criterion")+
  ylab("Reproducibility score")


testdata1 <- averages[,c("studyID", "graphsReproduced", "journal")]
testdata2 <- averages[,c("studyID", "numbersReproduced", "journal")]
testdata3 <- averages[,c("studyID", "conclusionsReproduced", "journal")]
colnames(testdata1) <- 
  colnames(testdata2) <- 
  colnames(testdata3) <- c("studyID", "Score", "journal")
testdata1$Category <- "Figures"
testdata2$Category <- "Numbers"
testdata3$Category <- "Conclusions"
plottingdata.long <- rbind(testdata1, testdata2, testdata3)

ggplot(data = plottingdata.long, aes(x = Category, y = Score, colour = journal, shape = journal))+
  geom_jitter(position = position_dodge(width = 0.7))+
  geom_pointrange(data = plottingdata,
                  aes(ymin = lower, ymax = upper, shape = journal), 
                  position = position_dodge(width = 0.6))+
  ylim(1,5)+
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
