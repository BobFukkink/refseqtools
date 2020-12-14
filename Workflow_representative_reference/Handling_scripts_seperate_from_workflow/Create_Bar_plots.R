library(ggplot2)

# genus
Rep_ref_filtered_k01_Genus <- c(884,841,836,951,888,811,866,692,963,906)
Rep_ref_filtered_k05_Genus <- c(884,841,836,951,888,811,866,692,963,906)
Rep_ref_filtered_k30_Genus <- c(884,841,836,951,888,811,866,691,963,906)
Pre_built_k01_Genus <- c(912,871,876,971,513,948,397,962,968,936)
Pre_built_k05_Genus <- c(912,871,876,971,513,948,397,962,968,936)
Pre_built_k30_Genus <- c(916,876,876,971,513,948,935,971,976,938)
Pre_built_rerun_k1_Genus <- c(923,855,898,966,515,959,313,960,964,938)
  
#species
Rep_ref_filtered_k01_Species <- c(94,7,790,936,866,214,754,102,895,36)
Rep_ref_filtered_k05_Species <- c(94,7,790,936,866,210,755,102,895,36)
Rep_ref_filtered_k30_Species <- c(94,7,790,936,866,210,755,102,895,36)
Pre_built_k01_Species <- c(333,39,849,954,504,944,375,835,819,3)
Pre_built_k05_Species <- c(333,39,849,954,504,944,375,835,819,3)
Pre_built_k30_Species <- c(333,39,849,954,504,944,875,840,819,3)
Pre_built_rerun_k1_Species <- c(293,27,854,948,506,955,297,824,769,22)


# create dataframe
data <- data.frame(
  name=c("Rep_ref_filtered | k01 | Genus", "Rep_ref_filtered | k05 | Genus", "Rep_ref_filtered | k30 | Genus",
         "Pre_built | k01 | Genus", "Pre_built | k05 | Genus", "Pre_built | k30 | Genus", "Pre_built_rerun | k1 | Genus"),
  value=c(mean(Rep_ref_filtered_k01_Genus),mean(Rep_ref_filtered_k05_Genus),mean(Rep_ref_filtered_k30_Genus),
          mean(Pre_built_k01_Genus),mean(Pre_built_k05_Genus),mean(Pre_built_k30_Genus),mean(Pre_built_rerun_k1_Genus)),
  sd=c(sd(Rep_ref_filtered_k01_Genus),sd(Rep_ref_filtered_k05_Genus),sd(Rep_ref_filtered_k30_Genus),
       sd(Pre_built_k01_Genus),sd(Pre_built_k05_Genus),sd(Pre_built_k30_Genus),sd(Pre_built_rerun_k1_Genus)),
  name2=c("Rep_ref_filtered | k01 | Species", "Rep_ref_filtered | k05 | Species", "Rep_ref_filtered | k30 | Species",
         "Pre_built | k01 | Species", "Pre_built | k05 | Species", "Pre_built | k30 | Species", "Pre_built_rerun | k1 | Species"),
  value2=c(mean(Rep_ref_filtered_k01_Species),mean(Rep_ref_filtered_k05_Species),mean(Rep_ref_filtered_k30_Species),
          mean(Pre_built_k01_Species),mean(Pre_built_k05_Species),mean(Pre_built_k30_Species),mean(Pre_built_rerun_k1_Species)),
  sd2=c(sd(Rep_ref_filtered_k01_Species),sd(Rep_ref_filtered_k05_Species),sd(Rep_ref_filtered_k30_Species),
       sd(Pre_built_k01_Species),sd(Pre_built_k05_Species),sd(Pre_built_k30_Species),sd(Pre_built_rerun_k1_Species))
)

data$name <- factor(data$name, levels = data$name[order(data$name)])
q <- ggplot(data) +
  geom_bar(aes(x=name, y=value), position="dodge", stat="identity", fill="red2", alpha=0.7) +
  geom_text(aes(x=name, y=value, label=value), vjust=0) +
  geom_errorbar( aes(x=name, ymin=value-sd, ymax=value+sd), width=0.4, colour="black", alpha=0.4, size=0.7) +
  geom_bar(aes(x=name2, y=value2), position="dodge", stat="identity", fill="skyblue", alpha=0.9) +
  geom_text(aes(x=name2, y=value2, label=value2), vjust=0) +
  geom_errorbar( aes(x=name2, ymin=value2-sd2, ymax=value2+sd2), width=0.4, colour="black", alpha=0.4, size=0.7) +
  ylim(0,1200) +
  xlab("Database | k-value | taxonomic level")+
  ylab("Classification count")
q + theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))

### Means
#Genus
mean(Rep_ref_filtered_k01_Genus)
mean(Rep_ref_filtered_k05_Genus)
mean(Rep_ref_filtered_k30_Genus)
mean(Pre_built_k01_Genus)
mean(Pre_built_k05_Genus)
mean(Pre_built_k30_Genus)
mean(Pre_built_rerun_k1_Genus)

#Species
mean(Rep_ref_filtered_k01_Species)
mean(Rep_ref_filtered_k05_Species)
mean(Rep_ref_filtered_k30_Species)
mean(Pre_built_k01_Species)
mean(Pre_built_k05_Species)
mean(Pre_built_k30_Species)
mean(Pre_built_rerun_k1_Species)

### Standard deviations
#Genus
sd(Rep_ref_filtered_k01_Genus)
sd(Rep_ref_filtered_k05_Genus)
sd(Rep_ref_filtered_k30_Genus)
sd(Pre_built_k01_Genus)
sd(Pre_built_k05_Genus)
sd(Pre_built_k30_Genus)
sd(Pre_built_rerun_k1_Genus)

#Species
sd(Rep_ref_filtered_k01_Species)
sd(Rep_ref_filtered_k05_Species)
sd(Rep_ref_filtered_k30_Species)
sd(Pre_built_k01_Species)
sd(Pre_built_k05_Species)
sd(Pre_built_k30_Species)
sd(Pre_built_rerun_k1_Species)
