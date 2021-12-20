# Packages
library(dplyr)
library(randomForest)

starwars
starwars <- starwars

subset_starwars <- starwars[c(2, 3, 10, 11)]
head(subset_starwars)
str(subset_starwars)

subset_starwars$homeworld <- as.factor(subset_starwars$homeworld)
subset_starwars$species <- as.factor(subset_starwars$species)
str(subset_starwars)

reordered_subset <- subset_starwars[,c(4,1,2,3)]
final_subset <- reordered_subset[!is.na(reordered_subset$species),]

# Model

set.seed(42)

subset.imputed <- rfImpute(species ~ ., data = final_subset, iter=6)

model <- randomForest(species ~ ., data=subset.imputed, proximity=TRUE)
model

# Testing number of parameters
oob.values <- vector(length=10)
for(i in 1:10) {
  temp.model <- randomForest(species ~ ., data=subset.imputed, mtry=i, ntree=1000)
  oob.values[i] <- temp.model$err.rate[nrow(temp.model$err.rate),1]
}
oob.values

