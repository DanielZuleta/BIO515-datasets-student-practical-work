## Zingg_2023_R_Script_Imputation_Analyse_Figures.R ##
## Date: 21.04.2023 ##
## Author: Silvia Zingg (silvia.zingg@bfh.ch) ##
## Published on DRYAD ##

############## Libraries and Packages ###########################

library(data.table)
library(ggplot2)
library(mice)         # Imputation
library(lattice)      # Needed for multi-panel graphs
library(plyr) 
library(reshape)      # Boxplot with imputed yield values
library(reshape2)

############# Functions #########################################

## Function give.n ##
## to display the sample size in the boxplot ##
give.n <- function(x){
  return(c(y = mean(x), label = length(x)))
} # positioned at mean values

give.n2 <- function(x){
  return(c(y = (max(x)+100), label = length(x)))
} # positioned above max values

# Multiple plot function for ggplot2
# http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/

multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

############################### Import Raw Data from farmers and admin  ###########

# Import data frame from DRYAD "Zingg_2023_RawData.csv"
dat <-read.csv ()
dat$KoordID <-as.factor(dat$KoordID)  # Landscape ID (n = 49 landscapes)
dat$Year <- as.factor(dat$Year)       # 2012 - 2016
dat$Kanton <- as.factor(dat$Kanton)   # Swiss Region
dat$Crop <- as.factor(dat$Crop)       # Crop type
dat$Crop_Category <- as.factor(dat$Crop_Category) # Crop category
dat$Label <- as.factor(dat$Label)     # Management
dat$Source <- as.factor (dat$Source)  # Data Source

# Set the column order
# This step is important as it pre defines the visiting sequence for the imputation afterwards
library(data.table)
setcolorder(dat, c("KoordID", "Kanton", "Altitude", "Year", "Crop", "Crop_Category", "Label", "Use", "Yield_dt_ha", "Area_ha", "Source"))

############### FARMER DATA ######################################################
Farmer <- dat[dat$Source == "Farmer",] 
str(Farmer)

# Figure S3.2 Raw data from farmers (Supp. Mat.) 
variable <- Farmer$Crop_Category
value <- Farmer$Yield_dt_ha

ggplot(Farmer, aes(x=reorder (variable,value), y= value)) +
  stat_boxplot(geom ='errorbar') + 
  geom_boxplot() +
  # ylim(0,10) +
  stat_summary(fun.data = give.n2, geom = "text") + 
  ylab("Yield biomass [dt/ha]") + 
  xlab("") +
  theme(axis.text.x  = element_text(angle=90), 
        axis.text= element_text(size=16),axis.title= element_text(size=16))

# The Farmer data frame
# contains information from farmer interviews on crop area, type, management, yield and use, over three years.
# Use (only given for grasslands) quantifies the number of cuts or grazing events.
# The 41 different crop types were divided into 12 crop categories for the imputation and analysis.

############### ADMIN DATA ######################################################

Admin <- dat[dat$Source == "Admin",] 
str(Admin)

# Sum up area of agricultural fields
library(plyr)
Sum_Area <- ddply(Admin,.(KoordID),summarise , Sum_Area_ha = sum(Area_ha))
Sum_Area

# The Admin data frame
# contains the information on the crop area per landscape from one given year based on the cantonal agricultural survey/or crop mapping.
# All agricultural fields intersecting the landscape squares were included. The total area (sum per landscape) can therefore exceed 100 ha.

############### START MULTIPLE IMPUTATION TO COMPLETE DATA FRAME #################

# We used mice predictive mean matching to complete the rawdata ("dat") data frame
# for more information see https://www.r-bloggers.com/imputing-missing-data-with-r-mice-package/

#### GRASSLAND AND ARABLE IMPUTATION SEPARATE ####

## Arable
arable <- subset(dat, !(Crop_Category %in% c("Int_grassland", "Ext_grassland")))
str(arable) # n = 2934

## Grassland
grass <- subset(dat, Crop_Category %in% c("Int_grassland", "Ext_grassland"))
str(grass)

