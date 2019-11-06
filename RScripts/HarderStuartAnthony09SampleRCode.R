# R CODE 
# "Propensity score techniques and the assessment of measured covariate balance to test causal associations in psychological research" 
# Code written by Valerie Harder, MHS, PhD (2009)
# Disclaimer: The following code is written for the R enviroment as a general guide to how one might run propensity score analyses and how to check covariate balance. This code is not in any way supported by the authors of the MatchIt and twang statistical packages. The manuals for the MatchIt and twang packages should be read and can be obtained from the Cran-R network (http://cran.r-project.org/mirrors.html). This is not an instruction manual on how to use the R environment or how to write R code. Those who wish to use this code should first familiarize themselves with the R environment. This code is provided by the author as a guide to others who wish to use propensity score methods. This code is not published on any official R website, and there is no associated manual for this code.

# Load libraries of statistical packages within R
# MatchIt is the package that will do the parametic estimation of the propensity scores and matching application methods such as 1:1 matching
library(MatchIt)
# An additional package needs to be loaded to run full matching
library(optmatch)
# Twang is the package that will do the non-parametric estimation of the propensity score (generalized boosted modeling, GBM) and will allow for the weighting application methods such as weighting by the odds and Inverse Probability of Treatment Weighting (IPTW)
library(twang)

# Read in your dataset 
data<-read.csv("yourdataset.csv", header=TRUE)

# Optional: subset your dataset to include only those variables needed for the propensity score analyses
data <- subset(data, select=c("outcome", "treatment", "covariates", "products", "polynomials"))
# "treatment" is the name of the treatment variable 
# "covariates" are the chosen covariates (observed confounders) 
# "products" are product terms (aka interactions between covariates) chosen during analysis and model building processes based on the researchers decisions
# "polynomials" are second or higher order polynomial terms for continuous covariates also chosen during analysis and model building processes based on the researchers decisions

# Acronyms used in this code
# PS = propensity score
# MLR = multiple logistic regression estimation of the PS, named Model 1 in the code
# MLRplus = MLR with product and/or polynomial terms estimation of the PS, named Model 2 in the code
# GBM = generalized boosted modeling estimation of the PS, named Model 3 in the code

#########################################
#### ESTIMATING THE PROPENSITY SCORE ####
#########################################
# The PS for Model 1 and Model 2 are generated within MatchIt, and the PS for Model 3 is generated within twang using GBM

# MLR, model 1
# see manual for MatchIt for all options
ps.1 <- matchit(treatment ~ covariates, data = data)
		
# PS from Model 1, MLR:
ps.1$distance

# MLRplus, model 2
# see manual for MatchIt for all options
# The difference between Model 1 and Model 2 is that Model 2 has additional terms that are chosen and tested for inclusion in the final estimation model by the researcher. These additional terms can be 'products' or 'polynomials' as discussed above. There are many different ways this choice of additional terms can be done.
# In the empirical example illustrated in the paper, we used a process by which we include product terms if the standardized bias for the product terms is above 0.25 across two or more strata of the propensity score. The specifics are discussed in our paper. Code for calculating standardized bias is shown towards the end of this example code.

ps.2 <- matchit(treatment ~ covariates + products + polynomials, data = data)

# PS from Model 2, MLRplus:
ps.2$distance

# GBM, model 3
# see manual for twang and gbm for all options
set.seed(1234)
ps.3 <- ps(treatment ~ covariates,
			data = data,
# stop methods are chosen by the researcher, and more than one can be listed. For example, we only list one, es.stat.mean, see manual for twang
			stop.method = stop.methods[("es.stat.mean")],
#generate plots, see manual for twang
			plots=NULL,
			pdf.plots=FALSE,
#gbm options, see manual for gbm
			n.trees = 3000,
			interaction.depth = 2,
			shrinkage = 0.01,
			perm.test.iters = 0,
			verbose = FALSE)

# PS from Model 3, GBM
ps.3$ps$es.stat.mean

#########################
# APPLICATION OF THE PS #
#########################

# Five Applications: Matching nearest neighbor 1:1, Matching Full, Subclassification, Weighting by the Odds, and Weighting by the Inverse Probability of Treatment Weights

### 1:1 matching
# "nearest" stands for 1:1 nearest neighbor matching, see MatchIt manual for details
			
ps.1.mtch <- matchit(treatment ~ covariates, data = data,
			# "nearest" stands for 1:1 nearest neighbor matching
			method = "nearest")

