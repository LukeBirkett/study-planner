import random 
from nltk.corpus import stopwords
from nltk.classify.api import ClassifierI
from nltk.probability import FreqDist
import nltk

nltk.download('stopwords')

stop = stopwords.words('english')


def split_data(data, ratio=0.7): # when the second argument is not given, it defaults to 0.7
    """
    Given collection of items and ratio:
     - partitions the collection into training and testing, where the proportion in training is ratio,

    :param data: A list (or generator) of documents or doc ids
    :param ratio: The proportion of training documents (default 0.7)
    :return: a pair (tuple) of lists where the first element of the 
            pair is a list of the training data and the second is a list of the test data.
    """
    
    n = len(data)  #Found out number of samples present.  data could be a list or a generator
    train_indices = random.sample(range(n), int(n * ratio))          #Randomly select training indices
    test_indices = list(set(range(n)) - set(train_indices))   #Other items are testing indices
 
    train = [data[i] for i in train_indices]           #Use training indices to select data
    test = [data[i] for i in test_indices]             #Use testing indices to select data
 
    return (train, test)                       #Return split data
 

#add your normalise function here
def normalise(wordlist):
    ###add code here
    filtered=wordlist
    return filtered

#add your functions for finding most_frequent_words and above_threshold_words
def most_frequent_words(posfreq,negfreq,topk):
    ### add code
    return []

def above_threshold(posfreq,negfreq,threshold):
   ###add code
    return []

class SimpleClassifier(ClassifierI): 

    def __init__(self, pos, neg): 
        self._pos = pos 
        self._neg = neg 

    def classify(self, doc): 
        #doc is a FreqDist
        score = 0
        
        # add code here that assigns an appropriate value to score
        
        
        return "neg" if score < 0 else "pos" 

     
    ##we don't actually need to define the classify_many method as it is provided in ClassifierI
    #def classify_many(self, docs): 
    #    return [self.classify(doc) for doc in docs] 

    def labels(self): 
        return ("pos", "neg")

## put your extended SimpleClassifier classes here
class SimpleClassifier_mf(SimpleClassifier):
    
    def __init__(self,k):
        self._k=k
        self._pos=[]
        self._neg=[]
    
    ###add code for training this classifier - it needs to set self._pos and self._neg
    
class SimpleClassifier_ot(SimpleClassifier):
    
    def __init__(self,k):
        self._k=k
        self._pos=[]
        self._neg=[]
        
    ###add code for training this classifier - it needs to set self._pos and self._neg
    
    