############### START IMPUTATION #################################################
library(mice)
library(MASS)
library(ggplot2)

## Arable ##
## Check the imputation models and the predictor matrix and visiting sequence (from left to right)
imp3 <- mice(arable, m=5,maxit=0,seed=500) 
summary(imp3)

# Define Predictors
pred <- imp3$predictorMatrix
pred[, "Area_ha"] <- c(0,0,0,0,0,0,0,0,0,0,0) # Area is not used as Predictor
pred[, "Source"] <- c(0,0,0,0,0,0,0,0,0,0,0) # Source is not used as Predictor
pred[, "Use"] <- c(0,0,0,0,0,0,0,0,0,0,0) # Use is not used as Predictor

# Define the imputation Model
meth <- imp3$meth
# Set Use to be not imputed
meth["Use"] <- ""

## Generate imputation with new predictors
imp3 <- mice(arable, pred = pred, meth = meth, m=50, maxit=10)
summary(imp3)
## Visualize Convergence
plot(imp3, convergent = TRUE)

## Grassland ##
## Check the imputation models and the predictor Matrix and Visiting Sequence
imp4 <- mice(grass, m=5, maxit=0, seed=500) 
summary(imp4)

# Define Predictors
pred <- imp4$predictorMatrix
pred[, "Area_ha"] <- c(0,0,0,0,0,0,0,0,0,0,0) # Area is not used as Predictor
pred[, "Source"] <- c(0,0,0,0,0,0,0,0,0,0,0) # Source is not used as Predictor

## Generate imputation with new predictor and visiting sequence
imp4 <- mice(grass, pred = pred, m=50, maxit=10)
summary(imp4)

## Visualize Convergence
plot(imp4, convergent = TRUE)

################################# MERGE ARABLE AND GRASSLAND IMPUTATION #####################

## Get completed data set
com3 <- complete(imp3, "long") # arable 
com4 <- complete(imp4, "long") # grassland
summary(com3); str(com3);sum(is.na(com3$Yield_dt_ha))
summary(com4); str(com4);sum(is.na(com4$Yield_dt_ha))
## Join dataframes
comp <- rbind(com3,com4)

# Get summary statistics after imputation
stat_comp <- tapply(comp$Yield_dt_ha, comp$Crop_Category, summary); stat_comp

## Conclusion: the completed data set contains too many, unrealistic outliers, therefore the yield values were post-processed (see below).

################################# POST PROCESSING OF IMPUTED VALUES #########################

# Show summary statistic from farmer data
stat <- tapply(Farmer$Yield_dt_ha, Farmer$Crop_Category, summary) 

# Set the Maximum Yield value to the 3rd quantile from the farmer data
comp$Yield_dt_ha[comp$Crop_Category =="Cereals" & comp$Yield_dt_ha > (stat$Cereals[c(5:5)])] <- (stat$Cereals[c(5:5)])
comp$Yield_dt_ha[comp$Crop_Category =="Ext_grassland" & comp$Yield_dt_ha > (stat$Ext_grassland[c(5:5)])] <- (stat$Ext_grassland[c(5:5)])
comp$Yield_dt_ha[comp$Crop_Category =="Fruits_Berries" & comp$Yield_dt_ha > (stat$Fruits_Berries[c(5:5)])] <- (stat$Fruits_Berries[c(5:5)])
comp$Yield_dt_ha[comp$Crop_Category =="Grain_maize" & comp$Yield_dt_ha > (stat$Grain_maize[c(5:5)])] <- (stat$Grain_maize[c(5:5)])
comp$Yield_dt_ha[comp$Crop_Category =="Int_grassland" & comp$Yield_dt_ha > (stat$Int_grassland[c(5:5)])] <- (stat$Int_grassland[c(5:5)])
comp$Yield_dt_ha[comp$Crop_Category =="Leguminous_crops" & comp$Yield_dt_ha > (stat$Leguminous_crops[c(5:5)])] <- (stat$Leguminous_crops[c(5:5)])
comp$Yield_dt_ha[comp$Crop_Category =="Non_edible" & comp$Yield_dt_ha > (stat$Non_edible[c(5:5)])] <- (stat$Non_edible[c(5:5)])
comp$Yield_dt_ha[comp$Crop_Category =="Oilseed_crops" & comp$Yield_dt_ha > (stat$Oilseed_crops[c(5:5)])] <- (stat$Oilseed_crops[c(5:5)])
comp$Yield_dt_ha[comp$Crop_Category =="Potato" & comp$Yield_dt_ha > (stat$Potato[c(5:5)])] <- (stat$Potato[c(5:5)])
comp$Yield_dt_ha[comp$Crop_Category =="Silage_maize" & comp$Yield_dt_ha > (stat$Silage_maize[c(5:5)])] <- (stat$Silage_maize[c(5:5)])
comp$Yield_dt_ha[comp$Crop_Category =="Sugar_beet" & comp$Yield_dt_ha > (stat$Sugar_beet[c(5:5)])] <- (stat$Sugar_beet[c(5:5)])
comp$Yield_dt_ha[comp$Crop_Category =="Vegetables" & comp$Yield_dt_ha > (stat$Vegetables[c(5:5)])] <- (stat$Vegetables[c(5:5)])

