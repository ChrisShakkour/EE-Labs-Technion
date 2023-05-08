% Image Processing experiment assignment 1 script file.
% Use existing code in this script, and add new code where needed.
% This script is made out of cells. to run a specific cell, click somewhere in it and press CTRL+ENTER.

clear;
close all;
clc;

%% Item 1

im = imread('toucan.tif');
figure(1); imshow(im); title('Toucan');
imfinfo('toucan.tif')

%% Item 2

% Insert your code here

%% Item 3

% Insert your code here

%% Item 4

% Insert your code here

%% Item 5

figure(3); set(gcf,'WindowState','maximized');
subplot(121); bar(imhist(im));
ylim([0 3000]); title('Toucan Histogram');

% Change code here
std_n = [];							               

noise = std_n*randn(size(im));  
im_n = uint8(double(im)+noise);
figure(2); imshow(im_n); title('Noisy Toucan');
figure(3); 
subplot(122); bar(imhist(im_n));
ylim([0 3000]); title('Noisy Toucan Histogram');

%% Item 6

wh = imread('whitehouse.tif');
figure(5); imshow(wh); title('White House');
% Insert your code here