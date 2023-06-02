% Image Processing experiment assignment 3 script file.
% Use existing code in this script, and add new code where needed.
% This script is made out of cells. to run a specific cell, click somewhere in it and press CTRL+ENTER.

clear;
close all;
clc;

%% Item 1

im = imread('rice.png');
figure(1); 
subplot(211); imshow(im); title('Rice');
subplot(212); bar(imhist(im));

%% Item 2

% Change code here
Thresh = [90];

bw = im>Thresh;
Percent = 100*nnz(bw)/numel(bw);
figure(2);
imshow(bw,[]); title(['Threshold = ',num2str(Thresh),', Percent = ',num2str(round(Percent,2)),'%']);
%subplot(212); bar(imhist(bw));

%% Item 3

im = imread('pieces.png');
figure(1); 
subplot(211); imshow(im); title('Rice');

Thresh = [200];
bw = im<Thresh;
Percent = 100*nnz(bw)/numel(bw);
subplot(212); imshow(bw,[]); title(['Threshold = ',num2str(Thresh),', Percent = ',num2str(round(Percent,2)),'%']);

%% Item 4

CC = bwconncomp(bw);
labels = labelmatrix(CC);
cmap = rand(1000,3);
figure(100); set(gcf,'WindowState','maximized'); 
subplot(121); imshow(labels,[]); title('Before Coloring');
subplot(122); imshow(labels,cmap); title('After Coloring');