# Set the minimum yield value to the 1st quantile from the farmer data
comp$Yield_dt_ha[comp$Crop_Category =="Cereals" & comp$Yield_dt_ha < (stat$Cereals[c(2:2)])] <- (stat$Cereals[c(2:2)])
comp$Yield_dt_ha[comp$Crop_Category =="Ext_grassland" & comp$Yield_dt_ha < (stat$Ext_grassland[c(2:2)])] <- (stat$Ext_grassland[c(2:2)])
comp$Yield_dt_ha[comp$Crop_Category =="Fruits_Berries" & comp$Yield_dt_ha < (stat$Fruits_Berries[c(2:2)])] <- (stat$Fruits_Berries[c(2:2)])
comp$Yield_dt_ha[comp$Crop_Category =="Grain_maize" & comp$Yield_dt_ha < (stat$Grain_maize[c(2:2)])] <- (stat$Grain_maize[c(2:2)])
comp$Yield_dt_ha[comp$Crop_Category =="Int_grassland" & comp$Yield_dt_ha < (stat$Int_grassland[c(2:2)])] <- (stat$Int_grassland[c(2:2)])
comp$Yield_dt_ha[comp$Crop_Category =="Leguminous_crops" & comp$Yield_dt_ha < (stat$Leguminous_crops[c(2:2)])] <- (stat$Leguminous_crops[c(2:2)])
comp$Yield_dt_ha[comp$Crop_Category =="Non_edible" & comp$Yield_dt_ha < (stat$Non_edible[c(2:2)])] <- (stat$Non_edible[c(2:2)])
comp$Yield_dt_ha[comp$Crop_Category =="Oilseed_crops" & comp$Yield_dt_ha < (stat$Oilseed_crops[c(2:2)])] <- (stat$Oilseed_crops[c(2:2)])
comp$Yield_dt_ha[comp$Crop_Category =="Potato" & comp$Yield_dt_ha < (stat$Potato[c(2:2)])] <- (stat$Potato[c(2:2)])
comp$Yield_dt_ha[comp$Crop_Category =="Silage_maize" & comp$Yield_dt_ha < (stat$Silage_maize[c(2:2)])] <- (stat$Silage_maize[c(2:2)])
comp$Yield_dt_ha[comp$Crop_Category =="Sugar_beet" & comp$Yield_dt_ha < (stat$Sugar_beet[c(2:2)])] <- (stat$Sugar_beet[c(2:2)])
comp$Yield_dt_ha[comp$Crop_Category =="Vegetables" & comp$Yield_dt_ha < (stat$Vegetables[c(2:2)])] <- (stat$Vegetables[c(2:2)])

################################# DOUBLE VEGETABLE YIELD ######################################

