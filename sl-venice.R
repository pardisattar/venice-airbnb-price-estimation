airbnb <- read.csv("F:/sl project/listings (2).csv.gz")
dim(airbnb)
names(airbnb)
summary(airbnb$price)

head(airbnb$price)

airbnb$price <- as.numeric(gsub("[\\$,]", "", airbnb$price))

summary(airbnb$price)

dim(airbnb)

airbnb <- airbnb[airbnb$price > 0, ]

airbnb$log_price <- log(airbnb$price)

summary(airbnb$price)
hist(airbnb$price, breaks=50)
hist(airbnb$log_price, breaks=50)

airbnb <- airbnb[!is.na(airbnb$price), ]

summary(airbnb$price)

boxplot(airbnb$price)

airbnb <- airbnb[airbnb$price < quantile(airbnb$price, 0.99), ]

summary(airbnb$price)
hist(airbnb$price, breaks=50)

str(airbnb)


airbnb_clean <- airbnb[, c(
  "log_price",
  "price",
  "accommodates",
  "bathrooms",
  "bedrooms",
  "beds",
  "minimum_nights",
  "maximum_nights",
  "latitude",
  "longitude",
  "availability_30",
  "availability_60",
  "availability_90",
  "availability_365",
  "number_of_reviews",
  "reviews_per_month",
  "review_scores_rating",
  "review_scores_accuracy",
  "review_scores_cleanliness",
  "review_scores_checkin",
  "review_scores_communication",
  "review_scores_location",
  "review_scores_value",
  "host_is_superhost",
  "host_identity_verified",
  "host_listings_count",
  "host_total_listings_count",
  "room_type",
  "property_type",
  "neighbourhood_cleansed",
  "instant_bookable"
)]

airbnb_clean$host_response_rate <- airbnb$host_response_rate
airbnb_clean$host_acceptance_rate <- airbnb$host_acceptance_rate

airbnb_clean$host_response_rate[airbnb_clean$host_response_rate %in% c("N/A", "")] <- NA
airbnb_clean$host_acceptance_rate[airbnb_clean$host_acceptance_rate %in% c("N/A", "")] <- NA

airbnb_clean$host_response_rate <- as.numeric(gsub("%", "", airbnb_clean$host_response_rate))
airbnb_clean$host_acceptance_rate <- as.numeric(gsub("%", "", airbnb_clean$host_acceptance_rate))

summary(airbnb_clean$host_response_rate)
summary(airbnb_clean$host_acceptance_rate)

sum(is.na(airbnb_clean$host_response_rate))
sum(is.na(airbnb_clean$host_acceptance_rate))


airbnb_clean <- airbnb[, c(
  "log_price",
  "price",
  "accommodates",
  "bathrooms",
  "bedrooms",
  "beds",
  "minimum_nights",
  "maximum_nights",
  "latitude",
  "longitude",
  "availability_30",
  "availability_60",
  "availability_90",
  "availability_365",
  "number_of_reviews",
  "reviews_per_month",
  "review_scores_rating",
  "review_scores_accuracy",
  "review_scores_cleanliness",
  "review_scores_checkin",
  "review_scores_communication",
  "review_scores_location",
  "review_scores_value",
  "host_is_superhost",
  "host_identity_verified",
  "host_listings_count",
  "host_total_listings_count",
  "host_response_rate",
  "host_acceptance_rate",
  "room_type",
  "property_type",
  "neighbourhood_cleansed",
  "instant_bookable"
)]

airbnb_clean$host_response_rate[airbnb_clean$host_response_rate %in% c("N/A", "")] <- NA
airbnb_clean$host_acceptance_rate[airbnb_clean$host_acceptance_rate %in% c("N/A", "")] <- NA

airbnb_clean$host_response_rate <- as.numeric(gsub("%", "", airbnb_clean$host_response_rate))
airbnb_clean$host_acceptance_rate <- as.numeric(gsub("%", "", airbnb_clean$host_acceptance_rate))

airbnb_clean$room_type <- as.factor(airbnb_clean$room_type)
airbnb_clean$property_type <- as.factor(airbnb_clean$property_type)
airbnb_clean$host_is_superhost <- as.factor(airbnb_clean$host_is_superhost)
airbnb_clean$host_identity_verified <- as.factor(airbnb_clean$host_identity_verified)
airbnb_clean$neighbourhood_cleansed <- as.factor(airbnb_clean$neighbourhood_cleansed)
airbnb_clean$instant_bookable <- as.factor(airbnb_clean$instant_bookable)

colSums(is.na(airbnb_clean))

airbnb_model <- na.omit(airbnb_clean)

dim(airbnb_model)
colSums(is.na(airbnb_model))


summary(airbnb_model$price)
summary(airbnb_model$log_price)

hist(airbnb_model$price, breaks = 40, main = "Distribution of Airbnb Prices", xlab = "Price")
hist(airbnb_model$log_price, breaks = 40, main = "Distribution of Log Price", xlab = "Log Price")

boxplot(airbnb_model$price, main = "Boxplot of Airbnb Prices", ylab = "Price")

plot(airbnb_model$accommodates, airbnb_model$price,
     xlab = "Accommodates", ylab = "Price",
     main = "Price vs Accommodates")

numeric_vars <- airbnb_model[, c(
  "log_price",
  "accommodates",
  "bathrooms",
  "bedrooms",
  "beds",
  "minimum_nights",
  "availability_365",
  "number_of_reviews",
  "reviews_per_month",
  "review_scores_rating",
  "host_listings_count",
  "host_response_rate",
  "host_acceptance_rate"
)]

round(cor(numeric_vars),2)

