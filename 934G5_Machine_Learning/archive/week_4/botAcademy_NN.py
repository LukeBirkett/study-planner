from sklearn.datasets import fetch_openml
import numpy as np
import matplotlib.pyplot as plt

dataset = 'mnist_784'
mnist = fetch_openml(dataset, version=1, as_frame=False)

images = mnist.data # (70000, 784)
print(images.shape)
labels = mnist.target.astype(int) # (70000,)

images = images.astype("float32") / 255
labels = np.eye(10)[labels] # (70000, 10)

assert images.shape == (70000, 784), f"Expected images shape to be {(70000, 784)}, but got {images.shape}"
assert labels.shape == (70000, 10), f"Expected labels shape to be {(70000, 10)}, but got {labels.shape}"

print(f"Dataset {dataset} has been read in from sklearn.datasets")
print(f"Images training set has a shape of {images.shape}")
print(f"Labels test set has a shape of {labels.shape}")

"""
w = weights, b = bias, i = input, h = hidden, o = output, l = label
e.g. w_i_h = weights from input layer to hidden layer
"""

input_n, hidden_n, output_n = 784, 20, 10

print(f"Input layer neurons have been initialized as {input_n}")
print(f"Hidden layer neurons have been initialized as {hidden_n}")
print(f"Output layer neurons have been initialized as {output_n}")

w_i_h = np.random.uniform(-0.5, 0.5, (hidden_n, input_n))
w_h_o = np.random.uniform(-0.5, 0.5, (output_n, hidden_n))
b_i_h = np.zeros((hidden_n, 1))
b_h_o = np.zeros((output_n, 1))

print(f"Input to hidden weights matrix has a shape of {w_i_h.shape}")
print(f"Hidden to output weights matrix has a shape of {w_h_o.shape}")

print(f"Note, the input count is accoss the colums of the matrix as the rows will the MATMUL against a vector column (image)")

learn_rate = 0.01
nr_correct = 0
epochs = 1

print(f"Model have a learning rate of {learn_rate} and run for {epochs} epochs")

for epoch in range(epochs):
    print(f"An outer loop handles the epochs")
    i = 0
    for img, l in zip(images, labels):
        print(f"The inner loop will cycle through the images")

        # row to column
        img.shape += (1,)
        l.shape += (1,)

        print(f"The input data holds the images in row form. An adjustment is made to transform the image into a column vector")
        print(f"e.g. from (784,) to {img.shape}")

        # Forward propagation input -> hidden
        h_pre = b_i_h + w_i_h @ img
        h = 1 / (1 + np.exp(-h_pre)) # normalization

        print(f"ForProp Input to Hidden structure: {b_i_h.shape} + {w_i_h.shape} @ {img.shape} = ({hidden_n},1)")
        print(f"Bias Matrix + Weight Matrix @ Neuron Vector")
        print(f"Normalization 0-1 is applied")

        # Forward propagation hidden -> output
        o_pre = b_h_o + w_h_o @ h
        o = 1 / (1 + np.exp(-o_pre)) # activation

        print(f"ForProp Hidden to Output structure: {b_h_o.shape} + {w_h_o.shape} @ {h.shape} = ({output_n},1)")
        print(f"Sigmoid Activation is applied")

        # Cost function: Mean Squared Error (MSE)
        assert o.shape == l.shape, f"Shape mismatch: Output shape is {o.shape}, but label shape is {l.shape}"
        
        mean = 1 / len(o)
        sq_error = (o - l) ** 2

        e = mean * np.sum(sq_error, axis=0)
        nr_correct += int(np.argmax(o) == np.argmax(l))

        print(f"Length of output is {len(o)}, mean will be calucated using this")
        print(f"Mean square error is the cost function calculated")
        print(f"Error: {e}")

        # Backpropagation output -> hidden (cost function derivative)
        delta_o = o - l 
        w_h_o += -learn_rate * delta_o @ np.transpose(h) # (10, 1) @ (1, 20) = (10, 20)
        b_h_o += -learn_rate * delta_o

        print("Backprop")
        print("Mean Square Error derives down to delta_o = (output - labels)")

        print(f"hidden neuron shape is: {h.shape}")
        print(f"This is will transformed into a row of shape: {np.transpose(h).shape}")
        print(f"This is because it will be MATMUL aginst the derivative loss function of shape: {delta_o.shape}")
        print(f"The goal is to obtain a matrix of the same size a w_h_o ({w_h_o.shape}) so the weights can be updated")
        print(f"MATMUL retains the rows of LHS and cols of RHS")


        # Backpropagation hidden -> input (activation function derivative)
        delta_h = np.transpose(w_h_o) @ delta_o * (h * (1 - h))
        w_i_h += -learn_rate * delta_h @ np.transpose(img)
        b_i_h += -learn_rate * delta_h

        print(f"Hidden player neurons is a more involved derivative")
        print(f"(h * (1 - h)) is the derivative of the sigmoid activation")
        print(f"Following from that the process is the same as previous step")
        print(f"Sigmoid derivative shape: {(h * (1 - h)).shape}")
        print(f"delta_o shape: {delta_o.shape}")
        print(f"w_h_o transposed shape: {np.transpose(w_h_o).shape}")
        print(f"{np.transpose(w_h_o).shape} @ {delta_o.shape} * {(h * (1 - h)).shape}")
        print(f"MATMUL takes precedence over elementwise operation")

        if i == 0:
            break

    # Show accuracy for this epoch
    # print(f"Acc: {round((nr_correct / images.shape[0]) * 100, 2)}%")
    # nr_correct = 0