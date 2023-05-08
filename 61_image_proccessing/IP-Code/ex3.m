% Image Processing experiment assignment 3 script file.
% Use existing code in this script, and add new code where needed.
% This script is made out of cells. to run a specific cell, click somewhere in it and press CTRL+ENTER.

clear;
close all;
clc;

%% Item 1

im = imread('rice.png');
% Insert your code here
% Display histograms similarly to previous exercises

%% Item 2

% Change code here
Thresh = [];

bw = im>Thresh;
Percent = 100*nnz(bw)/numel(bw);
figure(2); imshow(bw,[]); title(['Threshold = ',num2str(Thresh),', Percent = ',num2str(round(Percent,2)),'%']);
% Insert your code here

%% Item 3

% Insert your code here

%% Item 4

CC = bwconncomp(pbw);
labels = labelmatrix(CC);
cmap = rand(1000,3);
figure(100); set(gcf,'WindowState','maximized'); 
subplot(121); imshow(labels,[]); title('Before Coloring');
subplot(122); imshow(labels,cmap); title('After Coloring');