####################################
# Data Professor                   #
# http://youtube.com/dataprofessor #
# http://github.com/dataprofessor  #
####################################

# Importing libraries
library(RCurl) # for downloading the iris CSV file
library(randomForest)
library(caret) # for data splitting

# Importing the Iris data set
iris <- read.csv(text = getURL("https://raw.githubusercontent.com/dataprofessor/data/master/iris.csv") )

# Performs stratified random split of the data set
TrainingIndex <- createDataPartition(iris$Species, p=0.8, list = FALSE) #splits the file 80-20
TrainingSet <- iris[TrainingIndex,] # Training Set, i.e. 80%
TestingSet <- iris[-TrainingIndex,] # Test Set, i.e. 20%

write.csv(TrainingSet, "training.csv")
write.csv(TestingSet, "testing.csv")

TrainSet <- read.csv("training.csv", header = TRUE)
TrainSet <- TrainSet[,-1]

# Building Random forest model

model <- randomForest(Species ~ ., data = TrainSet, ntree = 500, mtry = 4, importance = TRUE)

# Save model to RDS file
saveRDS(model, "model.rds")
