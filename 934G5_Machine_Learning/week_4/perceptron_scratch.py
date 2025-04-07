import numpy as np

def step_func(x):
    return np.where(x > 0, 1, 0)

class Perc:
    def __init__(self, learning_rate=0.01, epochs=100):
        self.lr = learning_rate
        self.epochs = epochs
        self.activ_func = step_func
        self.weight = None
        self.bias = None

    def fit(self, X_train, y_train):
        # shape of dataset: samples, features
        # init the parameters: zeros or randos
        # ensure y is in correct 0, 1 format
        # step in epochs loops
        # inner loop going through dataset: idx, x_i, enumerate(X)
        # lin_pred np.dat(x, w) + b
        # y_pred = activ_func(lin_pred)
        # update value = lr * (y[idx] - y_red)
        # weights =+ update * x_i
        # bias =+ update

        n_samples, n_features = X_train.shape

         # init parameters
        self.weights = np.zeros(n_features)
        self.bias = 0

        y_ = np.where(y_train > 0, 1, 0)

        for _ in range(self.epochs):
            for idx, x_i in enumerate(X_train):
                lin_pred = np.dot(x_i, self.weights) + self.bias
                y_pred = self.activ_func(lin_pred)

                update = self.lr * (y_[idx] - y_pred)
                self.weights += update * x_i
                self.bias += update

    def pred(self, X_test):
        lin_pred = np.dot(X_test, self.weights) + self.bias
        return self.activ_func(lin_pred)

# Testing
if __name__ == "__main__":
    # Imports
    import matplotlib.pyplot as plt
    from sklearn.model_selection import train_test_split
    from sklearn import datasets

    def accuracy(y_true, y_pred):
        accuracy = np.sum(y_true == y_pred) / len(y_true)
        return accuracy

    # GET DATASET
    X, y = datasets.make_blobs(
        n_samples=150, n_features=2, centers=2, cluster_std=1.05, random_state=2
    )

    # SPLIT DATA
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=123
    )

    # RUN MODEL
    p = Perc(learning_rate=0.01, epochs=100)
    p.fit(X_train, y_train)
    predictions = p.pred(X_test)

    # METRIC
    print("Perceptron classification accuracy", accuracy(y_test, predictions))

    # VISUALS
    fig = plt.figure()
    ax = fig.add_subplot(1, 1, 1)
    plt.scatter(X_train[:, 0], X_train[:, 1], marker="o", c=y_train)

    x0_1 = np.amin(X_train[:, 0])
    x0_2 = np.amax(X_train[:, 0])

    x1_1 = (-p.weights[0] * x0_1 - p.bias) / p.weights[1]
    x1_2 = (-p.weights[0] * x0_2 - p.bias) / p.weights[1]

    ax.plot([x0_1, x0_2], [x1_1, x1_2], "k")

    ymin = np.amin(X_train[:, 1])
    ymax = np.amax(X_train[:, 1])
    ax.set_ylim([ymin - 3, ymax + 3])

    plt.show()