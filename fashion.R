# Load the MNIST digit recognition dataset into R
# http://yann.lecun.com/exdb/mnist/
# assume you have all 4 files and gunzip'd them
# creates train$n, train$x, train$y  and test$n, test$x, test$y
# e.g. train$x is a 60000 x 784 matrix, each row is one digit (28x28)
# call:  show_digit(train$x[5,])   to see a digit.
# brendan o'connor - gist.github.com/39760 - anyall.org

library(caret)
library(png)

load_mnist <- function() {
  load_image_file <- function(filename) {
    ret = list()
    f = gzfile(filename,'rb')
    readBin(f,'integer',n=1,size=4,endian='big')
    ret$n = readBin(f,'integer',n=1,size=4,endian='big')
    nrow = readBin(f,'integer',n=1,size=4,endian='big')
    ncol = readBin(f,'integer',n=1,size=4,endian='big')
    x = readBin(f,'integer',n=ret$n*nrow*ncol,size=1,signed=F)
    ret$x = matrix(x, ncol=nrow*ncol, byrow=T)
    close(f)
    ret
  }
  load_label_file <- function(filename) {
    f = gzfile(filename,'rb')
    readBin(f,'integer',n=1,size=4,endian='big')
    n = readBin(f,'integer',n=1,size=4,endian='big')
    y = readBin(f,'integer',n=n,size=1,signed=F)
    close(f)
    y
  }
  
  trainData <<- load_image_file('data/train-images-idx3-ubyte.gz')
  testData <<- load_image_file('data/t10k-images-idx3-ubyte.gz')
  
  trainData$y <<- load_label_file('data/train-labels-idx1-ubyte.gz')
  testData$y <<- load_label_file('data/t10k-labels-idx1-ubyte.gz')  
}

show_digit <- function(arr784, col=gray(12:1/12), ...) {
  image(matrix(arr784, nrow=28)[,28:1], col=col, ...)
}

# Load a png image as a grayscale single-channel byte array (0-255).
loadImage <- function(filename) {
  data <- readPNG(filename)

  result <- c()
  
  # Convert to single-channel grayscale RGBA -> G, using the average method.
  for (i in 1:nrow(data)) {
    for (j in 1:ncol(data)) {
      rgba <- data[i,j,] # Row i column j
      g <- round(256 * mean(rgba[1:3]) / 3)
      
      result <- c(result, g)
    }
  }
  
  list(bytes=result, nrow=nrow(data), ncol=ncol(data))
}

# Helper for running a trained model against actual 28x28 PNG images.
runTest <- function(filename, model) {
  # Load the png.
  png <- loadImage(filename)
  
  # Plot the image.
  show_digit(png$bytes)
  
  # Convert the bytes to a format for our model.
  pngData <- data.frame(x = matrix(png$bytes, 1, 784))
  
  # Predict the result.
  predict(model, pngData)
}

# Load data.
load_mnist()

# Convert y-value to a factor.
trainData$y <- as.factor(trainData$y)
testData$y <- as.factor(testData$y)

# Set labels.
labels <- c('T-shirt/top', 'Trouser', 'Pullover', 'Dress', 'Coat', 'Sandal', 'Shirt', 'Sneaker', 'Bag', 'Ankle boot')
levels(trainData$y) <- labels
levels(testData$y) <- labels

dataTrain <- data.frame(x = trainData$x[1:10000,], y = trainData$y[1:10000])
dataTest <- data.frame(x = testData$x, y = testData$y)

# Train.
trainctrl <- trainControl(verboseIter = TRUE, number=5, repeats=1, method='repeatedcv')
fit <- train(y ~ ., data=dataTrain, method = 'gbm', trControl = trainctrl)

# Get confusion matrix for results.
confusionMatrix(predict(fit, dataTrain), dataTrain$y)
confusionMatrix(predict(fit, dataTest), dataTest$y)

# Baseline accuracy: always predict most frequent y-value (1).
# 12% / 10%
max(table(dataTrain$y)) / nrow(dataTrain)
max(table(dataTest$y)) / nrow(dataTest)

# Model accuracy.
# LogitBoost: (1000) .952 / .682, (10000) .813 / .748
# gbm: (10000) .940 / .844, (30000) .901 / .853
# multinom: (10000) .870 / .720, (30000) .835 / .783 (MaxNWts = 10000)
# svmRadial: (10000) .902 / .785, (30000) .912 / .872
# rf: 
# lda: 
length(which(predict(fit, dataTrain) == dataTrain$y)) / nrow(dataTrain)
length(which(predict(fit, dataTest) == dataTest$y)) / nrow(dataTest)

# Try on our own data (28x28 PNG)!
runTest('data/test/shirt1-28x28.png', fit)
runTest('data/test/shirt2-28x28.png', fit)
runTest('data/test/shirt3-28x28.png', fit)
runTest('data/test/pants1-28x28.png', fit)
runTest('data/test/pants2-28x28.png', fit)
runTest('data/test/sneaker1-28x28.png', fit)
runTest('data/test/sneaker2-28x28.png', fit)
