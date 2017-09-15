Fashion
=======

Training AI machine learning models on the Fashion MNIST [dataset](https://github.com/zalandoresearch/fashion-mnist).

![](/data/test/pants1-28x28.png)
![](/data/test/pants2-28x28.png)
![](/data/test/shirt1-28x28.png)
![](/data/test/shirt2-28x28.png)
![](/data/test/shirt3-28x28.png)
![](/data/test/sneaker1-28x28.png)
![](/data/test/sneaker2-28x28.png)

## What is Fasion-MNIST?

Fashion-MNIST is a dataset consisting of 70,000 images (60k training and 10k test) of clothing objects, such as shirts, pants, shoes, and more. Each example is a 28x28 grayscale image, associated with a label from 10 classes. The 10 classes are listed below.

The dataset was designed as a plug-and-play replacement for the traditional [MNIST](http://yann.lecun.com/exdb/mnist/) handwritten digit recognizing dataset. Both datasets use the same scale and type of image files, along with the same number of classification labels (10), for usage with machine learning models.

## The Dataset

Download the dataset as a series of 4 zipped files:

[Train Images](/data/train-images-idx3-ubyte.gz)
[Train Labels](/data/train-labels-idx1-ubyte.gz)
[Test Images](/data/t10k-images-idx3-ubyte.gz)
[Test Labels](/data/t10k-labels-idx1-ubyte.gz)

The dataset can be loaded in R by using the same [script](https://gist.github.com/brendano/39760) for loading the traditional MNIST dataset. Additionally, images can be displayed in the same manner, by calling the `showDigit` method.

### Labels

Each training and test example is assigned to one of the following labels:

| Label | Description |
| --- | --- |
| 0 | T-shirt/top |
| 1 | Trouser |
| 2 | Pullover |
| 3 | Dress |
| 4 | Coat |
| 5 | Sandal |
| 6 | Shirt |
| 7 | Sneaker |
| 8 | Bag |
| 9 | Ankle boot |

## Loading Your Own Images

You can [load](https://gist.github.com/primaryobjects/06c2deca989af9c1acf735521ba9db81#file-readpng2-r) your own (color) images of shirts, pants, or shoes by reading any 28x28 image, converting to grayscale, and extracting the single channel of bytes from grayscale. Once loaded, you can classify the result using a trained machine learning model, based on the fashion-mnist dataset.

## Accuracy

The trained models have achieved the following accuracies (train/test) as shown below. A detailed list of accuracies is also [available](https://github.com/zalandoresearch/fashion-mnist#benchmark).

#### Baseline Algorithm (always predicts the most frequently occurring clothing item)
12%/10%

#### LogitBoost
81%/75%

#### Gradient Boosting Machine (gbm)
90%/85%

#### Neural Network (multinom)
84%/78%

#### Support Vector Machine (svmRadial)
90%/79%

## References

[The MNIST Database of Handwritten Digits](http://yann.lecun.com/exdb/mnist/)

[The Fashion-MNIST Database](https://github.com/zalandoresearch/fashion-mnist)

[Zalando](https://jobs.zalando.com/tech/)

## License

MIT

## Author

Kory Becker
http://www.primaryobjects.com