ps.2.mtch <- matchit(treatment ~ covariates + products + polynomials, data = data,
			method = "nearest")

ps.3.mtch <- matchit(treatment ~ covariates, data = data,
			distance = ps.3$ps$es.stat.mean,
			method = "nearest")

### FULL matching
# "full" stands for full matching, see MatchIt manual for details

ps.1.full <- matchit(treatment ~ covariates, data = data,
			# "nearest" stands for 1:1 nearest neighbor matching
			method = "full")

ps.2.full <- matchit(treatment ~ covariates + products + polynomials, data = data,
			method = "full")

ps.3.full <- matchit(treatment ~ covariates, data = data,
			distance = ps.3$ps$es.stat.mean,
			method = "full")

### SUBCLASSIFICATION
# "subclass" stands for subclassification, see MatchIt manual for details
# In MatchIt, "subclass" forms six subclasses (strata) by default, and each subclass will have approximately the same number of treated units
# In this example, we start with ten subclasses instead of the default and then decrease the final number to seven based on our inspection of distribution of comparison units in each subclass

ps.1.subcl <- matchit(treatment ~ covariates, data = data,
			method = "subclass", subclass = 10)

# In this empirical example, only seven subclasses are made by combining the top four deciles due to lack of # of controls in the higher decile subclasses
#Defines the new subclasses in terms of percentiles, not actual PS values.
subclass7 <- c(0.00, 0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 1.00)

ps.1.subcl <- matchit(treatment ~ covariates, data = data,
			method = "subclass", subclass = subclass7)

# Only six subclasses are used for Model 2 to get better overlap. The top five deciles are combined due to lack of # of controls in the higher decile subclasses
#Defines the new subclasses in terms of percentiles, not actual PS values.
subclass6 <- c(0.00, 0.10, 0.20, 0.30, 0.40, 0.50, 1.00)
			
ps.2.subcl <- matchit(treatment ~ covariates + products + polynomials, data = data,
			method = "subclass", subclass = subclass6)

# Model 3 uses seven subclasses again
ps.3.subcl <- matchit(treatment ~ covariates, data = data,
			distance = ps.3$ps$es.stat.mean,
			method = "subclass", subclass = subclass7)

### WEIGHTING
# Creates weights for weighting by the odds and for inverse probablility of treatment weighting
# Creates new variables within the dataset for odds and IPTW based on the PS generated from Models 1, 2, and 3
#ODDS
data$odds_1 <- ifelse(data$treatment==1, 1, ps.1$distance/(1-ps.1$distance)) 
data$odds_2 <- ifelse(data$treatment==1, 1, ps.2$distance/(1-ps.2$distance)) 
data$odds_3 <- ifelse(data$treatment==1, 1, ps.3$ps$es.stat.mean/(1-ps.3$ps$es.stat.mean))

# WEIGHTING BY THE ODDS using twang

# Use twang "dx.wts" function with odds as weights, see twang manual for details
ps.1.odds <- dx.wts(data$odds_1, data = data,
				treat.var="treatment")

ps.2.odds <- dx.wts(data$odds_2, data = data,
				treat.var="treatment")

ps.3.odds <- dx.wts(data$odds_3, data = data,
				treat.var="treatment")

# Also the "ps" function in twang will utilize weighting by the odds as its default ps weighting application method after generating the PS through gbm. So it will calculate the odds and use it as the weighting function by default.
# The following code is for example purposes and will also generate the standardized biases after weighting by the odds.
# set.seed(1234)
# ps.3.odds <- ps(treatment ~ covariates,
#			data = data,
#			title = "gbm.odds"
#			stop.method = stop.methods[("es.stat.mean")],
#			#generate plots
#			plots="all",
#			pdf.plots=TRUE,
#			#gbm options
#			n.trees = 3000,
#			interaction.depth = 2,
#			shrinkage = 0.01,
#			perm.test.iters = 0,
#			verbose = TRUE)

# Creating the IPTW
data$iptw_1 <- ifelse(data$treatment==1, 1/ps.1$distance, 1/(1-ps.1$distance))
data$iptw_2 <- ifelse(data$treatment==1, 1/ps.2$distance, 1/(1-ps.2$distance))
data$iptw_3 <- ifelse(data$treatment==1, 1/ps.3$ps$es.stat.mean, 1/(1-ps.3$ps$es.stat.mean))

