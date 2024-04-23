import os

import pandas as pd

import streamlit as st
from streamlit.components.v1 import html
#from st_keyup import st_keyup
import cv2 # opencv library
import numpy
from matplotlib import pyplot as plt


st.set_page_config(layout="wide")
if "image_file_name" not in st.session_state:
        st.session_state["image_file_name"] = ""

# Create tabs
tabs = ["Image Morphology", "Image Gamma correction"]
img = None
with st.sidebar:
    st.title("Image")
    
    st.subheader("Upload an image!")
    uploadedfile = st.file_uploader(label="Upload Image")
    st.session_state["image_file_name"] = uploadedfile.name
    if uploadedfile:
        with open(uploadedfile.name,"wb") as f:
            f.write(uploadedfile.getbuffer())

    if st.session_state["image_file_name"]:
        img = cv2.imread(st.session_state["image_file_name"])
        img = img[:, :, ::-1]
    
    selected_tab = st.radio("Select a tab", tabs)

if selected_tab == "Image Morphology":
    morph = st.radio("Morphology", ['erosion', 'dilation'])
    if morph == 'erosion':
        f, axs = plt.subplots(1, 2, figsize=(15, 10))
        axs[0].set_title('intensity > 128')
        axs[0].imshow(img, cmap='gray')

        kernel = numpy.full((3, 3), 1)
        er = cv2.erode(img, kernel, 1)
        axs[1].set_title('after erosion')
        axs[1].imshow(er, cmap='gray');
        st.pyplot(f)
        
    if morph == 'dilation':
        f, axs = plt.subplots(1, 2, figsize=(15, 10))

        axs[0].set_title('intensity > 128')
        axs[0].imshow(img, cmap='gray')

        kernel = numpy.full((3, 3), 1)
        dil = cv2.dilate(img, kernel, 1)
        axs[1].set_title('after dilation')
        axs[1].imshow(dil, cmap='gray');
        st.pyplot(f)
    
if selected_tab == "Image Gamma correction":
    f, axs = plt.subplots(1, 2, figsize=(15, 10))
    gamma_slider = st.slider("Gamma", 0.1, 2.0, 1.0, 0.1)
    st.write(gamma_slider)
    gg = numpy.uint8(256 * (img / 256)**gamma_slider)
    axs[0].imshow(gg)

    hist, bins = numpy.histogram(img, bins = 100, range = (0, 255))
    axs[1].plot(bins[:-1], hist, '-k')
    axs[1].set_xlabel('Intensity')
    axs[1].set_ylabel('Frequency')
    axs[1].grid();
    st.pyplot(f)