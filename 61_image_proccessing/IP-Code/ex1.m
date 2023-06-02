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

minval=min(min(im))
maxval=max(max(im))
meanval=mean(mean(im))

%% Item 3

sum(sum(im==18))

%% Item 4

L=im(170,:)
plot(L)

%% Item 5

figure(3); set(gcf,'WindowState','maximized');
subplot(121); bar(imhist(im));
ylim([0 3000]); title('Toucan Histogram');

% Change code here
std_n = [15];							               

noise = std_n*randn(size(im));  
im_n = uint8(double(im)+noise);
figure(2); imshow(im_n); title('Noisy Toucan');
figure(3); 
subplot(122); bar(imhist(im_n));
ylim([0 3000]); title('Noisy Toucan Histogram');

%% Item 6

wh = imread('whitehouse.tif');
figure(5); imshow(wh); title('White House');
wh(wh>225)=0
figure(6); imshow(wh); title('Black House');

% Insert your code here