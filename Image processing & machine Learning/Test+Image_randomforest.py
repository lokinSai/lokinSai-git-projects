
# coding: utf-8

# In[105]:

from numpy.random import choice 
import copy
from skimage.feature import hog
from skimage.segmentation import slic
from skimage.color import rgb2grey
from skimage.color import rgb2lab
from skimage.color import rgb2hsv
from numpy import ravel
from skimage.io import imread
import numpy as np
from numpy import concatenate
from copy import copy
from matplotlib import pyplot as plt
import cv2 
import os
import csv
def hog_feature_test(c,d,j):
    hog_patch=[]
    if(c-4<0):
        m=0
    else:
        m=c-4
    if(d-4<0):
        n=0
    else:
        n=d-4
    cenimg_t=copy(image_t[m:c+4,n:d+4,:])
    size=cenimg_t.shape[0]*cenimg_t.shape[1]*cenimg_t.shape[2]
    lab_t=rgb2lab(cenimg_t)
    lab_patch_t=ravel(lab_t,order='C')
    hsv_t=rgb2hsv(cenimg_t)
    hsv_patch_t=ravel(hsv_t,order='C')
    patch_t=copy(rgb2grey(cenimg_t))
    hog_patch_t=hog(patch_t,orientations=9,pixels_per_cell=(2,2),cells_per_block=(4,4),block_norm='L2-Hys',feature_vector='True')
    hog_lab_t=concatenate((hog_patch_t,lab_patch_t),axis=0)
    hog_lab_hsv_t=concatenate((hog_lab_t,hsv_patch_t),axis=0)
    array=np.zeros((1,len( hog_lab_hsv_t)+1))
    array[0,0:len( hog_lab_hsv_t)]= hog_lab_hsv_t
    array[0,len( hog_lab_hsv_t)]=j
    featurewriter.writerows(array)   
    
files=os.listdir("C://Users//Lokin//Desktop//TOMTOM//Images//HOG feature descriptor test//HOG feature descriptor test")
with open('testdata.csv','w',newline='')as csvfile:
        featurewriter=csv.writer(csvfile)
        for i in range(0,len(files)):
            img_t=imread(os.path.join("C://Users//Lokin//Desktop//TOMTOM//Images//HOG feature descriptor test//HOG feature descriptor test",files[i]))
            image_t=(img_t*255)
            #print("label image",i,"shape",label_img.shape)
            print("test image",i,"shape:",image_t.shape)
            plt.imshow(image_t)
            plt.show()
            image_seg_t=np.zeros(image_t.shape)
            image_seg_t=slic(image_seg_t,n_segments=30000,sigma=5)
            print("test image",i,"segments",np.unique(image_seg_t))
            x_t=[]
            y_t=[]
            for j in range(0,len(np.unique(image_seg_t))):
                seg_c_t=np.where(image_seg_t==j)
                x_t.append(np.mean(seg_c_t[0]))
                y_t.append(np.mean(seg_c_t[1]))
                print("test image",i,"centroid of segment",j,x_t[j],y_t[j])
                x_t[j]=x_t[j].astype('int64')
                y_t[j]=y_t[j].astype('int64')
                c=x_t[j]
                d=y_t[j]
                hog_feature_test(c,d,j)

            print("hog features generated for test image",i)
            if(i==0):
                break


# In[113]:

from pandas import read_csv
test=read_csv("C://Users//Lokin//Desktop//TOMTOM//testdata.csv",header=None)
test
test=np.array(test)
test.shape


# In[114]:

import pickle 
p_file=open("C:\\Users\\Lokin\\Desktop\\TOMTOM\\random.pkl",'rb')
rf_model_pk=pickle.load(p_file)

reference=open("C:\\Users\\Lokin\\Desktop\\TOMTOM\\reference.pkl",'rb')
reference_label_pk=pickle.load(reference)

label_t=open("C:\\Users\\Lokin\\Desktop\\TOMTOM\\train_label.pkl",'rb')
label_t_pk=pickle.load(label_t)


# In[115]:

rf_model_pk


# In[93]:

test[:,0:528].shape


# In[116]:

pred_label=rf_model_pk.predict(test[:,0:528])
sum(pred_label)


# In[110]:

len(pred_label)


# In[11]:

# import numpy
# label_t_pk=numpy.array(label_t_pk)
# print(label_t_pk)


# In[117]:

from numpy import concatenate
import pandas as pd
test_img_seg=test[:,528].astype('int64')
pred_label=pred_label.astype('int64')
test_img_seg
pred_label
seg_pred= pd.DataFrame({'test_img_seg': test_img_seg, 'pred_label': pred_label})
visual=np.zeros((2560,2560))
for i in range(0,len(test_img_seg)):
    print(i)
    cor=np.where(image_seg_t==i)
    if pred_label[i]==0:
        visual[cor[0],cor[1]]=0
    else:
        visual[cor[0],cor[1]]=1
plt.imshow(visual,'gray')
plt.show()


# In[118]:

from skimage.io import imsave
imsave("rf_6000_162.jpg",visual)