## To account for two main crops per season
comp$Yield_dt_ha[comp$Crop_Category == "Vegetables"] <- comp$Yield_dt_ha[comp$Crop_Category == "Vegetables"]* 2

################################# SET NON EDIBLE TO ZERO #####################################

## Set yield of non-edible (except Tobacco) to zero
comp$Yield_dt_ha[comp$Crop_Category == "Non_edible" & comp$Crop != "Tobacco" ] <- 0

################################ STOP POST PROCESSING ########################################

#### SCRIPT CAN BE RUN FROM HERE IF THE COMPLETED POST PROCESSED DATA FRAME IS IMPORTED ######

## Import the data frame from DRYAD "Zingg_2023_Completed_data_post_processed"
comp <- read.csv()

## TABLE S3.1 Summary statistics of post processed completed data
stat_comp_post <- ddply(comp,.(Crop_Category),summarise , Mean_Yield_dt_ha = mean(Yield_dt_ha),
                        SD_Yield_dt_ha = sd(Yield_dt_ha), Max_Yield_dt_ha = max(Yield_dt_ha), Min_Yield_dt_ha = min(Yield_dt_ha))

## FIGURE S3.2 Post processed imputed yield values
## Plot 
variable <- comp$Crop_Category
value <- comp$Yield_dt_ha
ggplot(comp, aes(x=reorder (variable, value), y= value)) +
  stat_boxplot(geom ='errorbar') + 
  geom_boxplot() +
  # ylim(0,10) +
  stat_summary(fun.data = give.n2, geom = "text") + 
  ylab("Yield biomass [dt/ha]") + 
  xlab("") +
  theme(axis.text.x  = element_text(angle=90), 
        axis.text= element_text(size=16),axis.title= element_text(size=16))

############################## CALCULATE MEAN CROP YIELD PER LANDSCAPE ###############

## Mean Yield per Crop Category, per landscape, per Imputation: Completed data set
Mean_yield <- ddply(comp,.(.imp, KoordID, Crop_Category),summarise , Mean_Yield_dt_ha = mean(Yield_dt_ha))
str(Mean_yield)

############################## SCALE TO LANDSCAPE LEVEL ##############################

## Import the data frame from DRYAD "Zingg_2023_Scaled_crop_area.csv"
Admin_area <- read.csv()
## The "Scaled_area_ha" refers to the area per crop lying within the selected 1km2 squares.

# Merge Mean yield from the completed data set with the scaled crop area
merge <- merge(Admin_area, Mean_yield, by =c("KoordID", "Crop_Category"), all=FALSE)
# Multiply Mean Yield and Scaled area per crop
merge$Yield_dt <- NA
merge$Yield_dt <- (merge$Scaled_Area_ha * merge$Mean_Yield_dt_ha)

##################### CONVERSION FROM YIELD TO FOOD ENERGY ######################################

##################### SCENARIO 1: SEE SUPP. MAT. TABLE S4.1 #####################################
## Add new column 
merge$Scenario_1_ME_GJ_t <- NA
## Add crop nutritional value for every crop from Table S.4.1
merge$Scenario_1_ME_GJ_t[merge$Crop_Category == "Cereals"] <- 10.69
merge$Scenario_1_ME_GJ_t[merge$Crop_Category == "Fruits_Berries"] <- 1.74
merge$Scenario_1_ME_GJ_t[merge$Crop_Category == "Oilseed_crops"] <- 12.63
merge$Scenario_1_ME_GJ_t[merge$Crop_Category == "Potato"] <- 2.88
merge$Scenario_1_ME_GJ_t[merge$Crop_Category == "Sugar_beet"] <- 3.11
merge$Scenario_1_ME_GJ_t[merge$Crop_Category == "Vegetables"] <- 1.42
merge$Scenario_1_ME_GJ_t[merge$Crop_Category == "Grain_maize"] <- 3.08
merge$Scenario_1_ME_GJ_t[merge$Crop_Category == "Silage_maize"] <- 0.43
merge$Scenario_1_ME_GJ_t[merge$Crop_Category == "Leguminous_crops"] <- 1.16
merge$Scenario_1_ME_GJ_t[merge$Crop_Category == "Ext_grassland"] <- 0.24
merge$Scenario_1_ME_GJ_t[merge$Crop_Category == "Int_grassland"] <- 0.39
merge$Scenario_1_ME_GJ_t[merge$Crop_Category == "Non_edible"] <- 0
## Multiply yield with food energy content per crop
merge$Scenario_1_Total_ME_GJ <- NA
merge$Scenario_1_Total_ME_GJ <- ((merge$Yield_dt/10) * (merge$Scenario_1_ME_GJ_t)) # divided by 10 to convert in tonnes (t)

