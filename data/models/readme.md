Fashion
=======

This directory `/data/models` contains pre-trained machine learning models for the fashion dataset, saved as binary files.

## Loading a Pre-Trained Model

You can load these models into your R program, without having to re-train the models. Use the following code:

### Usage

```r
load('data/models/gbm-30000.dat')
```

### Predicting

The above code will load the object `fit` into your environment. You can then predict on the model with the following code:

```r
# Show confusion matrix.
confusionMatrix(predict(fit, dataTrain), dataTrain$y)
confusionMatrix(predict(fit, dataTest), dataTest$y)

# Show accuracy.
length(which(predict(fit, dataTrain) == dataTrain$y)) / nrow(dataTrain)
length(which(predict(fit, dataTest) == dataTest$y)) / nrow(dataTest)

# Predict on a test image.
runTest('data/test/shirt1-28x28.png', fit)
```

## Pre-Trained Models

#### XGBoost

`gbm-30000.dat`

#### Logistic Regression

`logit-60000.dat`

#### Neural Network (trained on 10,000 records)

`nnet-10000.dat`

#### Neural Network (trained on 30,000 records)

`nnet-30000.dat`

#### Support Vector Machine

`svm-30000.dat`
