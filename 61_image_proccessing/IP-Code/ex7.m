% Image Processing experiment assignment 7 script file.
% Use existing code in this script, and add new code where needed.
% This script is made out of cells. to run a specific cell, click somewhere in it and press CTRL+ENTER.

clear;
close all;
clc;

%% Item 1

p1 = zeros(5); p1(2:4,3) = ones(3,1); 
SE1 = strel('arbitrary',[1 1 1]);
SE2 = strel('arbitrary',[1 1 1]');

dilate1 = imdilate(p1,SE1);
dilate2 = imdilate(p1,SE2);

% Print table to screen
T7a = PrintTable('Question 7a Results');
T7a.HasHeader = true;
T7a.addRow('Original Patch','Dilation with SE1','Dilation with SE2');
T7a.addRows(num2str(p1),[num2str(dilate1) repmat(' ',5,2)],num2str(dilate2));
disp(T7a);

%% Item 2

p2 = zeros(6); p2(2:5,2:5) = ones(4);
SE3 = strel('square',3);
SE4 = strel('pair', [2 2]);

erode1 = imerode(p2,SE3);
erode2 = imerode(p2,SE4);

% Print table to screen
T7b = PrintTable('Question 7b Results');
T7b.HasHeader = true;
T7b.addRow('Original Patch  ','Erosion with SE3','Erosion with SE4');
T7b.addRows(num2str(p2),num2str(erode1),num2str(erode2));
disp(T7b);

%% Item 3

im1 = imread('shapes.jpg');

% Change disk size here (the second argument)
SE5 = strel('disk',[],8);               

eroded = imerode(im1,SE5); 
final = imdilate(eroded,SE5);

figure(1); set(gcf,'WindowState','maximized');
subplot(221); imshow(im1,[]); title('Original Image');
subplot(223); imshow(eroded,[]); title('Eroded Image');
subplot(224); imshow(final,[]); title('Circles');

%% Item 4

% Insert your code here

%% Item 5

im2 = imread('rice.png');
% Insert your code here

%% Item 6

% Insert your code here
% Display histograms similarly to previous sections

% Change code here
Lower = [];                          
Upper = [];                          

bw_modified=bwpropfilt(bw,'Area',[Lower Upper]);
CC = bwconncomp(bw_modified);
fprintf('\nThe number of rice grains in the image is %d.\n',CC.NumObjects);
riceArea = nnz(bw_modified)/CC.NumObjects;
fprintf('The average area of a rice grain in the image is %5g pixels.\n',riceArea);