## Sum up to landscape level ##
Scenario_1 <- ddply(merge,.(KoordID, .imp),summarise , Scenario_1_Total_ME_GJ = sum(Scenario_1_Total_ME_GJ))
Scenario_1$KoordID <-as.factor(Scenario_1$KoordID)

###################### SCENARIO 2 : SEE SUPP. MAT. TABLE S4.1 ###################################
merge$Scenario_2_ME_GJ_t <- NA

## Add crop nutritional value for every crop from Table S.4.1
merge$Scenario_2_ME_GJ_t[merge$Crop_Category == "Cereals"] <- 6.42            
merge$Scenario_2_ME_GJ_t[merge$Crop_Category == "Fruits_Berries"] <- 1.74     
merge$Scenario_2_ME_GJ_t[merge$Crop_Category == "Oilseed_crops"] <- 12.63     
merge$Scenario_2_ME_GJ_t[merge$Crop_Category == "Potato"] <- 2.88             
merge$Scenario_2_ME_GJ_t[merge$Crop_Category == "Sugar_beet"] <- 3.11         
merge$Scenario_2_ME_GJ_t[merge$Crop_Category == "Vegetables"] <- 1.42         
merge$Scenario_2_ME_GJ_t[merge$Crop_Category == "Grain_maize"] <- 0.54        
merge$Scenario_2_ME_GJ_t[merge$Crop_Category == "Silage_maize"] <- 0.43       
merge$Scenario_2_ME_GJ_t[merge$Crop_Category == "Leguminous_crops"] <- 0.50   
merge$Scenario_2_ME_GJ_t[merge$Crop_Category == "Ext_grassland"] <- 0.24      
merge$Scenario_2_ME_GJ_t[merge$Crop_Category == "Int_grassland"] <- 0.39      
merge$Scenario_2_ME_GJ_t[merge$Crop_Category == "Non_edible"] <- 0
## Multiply yield with food energy content per crop
merge$Scenario_2_Total_ME_GJ <- NA
merge$Scenario_2_Total_ME_GJ <- ((merge$Yield_dt/10) * (merge$Scenario_2_ME_GJ_t)) # divided by 10 to convert in tonnes (t)

## Sum up to landscape level ##
Scenario_2 <- ddply(merge,.(KoordID, .imp),summarise , Scenario_2_Total_ME_GJ = sum(Scenario_2_Total_ME_GJ))
Scenario_2$KoordID <-as.factor(Scenario_2$KoordID)

## Merge dataframes
data <- merge(Scenario_1, Scenario_2, by =c("KoordID", ".imp"), all=TRUE)

## CALCULATE MEAN ENERGY PER LANDSCAPE (used for figure 3 later on)
Mean_Energy <- ddply(data,.(KoordID),summarise , Mean_Scenario_1 = mean(Scenario_1_Total_ME_GJ),Mean_Scenario_2 = mean(Scenario_2_Total_ME_GJ), UAA = mean(UAA))

##################### START MODELLING #############################

library(mitools)
library(miceadds)
library(MuMIn)  # model.sel function
library(MASS)   # glm.nb function

## Import from DRYAD "Zingg_2023_Data_for_modelling.csv"
data_modelling <- read.csv()

# Create a list of data frames based on the imputed data sets
data_list <- split(data_modelling, f = data_modelling$.imp)
# Prepare implist using "imputationList" from "mitools"
implist <- imputationList(data_list)

