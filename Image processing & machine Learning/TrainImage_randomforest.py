
# coding: utf-8

# In[37]:

from numpy.random import choice 
import copy
import gevent 
import datetime 
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

def hog_feature(a,l):
     for g in range(0,len(a)):
            hog_patch=[]
            lab_patch=[]
            hsv_patch=[]
            s=a[g]
            if(x[s]-4<0):
                m=0
            else:
                m=x[s]-4
            if(y[s]-4<0):
                n=0
            else:
                n=y[s]-4
            cenimg=copy(image[m:x[s]+4,n:y[s]+4,:])
            size=cenimg.shape[0]*cenimg.shape[1]*cenimg.shape[2]
            lab=rgb2lab(cenimg)
            lab_patch=ravel(lab,order='C')
            hsv=rgb2hsv(cenimg)
            hsv_patch=ravel(hsv,order='C')
            patch=copy(rgb2grey(cenimg))
            hog_patch=hog(patch,orientations=9,pixels_per_cell=(2,2),cells_per_block=(4,4),block_norm='L2-Hys',feature_vector='True')
            hog_lab=concatenate((hog_patch,lab_patch),axis=0)
            hog_lab_hsv=concatenate((hog_lab,hsv_patch),axis=0)
            array=np.zeros((1,len( hog_lab_hsv)+1))
            array[0,0:len( hog_lab_hsv)]= hog_lab_hsv
            array[0,len( hog_lab_hsv)]=l
            featurewriter.writerows(array)   
            
files=os.listdir("C:\\Users\\Lokin\\Desktop\\TOMTOM\\Images\\HOG feature descriptor images\\HOG feature descriptor images")
label=os.listdir("C:\\Users\\Lokin\\Desktop\\TOMTOM\\Images\\label_images\\label_images")
label_t=[[]]
with open("traindata.csv",'w',newline='') as csvfile:
    featurewriter=csv.writer(csvfile)
    for i in range(0,len(files)):
        img=imread(os.path.join("C:\\Users\\Lokin\\Desktop\\TOMTOM\\Images\\HOG feature descriptor images\\HOG feature descriptor images",files[i]))
        label_img=imread(os.path.join("C:\\Users\\Lokin\\Desktop\\TOMTOM\\Images\\label_images\\label_images",label[i]))
        label_img=rgb2grey(label_img)
        image=(img*255)
        print("label image",i,"shape",label_img.shape)
        print("image",i,"shape:",image.shape)
        plt.imshow(image)
        plt.show()
        image_seg=np.zeros(image.shape)
        image_seg=slic(image_seg,n_segments=30000,sigma=5)
        print("image",i,"segments",np.unique(image_seg))
        x=[]
        y=[]
        roadseg=[]
        nonroadseg=[]
        count_nonroad=0
        count_road=0
        for j in range(0,len(np.unique(image_seg))):
            seg_c=np.where(image_seg==j)
            x.append(np.mean(seg_c[0]))
            y.append(np.mean(seg_c[1]))
            print("image",i,"centroid of segment",j,x[j],y[j])
            x[j]=x[j].astype('int64')
            y[j]=y[j].astype('int64')
            c=label_img[x[j],y[j]]
            label_t.append(label_img[x[j],y[j]]) 
            label_t.append(j)
            if (c==0.0):
                nonroadseg.append(j)
                count_nonroad=count_nonroad+1
                print("segment",j,"centroid is nonroad")
            elif (c==1.0):
                roadseg.append(j)
                count_road=count_road+1
                print("segment",j,"centroid is road")
        print("image",i,"road pixels and nonroadpixels",count_road,count_nonroad)
        if(count_nonroad>2*count_road):
            nonroadseg=choice(nonroadseg,size=2*count_road)
            print("image",i)
            print("number of nonroads and roads",2*count_road,count_road)
            print(i)
            hog_feature(roadseg,1)
            hog_feature(nonroadseg,0)
        else:
            hog_feature(roadseg,1)
            hog_feature(nonroadseg,0)
        print("hog features generated for image",i)
        if(i==2):
            break

import pickle
train_label='C:\\Users\\Lokin\\Desktop\\TOMTOM\\train_label.pkl'
with open(train_label,'wb') as pickle_file:
    pickle.dump(label_t,pickle_file)


# In[60]:

from sklearn.ensemble import RandomForestClassifier
rf_model=RandomForestClassifier(n_estimators=6000,criterion='gini',min_samples_split=2, min_samples_leaf=1,max_features='sqrt',bootstrap='True')

rf_model


# In[39]:

from pandas import read_csv
from numpy import arange
df=read_csv("C://Users//Lokin//Desktop//TOMTOM//traindata.csv",header=None)
df=np.array(df)


# In[61]:

rf_model.fit(df[:,0:528],df[:,528])


# In[62]:

fimp = (rf_model.feature_importances_)
fimp


# In[63]:

import pickle
randomforest='C:\\Users\\Lokin\\Desktop\\TOMTOM\\random.pkl'
ref_label='C:\\Users\\Lokin\\Desktop\\TOMTOM\\reference.pkl'
with open(randomforest, 'wb') as pickle_file:
    pickle.dump(rf_model, pickle_file)
with open(ref_label,'wb') as pickle_file:
    pickle.dump(df[:,528],pickle_file)

