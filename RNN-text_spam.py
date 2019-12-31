#!/usr/bin/env python
# coding: utf-8

import math
import pickle
import gzip
import numpy as np
import pandas
import matplotlib.pylab as plt
get_ipython().run_line_magic('matplotlib', 'inline')

# Implement RNN Network to classify whether text is spam or ham 
# ---
# 
# Dataset is obtained from UCI Machine Learning repository consisting of SMS tagged messages (labelled as either **ham** (legitimate) or **spam**) that have been collected for SMS Spam research.
# 

from tensorflow.keras.datasets import imdb
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
from tensorflow.keras.layers import LSTM
from tensorflow.keras.layers import Embedding
from tensorflow.keras.preprocessing import sequence
from tensorflow.keras.preprocessing.text import Tokenizer


class RNN:
    '''
    RNN classifier
    '''

    def __init__(self, train_x, train_y, test_x, test_y, dict_size=5000,
                 example_length=150, embedding_length=32, epoches=5, batch_size=128):
        '''
        initialize RNN model
        :param train_x: training data
        :param train_y: training label
        :param test_x: test data
        :param test_y: test label
        :param epoches: number of ephoches to run
        :param batch_size: batch size in training
        :param embedding_length: size of word embedding
        :param example_length: length of examples
        '''
        self.batch_size = batch_size
        self.epoches = epoches
        self.example_len = example_length
        self.dict_size = dict_size
        self.embedding_len = embedding_length

        # preprocess training data
        tok = Tokenizer(num_words=dict_size)
        tok.fit_on_texts(train_x)
        sequences = tok.texts_to_sequences(train_x)
        self.train_x = sequence.pad_sequences(
            sequences, maxlen=self.example_len)
        sequences = tok.texts_to_sequences(test_x)
        self.test_x = sequence.pad_sequences(
            sequences, maxlen=self.example_len)

        self.train_y = train_y
        self.test_y = test_y

        self.model = Sequential()
        # YOUR CODE HERE
        self.model.add(Embedding(self.dict_size,self.embedding_len,input_length = self.example_len))
        self.model.add(LSTM(self.embedding_len))
        self.model.add(Dense(1,activation="sigmoid"))
        self.model.compile(loss='binary_crossentropy',
                           optimizer='adam', metrics=['accuracy'])

    def train(self, verbose=0):
        '''
        fit in data and train model
        please refer to the fit method in https://keras.io/models/model/#fit
        make sure you use batchsize and epochs appropriately.
        :return: None
        '''
        self.model.fit(self.train_x, self.train_y, batch_size=self.batch_size, epochs=self.epoches)

    def evaluate(self):
        '''
        evaluate trained model
        please refer to the evaluate method in https://keras.io/models/model/#evaluate
        :return: [loss, accuracy]
        '''
        loss, accuracy = self.model.evaluate(self.test_x,self.test_y,batch_size=self.batch_size)
        return loss, accuracy

import pickle
def load_data(location):
    return pickle.load(open(location,'rb'))

train_x, test_x, train_y, test_y = load_data('./data/spam_data.pkl')
rnn = RNN(train_x, train_y, test_x, test_y, epoches=5)
rnn.train(verbose=1)
loss, accuracy = rnn.evaluate()
print('Accuracy for LSTM: ', accuracy)


# Accuracy of LSTM model is: 0.995

# * Change the embedding length and experiment with these values: [8, 16, 32, 48, 64].

RNNs = []
test_accuracy_array = []
for embedding_len in [8, 16, 32, 48, 64]:
    train_x, test_x, train_y, test_y = load_data('./data/spam_data.pkl')
    rnn = RNN(train_x, train_y, test_x, test_y, epoches=5, embedding_length=embedding_len)
    RNNs.append(rnn)
    rnn.train(verbose=1)
    loss, accuracy = rnn.evaluate()
    test_accuracy_array.append(accuracy)
    print('Accuracy for LSTM: ', accuracy)

train_accuracy_matrix = np.array(list(map(lambda x: x.model.history.history["accuracy"], RNNs)))

fig, ax = plt.subplots(nrows=1, ncols=1, figsize=(12,6))
epochs_array = [1.0,2.0,3.0,4.0,5.0]
plt.title("Training accuracies of different embedding lengths vs. epochs")
ax.plot(epochs_array, train_accuracy_matrix[0], color="green", label='8 - embedding length')
ax.plot(epochs_array, train_accuracy_matrix[1], color="red", label='16 -  embedding length')
ax.plot(epochs_array, train_accuracy_matrix[2], color="brown", label='32 - embedding length')
ax.plot(epochs_array, train_accuracy_matrix[3], color="blue", label='48 - embedding length')
ax.plot(epochs_array, train_accuracy_matrix[4], color="black", label='64 - embedding length')

ax.legend(loc="lower right", fontsize=16)
ax.set_xlabel("epochs", fontsize=16)
ax.set_ylabel("training accuracy", fontsize=16)