# Comments on the modelling
# For Species Richness we used Poisson, for Abundance Negative Binomial (due to over dispersion) and for Evenness a Gaussian distribution.
# We always fitted the interaction term if not significant, we replaced it with the additive model, using the n = 50 imputed data sets.
# Model validation was done using the first imputation only (not shown here)
# UAA = Utilized agricultural area (= farmland ha)

################# TABLE S6.1 : SUMMARY OF MODEL RESULTS FOR SCENARIO 1 ################

# Total bird species richness
fit <- with(implist, glm(Bird_Sp_All ~ Scenario_1_Total_ME_GJ * UAA, family= "poisson"))
# Farmland bird species richness
fit <- with(implist, glm(Bird_Sp_K ~ Scenario_1_Total_ME_GJ + UAA, family= "poisson"))
# Total bird abundance
fit <- with(implist, glm.nb(Bird_Abun_All ~ Scenario_1_Total_ME_GJ * UAA))
# Farmland bird abundance
fit <- with(implist, glm.nb(Bird_Abun_K ~ Scenario_1_Total_ME_GJ + UAA))
# Bird Evenness 
fit <- with(implist, glm(Even_bird ~ Scenario_1_Total_ME_GJ + UAA, family= "gaussian"))
# Total butterfly species richness
fit <- with(implist, glm(Butt_Sp_All ~ Scenario_1_Total_ME_GJ + UAA, family= "poisson"))
# Total butterfly abundance
fit <- with(implist, glm.nb(Butt_Abun_All ~ Scenario_1_Total_ME_GJ + UAA))
# Butterfly Evenness
fit <- with(implist, glm(Even_butt ~ Scenario_1_Total_ME_GJ + UAA, family= "gaussian"))

# Show results
mitools.fit <- MIcombine(fit)
mitools.res <- summary(mitools.fit)

#######################################################################################

################# TABLE 1: SUMMARY OF MODEL RESULTS FOR SCENARIO 2 ####################

# Total bird species richness
fit <- with(implist, glm(Bird_Sp_All ~ Scenario_2_Total_ME_GJ * UAA, family= "poisson"))
# Farmland bird species richness
fit <- with(implist, glm(Bird_Sp_K ~ Scenario_2_Total_ME_GJ + UAA, family= "poisson"))
# Total bird abundance
fit <- with(implist, glm.nb(Bird_Abun_All ~ Scenario_2_Total_ME_GJ * UAA))
# Farmland bird abundance
fit <- with(implist, glm.nb(Bird_Abun_K ~ Scenario_2_Total_ME_GJ + UAA))
# Bird Evenness 
fit <- with(implist, glm(Even_bird ~ Scenario_2_Total_ME_GJ * UAA, family= "gaussian"))
# Total butterfly species richness
fit <- with(implist, glm(Butt_Sp_All ~ Scenario_2_Total_ME_GJ + UAA, family= "poisson"))
# Total butterfly abundance
fit <- with(implist, glm.nb(Butt_Abun_All ~ Scenario_2_Total_ME_GJ + UAA))
# Butterfly Evenness
fit <- with(implist, glm(Even_butt ~ Scenario_2_Total_ME_GJ + UAA, family= "gaussian"))

# Show results
mitools.fit <- MIcombine(fit)
mitools.res <- summary(mitools.fit)

#################### STOP MODELLING ##################################################

#################### FIGURE 3 ########################################################

## Fit Model Bird Species Richness Scenario 2
fit <- with(implist, glm(Bird_Sp_All ~ Scenario_2_Total_ME_GJ * UAA, family= "poisson"))
mitools.fit <- MIcombine(fit) # pool all fitted models
mitools.res <- summary(mitools.fit)
mitools.res <- cbind(mitools.res, df = mitools.fit$df)
mitools.res