# STABILIZING the IPTW weights
data$stable.1.iptw <- ifelse(data$treatment==1, (mean(ps.1$distance))/ps.1$distance, (mean(1-ps.1$distance))/(1-ps.1$distance))
data$stable.2.iptw <- ifelse(data$treatment==1, (mean(ps.2$distance))/ps.2$distance, (mean(1-ps.2$distance))/(1-ps.M$distance))
data$stable.3.iptw <- ifelse(data$treatment==1, (mean(ps.3$ps$es.stat.mean))/ps.3$ps$es.stat.mean, (mean(1-ps.3$ps$es.stat.mean))/(1-ps.3$ps$es.stat.mean))

# TRIMMING the stabilized IPTW weights
data$stable.trim.1.iptw <- ifelse(data$stable.1.iptw < .10, 0.10, data$stable.1.iptw)
data$stable.trim.1.iptw <- ifelse(data$stable.1.iptw > 10, 10, data$stable.trim.1.iptw)

data$stable.trim.2.iptw <- ifelse(data$stable.2.iptw < .10, 0.10, data$stable.2.iptw)
data$stable.trim.2.iptw <- ifelse(data$stable.2.iptw > 10, 10, data$stable.trim.2.iptw)

data$stable.trim.3.iptw <- ifelse(data$stable.3.iptw < .10, 0.10, data$stable.3.iptw)
data$stable.trim.3.iptw <- ifelse(data$stable.3.iptw > 10, 10, data$stable.trim.3.iptw)

# Use twang "dx.wts" function with stabilized and trimmed iptw weights, see twang manual for details on the "dx.wts" function
ps.1.iptw <- dx.wts(data$stable.trim.1.iptw,
				data = data,
				treat.var="treatment")

ps.2.iptw <- dx.wts(data$stable.trim.2.iptw,
				data = data,
				treat.var="treatment")

ps.3.iptw <- dx.wts(data$stable.trim.3.iptw,
				data = data,
				treat.var="treatment")

#############################
#### STANDARDIZED BIASES ####
#############################
# To obtain the standardized biases for all covariates before and after PS application, functions within MatchIt ("summary") and twang ("bal.table") can be used.
# Standardized biases for each covariate can be compared across PS techniques to see which PS technique yields all standardized biases < 0.25

# Within MatchIt, see MatchIt manual for details regarding options
# MatchIt also has an option for "interactions=TRUE" that can be used if desired to help examine balance on interaction terms; see the MatchIt manual.

# 1:1 matching
	summary.1.mtch <- summary(ps.1.mtch, standardize=TRUE)
	stdbias.1.mtch<- abs(summary.1.mtch$sum.matched[,3])

	summary.2.mtch <- summary(ps.2.mtch, standardize=TRUE)
	stdbias.2.mtch<- abs(summary.2.mtch$sum.matched[,3])

	summary.3.mtch <- summary(ps.3.mtch, standardize=TRUE)
	stdbias.3.mtch<- abs(summary.3.mtch$sum.matched[,3])

# Full matching
	summary.1.full <- summary(ps.1.full, standardize=TRUE)
	stdbias.1.full<- abs(summary.1.full$sum.matched[,3])

	summary.2.full <- summary(ps.2.full, standardize=TRUE)
	stdbias.2.full<- abs(summary.2.full$sum.matched[,3])

	summary.3.full <- summary(ps.3.full, standardize=TRUE)
	stdbias.3.full<- abs(summary.3.full$sum.matched[,3])

# Subclassification
	summary.1.subcl <- summary(ps.1.subcl, standardize=TRUE)
	stdbias.1.subcl<- abs(summary.1.subcl$sum.matched[,3])

	summary.2.subcl <- summary(ps.2.subcl, standardize=TRUE)
	stdbias.2.subcl<- abs(summary.2.subcl$sum.matched[,3])

	summary.3.subcl <- summary(ps.3.subcl, standardize=TRUE)
	stdbias.3.subcl<- abs(summary.3.subcl$sum.matched[,3])

# Within twang
# Odds
	bal.table(ps.1.odds)
	stdbias.1.odds <- round(abs(ps.1.odds$desc$""$bal.tab$results[,5]), 3)

	bal.table(ps.2.odds)
	stdbias.2.odds <- round(abs(ps.2.odds$desc$""$bal.tab$results[,5]), 3)

	bal.table(ps.3.odds)
	stdbias.3.odds <- round(abs(ps.3.odds$desc$""$bal.tab$results[,5]), 3)

