import math
import pickle
import gzip
import numpy as np
import pandas
import matplotlib.pylab as plt
get_ipython().run_line_magic('matplotlib', 'inline')
from time import time
from sklearn.metrics import explained_variance_score, precision_score
import pandas as pd


class EnsembleTest:
    """
        Test multiple model performance
    """

    def __init__(self, X_train, y_train, X_test, y_test, type='regression'):
        """
        initialize data and type of problem
        :param X_train:
        :param y_train:
        :param X_test:
        :param y_test:
        :param type: regression or classification
        """
        self.scores = {}
        self.execution_time = {}
        self.metric = {}
        self.X_train = X_train
        self.y_train = y_train
        self.X_test = X_test
        self.y_test = y_test
        self.type = type
        self.score_name = 'R^2 score' if self.type == 'regression' else 'Mean accuracy score'
        self.metric_name = 'Explained variance' if self.type == 'regression' else 'Precision'

    def fit_model(self, model, name):
        """
        Fit the model on train data.
        predict on test and store score and execution time for each fit.
        :param model: model
        :param name: name of model
        """
        # YOUR CODE HERE
        start = time()
        model.fit(self.X_train, self.y_train)
        end = time()
        predict = model.predict(self.X_test)
        self.scores[name] = model.score(self.X_test,self.y_test)
        self.execution_time[name] = end - start
        #raise NotImplementedError()
        
        if self.type == 'regression':
            self.metric[name] = explained_variance_score(predict, self.y_test)
        elif self.type == 'classification':
            self.metric[name] = precision_score(predict, y_test)

    def print_result(self):
        """
            print results for all models trained and tested.
        """
        models_cross = pd.DataFrame({
            'Model'         : list(self.metric.keys()),
             self.score_name     : list(self.scores.values()),
             self.metric_name    : list(self.metric.values()),
            'Execution time': list(self.execution_time.values())})
        print(models_cross.sort_values(by=self.score_name, ascending=False))

    def plot_metric(self):
        """
         plot each metric : time, metric score,scores
        """
        models_cross = pd.DataFrame({
            'Model'         : list(self.metric.keys()),
             self.score_name     : list(self.scores.values()),
             self.metric_name    : list(self.metric.values()),
            'Execution time': list(self.execution_time.values())})
        models_cross.set_index('Model',inplace=True)
        models_cross.plot.bar(subplots=True,figsize=(9,9),title="plot metrics")


X_train, X_test, y_train, y_test = pickle.load(open('./data/house_predictions/test_train.pkl','rb'))

# create a handler for ensemble_test, use the created handler for fitting different models.
ensemble_handler = EnsembleTest(X_train,y_train,X_test,y_test,type='regression')
from sklearn.tree import DecisionTreeRegressor
decision=DecisionTreeRegressor()
ensemble_handler.fit_model(decision,'decision_tree')


from sklearn.ensemble import RandomForestRegressor

#ensemble_handler_rfr = EnsembleTest(X_train,y_train,X_test,y_test,type='regression')
randomforest=RandomForestRegressor(n_estimators=1000)
ensemble_handler.fit_model(randomforest,'random_forest')


from sklearn.ensemble import AdaBoostRegressor

# YOUR CODE HERE
#ensemble_handler_adb = EnsembleTest(X_train,y_train,X_test,y_test,type='regression')
adaboost=AdaBoostRegressor(n_estimators=1000)
ensemble_handler.fit_model(adaboost,'adam_boost')


import nltk
from nltk.corpus import stopwords
from nltk.tokenize import TweetTokenizer
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.pipeline import make_pipeline, Pipeline
from sklearn.model_selection import StratifiedKFold


reviews  = pd.read_csv('./data/reviews.csv')
train, test = train_test_split(reviews, test_size=0.2, random_state=4622)
X_train = train['reviews'].values
X_test = test['reviews'].values
y_train = train['sentiment']
y_test = test['sentiment']


# Define tokenizer and create pipeline.
def tokenize(text): 
    tknzr = TweetTokenizer()
    return tknzr.tokenize(text)
en_stopwords = set(stopwords.words("english")) 
vectorizer = CountVectorizer(
    analyzer = 'word',
    tokenizer = tokenize,
    lowercase = True,
    ngram_range=(1, 2),
    stop_words = en_stopwords,
    min_df=10)

# create a handler for ensemble_test , use the created handler for fitting different models.
ensemble_classifier_handler = EnsembleTest(X_train,y_train,X_test,y_test,type='classification')

from sklearn.tree import DecisionTreeClassifier
pipeline_decision_tree = make_pipeline(vectorizer, DecisionTreeClassifier())
ensemble_classifier_handler.fit_model(pipeline_decision_tree,'decision tree classifier')

from sklearn.ensemble import RandomForestClassifier
pipeline_random_forest = make_pipeline(vectorizer, RandomForestClassifier(n_estimators=500))
ensemble_classifier_handler.fit_model(pipeline_random_forest,'random forest classifier')

from sklearn.ensemble import AdaBoostClassifier
pipeline_ada_boost = make_pipeline(vectorizer, AdaBoostClassifier(n_estimators=500))
ensemble_classifier_handler.fit_model(pipeline_ada_boost,'adam boost classifier')