# Extract coefficients
# From: https://www.rdocumentation.org/packages/miceadds/versions/2.10-14/topics/pool_mi
cmod <- mitools::MIextract( fit , fun = coef)
# Extract Variance - Covariance Matrix for every model
vmod <- mitools::MIextract( fit , fun = vcov) # Output is a list of 50 variance - covariance matrices
# Pool the Variance - covariance matrices
res1 <- miceadds::pool_mi( qhat=cmod , u = vmod )
summary(res1)
coef(res1) # Pooled coef
vcov(res1) # Pooled Vcov

## Code from Chris to get CI
my.beta <- coef(res1)  ## Pooled coef
my.V <- vcov(res1)  ## Pooled Vcov
## calculate ci given (x.1, x.2) values 
my.cix <- function(Scenario_2_Total_ME_GJ, UAA, beta, V, alpha = 0.05){
  psi <- matrix(c(1, Scenario_2_Total_ME_GJ, UAA, Scenario_2_Total_ME_GJ*UAA), nrow = 1)
  se.psi <- sqrt(psi %*% V %*% t(psi))
  c(fit = exp(psi %*% beta),
    lwr = exp(psi %*% beta - qnorm(1-alpha/2)*se.psi),
    upr = exp(psi %*% beta + qnorm(1-alpha/2)*se.psi)) } 
## choose values (x.1, x.2) for ci calculation

## Define prediction range 
min = min(data_modelling$Scenario_2_Total_ME_GJ)
max = max(data_modelling$Scenario_2_Total_ME_GJ)
Scenario_2_Total_ME_GJ <- seq (min, max, by = (max-min)/100)

##### UAA = 60 ha ######
UAA <- 60
## put it all in a matrix
CI <- matrix(NA, length(Scenario_2_Total_ME_GJ)*length(UAA), 5)
dimnames(CI) <- list(c(NULL), c("Scenario_2_Total_ME_GJ","UAA","fit","lwr","upr")) 
CI[, 1] <- rep(Scenario_2_Total_ME_GJ, each = length(UAA)) 
CI[, 2] <- rep(UAA, times = length(Scenario_2_Total_ME_GJ)) 
for (i in 1:length(Scenario_2_Total_ME_GJ)){
  for (j in 1:length(UAA)){
    CI[(i-1)*length(UAA) + (j-1) + 1, 3:5] <- my.cix(Scenario_2_Total_ME_GJ[i], UAA[j],
                                                     beta = my.beta, V = my.V)
  }
}
CI
CI_60 <- as.data.frame(CI)

##### UAA = 80 ha ######
UAA <- 80

## put it all in a matrix
CI <- matrix(NA, length(Scenario_2_Total_ME_GJ)*length(UAA), 5)
dimnames(CI) <- list(c(NULL), c("Scenario_2_Total_ME_GJ","UAA","fit","lwr","upr")) 
CI[, 1] <- rep(Scenario_2_Total_ME_GJ, each = length(UAA)) 
CI[, 2] <- rep(UAA, times = length(Scenario_2_Total_ME_GJ)) 
for (i in 1:length(Scenario_2_Total_ME_GJ)){
  for (j in 1:length(UAA)){
    CI[(i-1)*length(UAA) + (j-1) + 1, 3:5] <- my.cix(Scenario_2_Total_ME_GJ[i], UAA[j],
                                                     beta = my.beta, V = my.V)
  }
}
CI
CI_80 <- as.data.frame(CI)

################# PLOT ######################

## Plot predicted values ##
par(mfrow = c(1, 1), mar = c(5,7,4,4) + 0.1)
y <- Mean_Energy$Bird_Sp_All      # define variable here
x <- Mean_Energy$Mean_Scenario_2

plot(x,y,pch=19, col="white", 
     # ylim=c(20, 60),
     # xlim=c(0, 70000),
     cex.lab = 1.8,
     cex.main = 1.8,
     cex.axis = 1.8, # font size axis
     las=1, # horizontal y-axes labels
     # mtext("(a)", side = 2, line = 1, outer = FALSE, at=0.70, las=1, cex=1.8),
     main="", xlab=" ", ylab="", cex=1.5)
