#Feature Engineering, create a new variable(family_size) which is the sum of SibSp 
#and Parch+1 to see if it has an effect. Turns out with minsplit=50 and cp=0, it is 
#not appear in the resulting decision tree

# create a new train set with the new variable
train_two <- train
train_two$family_size <- train_two$SibSp + train_two$Parch + 1

# Create a new decision tree my_tree_three
my_tree_four <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked
                      + family_size, 
                      data = train_two, 
                      method ="class", control = rpart.control(minsplit=50,cp = 0))

# Visualize your new decision tree
fancyRpartPlot(my_tree_four)
#Since it did not appear on the decision tree at this level it doesn't seem that useful
#We'll try to engineer a new feature.

#
#Feature Engineering with passenger title
#
# train_new and test_new are available in the workspace
str(train_new)
str(test_new)

# Create a new model `my_tree_five`
my_tree_five <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked
                      + Title, data=train_new, method="class")

# Visualize your new decision tree
fancyRpartPlot(my_tree_five)

# Make your prediction using `my_tree_five` and `test_new`
my_prediction <- predict(my_tree_five, test_new, type="class")

# Create a data frame with two columns: PassengerId & Survived. 
#Survived contains your predictions
my_solution <- data.frame(PassengerId = test_new$PassengerId,
                          Survived =  my_prediction)

# Write your solution away to a csv file with the name my_solution.csv
write.csv(my_solution, file="my_solution.csv",row.names=FALSE)
