% Image Processing experiment assignment 4 script file.
% Use existing code in this script, and add new code where needed.
% This script is made out of cells. to run a specific cell, click somewhere in it and press CTRL+ENTER.

clear;
close all;
clc;

%% Items 1-4

nrfiltdemo;

%% Item 5

im1 = imread('cameraman.tif');
im2 = imread('cam_blur.tif');
figure(1); 
subplot(221); imshow(im1); title('Cameraman');
subplot(223); imshow(im2); title('Cam Blur');

H = fspecial('motion',7,0);
MotionBlur = imfilter(im1,H,'replicate');
subplot(222); imshow(im1); title('Cameraman');
subplot(224); imshow(MotionBlur); title('Motion Blur');

%% Item 6

im1 = imread('cameraman.tif');
figure(1); 
subplot(131); imshow(im1); title('Cameraman');

H = fspecial('motion',7,0);
MotionBlur = imfilter(im1,H,'replicate');
subplot(132); imshow(MotionBlur); title('Motion Blur');

J = deconvlucy(MotionBlur,H,7)
subplot(133); imshow(J); title('deconvlucy filter');