title(ylab="Total bird species richness", line=3.5, cex.lab=1.8)
title(xlab="Food energy (GJ)", line=3.5, cex.lab=1.8)
rug(Mean_Energy$Mean_Scenario_2)

# Add lines and CI
# 60 ha UAA
lines(CI_60$fit ~ CI_60$Scenario_2_Total_ME_GJ, lwd=2, col="blue") # predicted values
lines(CI_60$lwr ~ CI_60$Scenario_2_Total_ME_GJ, lty=2, lwd=2, col="blue") # Lower Prediction interval
lines(CI_60$upr ~ CI_60$Scenario_2_Total_ME_GJ, lty=2, lwd=2, col="blue") # Upper Prediction interval
# Mean UAA
lines(CI_80$fit ~ CI_80$Scenario_2_Total_ME_GJ, lwd=2, col="red") # predicted values
lines(CI_80$lwr ~ CI_80$Scenario_2_Total_ME_GJ, lty=2, lwd=2, col="red") # Lower Prediction interval
lines(CI_80$upr ~ CI_80$Scenario_2_Total_ME_GJ, lty=2, lwd=2, col="red") # Upper Prediction interval

#############################################################################################################

## SUPP MATERIAL S5: Relationship between food energy produced and farmland area

## SCENARIO 1
fit <- with(implist, lm (Scenario_1_Total_ME_GJ ~ UAA))
mitools.fit <- MIcombine(fit); mitools.res <- summary(mitools.fit)
mitools.res <- cbind(mitools.res, df = mitools.fit$df)
mitools.res

## SCENARIO 2
fit <- with(implist, lm (Scenario_2_Total_ME_GJ ~ UAA))
mitools.fit <- MIcombine(fit); mitools.res <- summary(mitools.fit) ## sign. pos
mitools.res <- cbind(mitools.res, df = mitools.fit$df)
mitools.res

## SUPP MATERIAL TABLE S5.1 Relationship between food energy produced and crop area

## Import from DRYAD "Zingg_2023_Scaled_crop_area.csv"
crop_area <-read.csv () # define path
crop_area$KoordID <- as.factor(crop_area$KoordID)
## Repeat the crop_area data frame 50 times to merge it with the imputed data frame
n <- 50
crop_area_n <- cbind(crop_area [rep(1:nrow(crop_area), n), ], .imp = rep(1:n, each = nrow(crop_area)))
## Merge data frames
crop_area_n <- merge(data, crop_area_n, by =c("KoordID", ".imp"), all=TRUE)

## Create a list of data frames based on the completed data set:
data_list_2 <- split(crop_area_n, f = crop_area_n$.imp)
# Prepare implist
implist_2 <- imputationList(data_list_2)

## STEP 1: Fit univariate models using total food energy and crop scaled area
## STEP 2: Fit multivariate models only using the crops with a significant result from Step 1.

## STEP 1: Example with total food energy from Scenario 2 and Cereal area
fit <- with(implist_2, lm (Scenario_2_Total_ME_GJ ~ Cereals_Scaled_Area_ha)); mitools.fit <- MIcombine(fit); mitools.res <- summary(mitools.fit) ## sign. pos
## STEP 2: Example with total food energy from Scenario 2 and all significant crops
fit <- with(implist_2, lm (Scenario_2_Total_ME_GJ ~ Int_grassland_Scaled_Area_ha + Cereals_Scaled_Area_ha + Silage_maize_Scaled_Area_ha + Oilseed_crops_Scaled_Area_ha 
                           + Sugar_beet_Scaled_Area_ha + Vegetables_Scaled_Area_ha + Potato_Scaled_Area_ha))
mitools.fit <- MIcombine(fit); mitools.res <- summary(mitools.fit)

#############################################################################################################

## SUPP MATERIAL S7: Single species analyses
## For the figures the data frame from DRYAD "Zingg_2023_Data_for_modelling_Mean_Energy_Single_Species" was used.

#############################################################################################################

## 21.04.2023 ##

