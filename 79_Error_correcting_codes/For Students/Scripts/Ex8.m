im = imread('NY.gif'); figure(); imshow(im,[]);
%% 
msg = im2bit(im); 
imHeight = size(im,1); imRe = bit2im(msg,imHeight);
%%
CI = imCompress(im);
figure(); imshow(imDecompress(CI.data,CI.height,CI.dict),[]);
