
#!/user/bin/env python
from numpy.random import choice 
import copy
from skimage.feature import hog
from skimage.segmentation import slic
from skimage.color import rgb2grey
from skimage.io import imread
import numpy as np
from numpy import concatenate
from copy import copy
#from matplotlib import pyplot as plt
import cv2 
import os
import csv
def hog_feature_test(c,d):
    hog_patch=[]
    if(c-4<0):
        m=0
    else:
        m=c-4
    if(d-4<0):
        n=0
    else:
        n=d-4
    patch=copy(rgb2grey(image_t[m:c+4,n:d+4,:]))
    hog_patch=hog(patch,orientations=9,pixels_per_cell=(2,2),cells_per_block=(4,4),block_norm='L2-Hys',feature_vector='True')
    return hog_patch           
files=os.listdir("HOG_feature_descriptor_test")
with open('testdata.csv','w')as csvfile:
        featurewriter=csv.writer(csvfile)
        for i in range(0,len(files)):
            img_t=imread(os.path.join("HOG_feature_descriptor_test",files[i]))
            image_t=(img_t*255)
            #print("label image",i,"shape",label_img.shape)
            print "test image",i,"shape:",image_t.shape
           # plt.imshow(image_t)
           # plt.show()
            image_seg_t=np.zeros(image_t.shape)
            image_seg_t=slic(image_seg_t,n_segments=30000,sigma=5)
            print "test image",i,"segments",np.unique(image_seg_t)
            x_t=[]
            y_t=[]
            for j in range(0,len(np.unique(image_seg_t))):
                seg_c_t=np.where(image_seg_t==j)
                x_t.append(np.mean(seg_c_t[0]))
                y_t.append(np.mean(seg_c_t[1]))
                print "test image",i,"centroid of segment",j,x_t[j],y_t[j]
                x_t[j]=x_t[j].astype('int64')
                y_t[j]=y_t[j].astype('int64')
                c=x_t[j]
                d=y_t[j]
                hog_p_t=[]
                row=[]
                hog_p_t=hog_feature_test(c,d)
                print len(hog_p_t)
                row_t=[hog_p_t]
                featurewriter.writerows(np.array(row_t))

            print "hog features generated for test image",i
