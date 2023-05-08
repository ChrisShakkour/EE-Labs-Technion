% Image Processing experiment assignment 9 script file.
% Use existing code in this script, and add new code where needed.
% This script is made out of cells. to run a specific cell, click somewhere in it and press CTRL+ENTER.

clear;
close all;
clc;

%% Item 1

im = imread('objects.bmp');
figure(1); imshow(im); title('Objects');

%% Item 2

stats = regionprops(im,'all');
% Insert you code here

%% Item 3

f1 = [stats.MajorAxisLength];
f2 = [stats.ConvexArea];
figure(2); plot(f1,f2,'o');
title('Features 1');
xlabel('Major Axis Length');
ylabel('Convex Area');

%% Item 4

% Insert your code here 