# IPTW
	bal.table(ps.1.iptw)
	stdbias.1.iptw <- round(abs(ps.1.iptw$desc$""$bal.tab$results[,5]), 3)

	bal.table(ps.2.iptw)
	stdbias.2.iptw <- round(abs(ps.2.iptw$desc$""$bal.tab$results[,5]), 3)

	bal.table(ps.3.iptw)
	stdbias.3.iptw <- round(abs(ps.3.iptw$desc$""$bal.tab$results[,5]), 3)

# Standardized biases of all covariates before PS application (not matched and not weighted)
# These two ways produce the same standardized biases since they are the standardized biases of the original un-matched and un-weighted data
# Using MatchIt
	print(abs(summary.1.mtch$sum.all[,3]))
# Using Twang
	print(ps.3$desc$unw)


### END OF CODE ###

### APPENDIX ###

##########################
#### OUTCOME ANALYSES ####
##########################
# Create matched data sets to run outcome regressions on later.

# 1:1 matching
matched.1.mtch <- match.data(ps.1.mtch)
matched.2.mtch <- match.data(ps.2.mtch)
matched.3.mtch <- match.data(ps.3.mtch)

# Full Matching
matched.1.full <- match.data(ps.1.full)
matched.2.full <- match.data(ps.2.full)
matched.3.full <- match.data(ps.3.full)

# Sublcassification
matched.1.subcl <- match.data(ps.1.sbcl)
matched.2.subcl <- match.data(ps.2.sbcl)
matched.3.subcl <- match.data(ps.3.sbcl)

# The weights (odds and IPTW) can be input directly as an option in the 'glm' function in R, see manual for details on glm.

# Code for one outcome regression is illustrated: Model 1 (Muliple Logistic Regression) paired with subclassification. This one regression is illustrated for purposes of later calculating the variance of the estimate from the subclassification technique.

glm.1.subcl <- glm(outcome ~ treatment + factor(subclass) + factor(subclass)*treatment, 
				data = matched.1.subcl,
				family = binomial)
summary(glm.M1.subcl)

########################################
#### VARIANCE FOR SUBCLASSIFICATION ####
########################################

# The following code can be used by researchers as an example of how to obtain appropriate variance estimates for odds ratios generated using the subclassification technique. There are certainly different and more efficient ways of writing this code.

# Step 1: Calculate proportion of individuals in each subclass out of total sample size
table(matched.1.subcl$subclass, data$treatment)

# We illustrate the code for Model 1 paired with subclassification only. The other two models are similar.
# N : total sample size
# Make a vector of the subclass proportions of individuals in each subclass 
tabsubprop1<-table(matched.1.subcl$subclass, data$treatment)
subprop.1<-rep(0,7)
subprop.1[1]<-sum(tabsubprop1[1,1],tabsubprop1[1,2])/N
subprop.1[2]<-sum(tabsubprop1[2,1],tabsubprop1[2,2])/N
subprop.1[3]<-sum(tabsubprop1[3,1],tabsubprop1[3,2])/N
subprop.1[4]<-sum(tabsubprop1[4,1],tabsubprop1[4,2])/N
subprop.1[5]<-sum(tabsubprop1[5,1],tabsubprop1[5,2])/N
subprop.1[6]<-sum(tabsubprop1[6,1],tabsubprop1[6,2])/N
subprop.1[7]<-sum(tabsubprop1[7,1],tabsubprop1[7,2])/N
subprop.1

## The DELTA METHOD, a generalization of the Central Limit Theorem using TAYLOR SERIES APPROXIMATIONS, is used to estimate the variance of a function of a random variable. In our case, the random variable is the redicted probability of the outcome within each subclass for the treated and comparison groups, and the function is the average log odds ratio across all the subclasses. The overall effect is calculated as the log odds raio of the outcome. 
# To get variance of log odds ratio, first make a vector of betas for each generalized linear model (glm) run in the outcome analyses

# For example, our glm function that was created for Model 1 and subclassification was named 'glm.1.subcl'
# See GLM manual for details of the "glm" function
betas.1 <- glm.1.subcl$coef

# To Run Model 1 (MLR) through the loop, replace generic variables 'betas' and 'subprop' with those for Model 1
betas <- betas.1
subprop <- subprop.1
 
