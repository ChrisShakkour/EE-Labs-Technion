% Image Processing experiment assignment 5 script file.
% Use existing code in this script, and add new code where needed.
% This script is made out of cells. to run a specific cell, click somewhere in it and press CTRL+ENTER.

clear;
close all;
clc;

%% Load image

br = imread('barbara.tif');

%% Item 1

figure(1); set(gcf,'WindowState','maximized');
subplot(121); imshow(br); title('Barbara');
subplot(122); histogram(br(:)); title('Barbara Histogram');

N = 16;
levels = linspace(0,256,N+1);
values = levels(1:end-1)+(128/N);
br_qu=uint8(imquantize(br,levels(2:end-1),values));
figure(2); set(gcf,'WindowState','maximized');
subplot(121); imshow(br_qu); title(['Barbara uniformly quantized to N=',num2str(N),' levels']);
subplot(122); histogram(br_qu(:)); title(['Histogram of Barbara uniformly quantized to N=',num2str(N),' levels']);
% Insert your code here

%% Item 2

N = 16;
[levels,values] = lloyds(double(br(:)),N);
br_qo = uint8(imquantize(br,levels,values));
figure(20); set(gcf,'WindowState','maximized');
subplot(121); imshow(br_qo); title(['Barbara optimaly quantized to N=',num2str(N),' levels']);
subplot(122); histogram(br_qo(:)); title(['Histogram of Barbara optimaly quantized to N=',num2str(N),' levels']);
% Insert your code here

%% Item 3

% Show original blocks
figure(40); set(gcf,'WindowState','maximized');
coord1 = [179 6 15 15];
b1 = imcrop(br,coord1);
subplot(231); imshow(b1); title('Block 1');
% Insert your code here

% Show DCT blocks
b1_dct = dct2(b1);
subplot(234); imshow(sqrt(abs(b1_dct)),[0 50]); title('DCT of Block 1');
% Insert your code here

%% Item 4

br_dct_b = blockproc(br,[8 8],@(block_struct)dct2(block_struct.data));
br_abs_dct_b = abs(br_dct_b);
figure; imshow(br_abs_dct_b,[]); title('DCT of all blocks'); impixelinfo;
% Insert your code here

%% Item 5

br_dct_b(br_abs_dct_b<10) = 0;
br_r = uint8(blockproc(br_dct_b,[8 8],@(block_struct)idct2(block_struct.data)));

% Insert your code here

figure(100); set(gcf,'WindowState','maximized');
subplot(121); imshow(br,[]); ax1 = gca; title('Original Image');
subplot(122); imshow(br_r,[]); ax2 = gca; title(['Restored Image, MSE = ',num2str(br_r_mse)]);
linkaxes([ax1,ax2],'xy');