import math
import pickle
import gzip
import numpy as np
import pandas
import matplotlib.pylab as plt
get_ipython().run_line_magic('matplotlib', 'inline')
import pandas as pd
from sklearn.model_selection import train_test_split, StratifiedKFold

reviews  = pd.read_csv('./data/reviews.csv')
train, test = train_test_split(reviews, test_size=0.2, random_state=5622)
X_train = train['reviews']
X_test = test['reviews']
y_train = train['sentiment']
y_test = test['sentiment']


import nltk
from nltk.corpus import stopwords
from nltk.tokenize import TweetTokenizer
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.svm import SVC
from sklearn.pipeline import make_pipeline, Pipeline
from sklearn.model_selection import GridSearchCV, RandomizedSearchCV
from sklearn.metrics import accuracy_score, f1_score
from sklearn.metrics import confusion_matrix, roc_auc_score, recall_score, precision_score

 
# `CountVectorizer` to vectorize reviews as dictionary of term frequencies.
# Define the crossvalidation split using `StratifiedKFold`.


def tokenize(text): 
    tknzr = TweetTokenizer()
    return tknzr.tokenize(text)

nltk.download('stopwords')
en_stopwords = set(stopwords.words("english")) 

indices_X_trian = list(X_train.index)
corpus_X_train = [X_train[idx] for idx in indices_X_trian]

vectorizer = CountVectorizer(tokenizer=tokenize,stop_words=en_stopwords,min_df=6)
X = vectorizer.fit_transform(X_train)
# CREATE CountVectorizer using sklearn.feature_extraction.text.CountVectorizer

# split dataset using StratifiedKFold into 5 splits using sklearn.model_selection.StratifiedKFold.
skf = StratifiedKFold(n_splits=5)


# * pipeline with our `CountVectorizer` object 
# * Create and fit a `GridSearchCV` object with the following parameter values:
#   * Linear kernel, $C = 0.01, 1.0, 10.0$
#   * Polynomial kernel, $\text{degree} = 2, 3$, $\gamma = 0.1, 0.5, 1$
#   * RBF kernel, $\gamma = 0.1, 0.5, 1$
# * Report accuracy on the best estimator from our `GridSearchCV` object.

np.random.seed(5622)
svm_model = SVC(gamma = 'auto')
pipeline_flow = Pipeline([('vectorizer', vectorizer), ('svm_model', svm_model)])

# Create GridSearchCV with pipeline and the grid search parameters given above,
# using "accuracy" for scoring.

parameter_grid = [{'svm_model__C': [0.01,1.0,10.0],
                   'svm_model__kernel':['linear']},
                  {'svm_model__degree':[2,3],
                   'svm_model__gamma':[0.1,0.5,1],
                   'svm_model__kernel':['poly']},
                  {'svm_model__gamma':[0.1,0.5,1],
                   'svm_model__kernel':['rbf']}]
grid_search_svm = GridSearchCV(pipeline_flow, parameter_grid)

_ = grid_search_svm.fit(X_train, y_train)


# Report best parameters and CV score from grid search
print("grid svm best score",grid_search_svm.best_score_)
print("grid svm best parameters",grid_search_svm.best_params_)


# Choose the best performing kernel and parameter values from your coarse scale grid search and use them to set up a narrower range of parameter values. We will use randomized grid search to sample a fixed number of these candidate parameter sets for cross validation. The number of sampled parameter sets `n_iter` provides a trade-off between computational cost and quality of the "optimal" parameters. Feel free to experiment with different values of this parameter, but please change it back to `n_iter = 5` before submitting your assignment.

# Set random seed for deterministic output
np.random.seed(5622)

pipeline_svm = Pipeline([('vectorizer', vectorizer), ('svm_model', svm_model)])
parameter_grid = {'svm_model__C': [0.005,0.008,0.01,0.012,0.015],
                  'svm_model__kernel':['linear']}

kfolds = skf
n_iter = 5
random_svm = RandomizedSearchCV(pipeline_svm,
                                parameter_grid,
                                n_iter=n_iter,
                                cv = kfolds,
                                scoring="accuracy",
                                verbose=1,   
                                n_jobs=-1)

_ = random_svm.fit(X_train, y_train)

# Report best parameters and CV score from grid search
print(random_svm.best_params_ )
print(random_svm.best_estimator_ )
print(random_svm.cv_results_)


def report_results(model, X, y):
    pred = model.predict(X)        
    acc = accuracy_score(y, pred)
    f1 = f1_score(y, pred)
    prec = precision_score(y, pred)
    rec = recall_score(y, pred)
    result = {'f1': f1, 'acc': acc, 'precision': prec, 'recall': rec}
    return result

report_results(random_svm.best_estimator_, X_test, y_test)


# f1-score: 0.876,<br>
# accuracy: 0.874, <br>
# precision: 0.869,<br>
# recall: 0.883