#1. Calculate the log odds ratio (lor) in R for seven subclasses
lor <- function(subprop, betas) {
		b01<-betas[1]
		b11<-betas[2]
		b02<-betas[3]
		b12<-betas[9]
		b03<-betas[4]
		b13<-betas[10]
		b04<-betas[5]
		b14<-betas[11]
		b05<-betas[6]
		b15<-betas[12]
		b06<-betas[7]
		b16<-betas[13]
		b07<-betas[8]
		b17<-betas[14]	

#make the numerator of the first term in the difference of natural logs
	term1n <- rep(0,7)
		term1n[1] <- (subprop[1]*exp(b01+b11)/(1+exp(b01+b11)))
		term1n[2] <- (subprop[2]*exp(b01+b11+b02+b12)/(1+exp(b01+b11+b02+b12)))
		term1n[3] <- (subprop[3]*exp(b01+b11+b03+b13)/(1+exp(b01+b11+b03+b13)))
		term1n[4] <- (subprop[4]*exp(b01+b11+b04+b14)/(1+exp(b01+b11+b04+b14)))
		term1n[5] <- (subprop[5]*exp(b01+b11+b05+b15)/(1+exp(b01+b11+b05+b15)))
		term1n[6] <- (subprop[6]*exp(b01+b11+b06+b16)/(1+exp(b01+b11+b06+b16)))
		term1n[7] <- (subprop[7]*exp(b01+b11+b07+b17)/(1+exp(b01+b11+b07+b17)))

	term1ntotal <- sum(term1n)
# make the first term in the difference of natural logs
	term1 <- log(term1ntotal/(1-term1ntotal))

# make the numerator of the second term in the difference of natural logs
	term2n <- rep(0,7)
		term2n[1] <- (subprop[1]*exp(b01)/(1+exp(b01)))
		term2n[2] <- (subprop[2]*exp(b01+b02)/(1+exp(b01+b02)))
		term2n[3] <- (subprop[3]*exp(b01+b03)/(1+exp(b01+b03)))
		term2n[4] <- (subprop[4]*exp(b01+b04)/(1+exp(b01+b04)))
		term2n[5] <- (subprop[5]*exp(b01+b05)/(1+exp(b01+b05)))
		term2n[6] <- (subprop[6]*exp(b01+b06)/(1+exp(b01+b06)))
		term2n[7] <- (subprop[7]*exp(b01+b07)/(1+exp(b01+b07)))

	term2ntotal <- sum(term2n)
# make the second term in the difference of natural logs
	term2 <- log(term2ntotal/(1-term2ntotal))

# calculate the final log odds ratio (lor) as the difference in natural logs term1 - term2
	term1 - term2
}

# call the function to get the lor
lor(subprop, betas)

# Next, the partial derivative of the function with respect to each element of beta is calculated empirically, rather than algebraically, using a very small change (epsilon)
# In order for empirical estimation to approach the partial derivative, the epsilon should be as small as possible.
# One may wish to vary the value of Epsilon to test the sensitivity of the variance estimate to the choice of Epsilon. 
# When EPSILON = 0.01
epsilon.01 <- .01
partialsbeta.01 <- rep(0,14)
for(i in 1:14){
	betastemp <- betas
	betastemp[i] <- betas[i] + epsilon.01
	partialsbeta.01[i] <- (lor(subprop, betastemp)-lor(subprop, betas))/ epsilon.01
	}

# When EPSILON = 0.1
epsilon.1 <- .1
partialsbeta.1 <- rep(0,14)
for(i in 1:14){
	betastemp <- betas
	betastemp[i] <- betas[i] + epsilon.1
	partialsbeta.1[i] <- (lor(subprop, betastemp)-lor(subprop, betas))/ epsilon.1
	}
	
# Using the partial derivatives in the final function to calculate the new variance

varmat.M1 <- vcov(glm.1.subcl)
var.M1.term1.01 <- sum((partialsbeta.01^2)*diag(varmat.M1)) 
var.M1.term1.1 <- sum((partialsbeta.1^2)*diag(varmat.M1)) 

for (i in 1:14) {
	for(j in 1:14) {
		if(i!=j){
			var.M1.term2.01 <- sum(sum(partialsbeta.01[i]*partialsbeta.01[j]*varmat.M1[i,j]))
			var.M1.term2.1 <- sum(sum(partialsbeta.1[i]*partialsbeta.1[j]*varmat.M1[i,j]))
			}
		}
	}

# Variance of the logodds ratio when Epsilon = 0.01
var.M1.01 <- var.M1.term1.01 + var.M1.term2.01
# Variance of the logodds ratio when Epsilon = 0.1
var.M1.1 <- var.M1.term1.1 + var.M1.term2.1.0

#########
## END ##
#########