pca_vars <- airbnb_model[, c(
  "accommodates",
  "bathrooms",
  "bedrooms",
  "beds",
  "minimum_nights",
  "availability_365",
  "number_of_reviews",
  "reviews_per_month",
  "review_scores_rating",
  "review_scores_accuracy",
  "review_scores_cleanliness",
  "review_scores_checkin",
  "review_scores_communication",
  "review_scores_location",
  "review_scores_value",
  "host_listings_count",
  "host_response_rate",
  "host_acceptance_rate"
)]

pca_result <- prcomp(pca_vars, scale. = TRUE)

summary(pca_result)

plot(pca_result,
     type="l",
     main="Scree Plot")

pca_result$rotation


cluster_vars <- airbnb_model[, c(
  "log_price",
  "accommodates",
  "bathrooms",
  "bedrooms",
  "beds",
  "availability_365",
  "number_of_reviews",
  "reviews_per_month",
  "review_scores_rating"
)]

cluster_scaled <- scale(cluster_vars)

wss <- numeric(10)

for (i in 1:10) {
  wss[i] <- sum(kmeans(cluster_scaled, centers=i, nstart=20)$withinss)
}

plot(1:10, wss, type="b",
     xlab="Number of Clusters",
     ylab="Within-cluster Sum of Squares",
     main="Elbow Method")

set.seed(123)

kmeans_result <- kmeans(cluster_scaled, centers=4, nstart=25)

table(kmeans_result$cluster)

airbnb_model$cluster <- kmeans_result$cluster

aggregate(cbind(price, accommodates, bedrooms, review_scores_rating) ~ cluster,
          data = airbnb_model,
          mean)


model_vars <- airbnb_model[, c(
  "log_price",
  "accommodates",
  "bathrooms",
  "bedrooms",
  "beds",
  "minimum_nights",
  "availability_365",
  "number_of_reviews",
  "reviews_per_month",
  "review_scores_rating",
  "host_listings_count",
  "host_response_rate",
  "host_acceptance_rate",
  "room_type",
  "instant_bookable",
  "cluster"
)]

set.seed(123)

train_index <- sample(1:nrow(model_vars), 0.7*nrow(model_vars))

train <- model_vars[train_index, ]
test <- model_vars[-train_index, ]

lm_model <- lm(log_price ~ ., data=train)

summary(lm_model)

pred_lm <- predict(lm_model, newdata=test)

rmse <- sqrt(mean((test$log_price - pred_lm)^2))

rmse

install.packages("glmnet")
library(glmnet)

x_train <- model.matrix(log_price ~ ., train)[,-1]
y_train <- train$log_price

x_test <- model.matrix(log_price ~ ., test)[,-1]
y_test <- test$log_price

lasso_model <- cv.glmnet(x_train, y_train, alpha = 1)

plot(lasso_model)

lasso_model$lambda.min

pred_lasso <- predict(lasso_model, s = "lambda.min", newx = x_test)

rmse_lasso <- sqrt(mean((y_test - pred_lasso)^2))

rmse_lasso


install.packages("rpart.plot")
install.packages("rpart")
library(rpart)
library(rpart.plot)

tree_model <- rpart(log_price ~ ., data=train, method="anova")

rpart.plot(tree_model)

pred_tree <- predict(tree_model, newdata=test)

rmse_tree <- sqrt(mean((test$log_price - pred_tree)^2))

rmse_tree

install.packages("randomForest")
library(randomForest)

set.seed(123)

rf_model <- randomForest(
  log_price ~ .,
  data = train,
  ntree = 500,
  importance = TRUE
)

pred_rf <- predict(rf_model, newdata = test)

rmse_rf <- sqrt(mean((test$log_price - pred_rf)^2))

rmse_rf

varImpPlot(rf_model)



plot(test$log_price, pred_lm,
     main="Linear Regression: Actual vs Predicted",
     xlab="Actual", ylab="Predicted")

abline(0,1,col="red")


plot(test$log_price, pred_rf,
     main="Random Forest: Actual vs Predicted",
     xlab="Actual", ylab="Predicted")

abline(0,1,col="red")

residuals_lm <- test$log_price - pred_lm

hist(residuals_lm, breaks=40,
     main="Residuals - Linear Model",
     xlab="Error")

mae_lm <- mean(abs(test$log_price - pred_lm))
mae_rf <- mean(abs(test$log_price - pred_rf))

mae_lm
mae_rf

results <- data.frame(
  Model = c("Linear", "LASSO", "Tree", "Random Forest"),
  RMSE = c(0.425, 0.425, 0.432, 0.354)
)

results

boxplot(price ~ cluster, data=airbnb_model,
        main="Price Distribution by Cluster",
        xlab="Cluster", ylab="Price")

png("price_hist.png", width=800, height=600)
hist(airbnb_model$price, breaks=40,
     main="Price Distribution", xlab="Price")
dev.off()

png("log_price_hist.png", width=800, height=600)
hist(airbnb_model$log_price, breaks=40,
     main="Log Price Distribution", xlab="Log Price")
dev.off()

getwd()

png("price_vs_accommodates.png", width=800, height=600)
plot(airbnb_model$accommodates, airbnb_model$price,
     main="Price vs Accommodates",
     xlab="Accommodates", ylab="Price")
dev.off()

png("elbow_plot.png", width=800, height=600)
plot(1:10, wss, type="b",
     main="Elbow Method",
     xlab="Clusters", ylab="WSS")
dev.off()

png("cluster_boxplot.png", width=800, height=600)
boxplot(price ~ cluster, data=airbnb_model,
        main="Price by Cluster", xlab="Cluster", ylab="Price")
dev.off()

png("rf_importance.png", width=800, height=600)
varImpPlot(rf_model)
dev.off()