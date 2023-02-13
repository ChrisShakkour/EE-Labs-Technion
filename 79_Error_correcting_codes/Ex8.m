clc
clear
close all

addpath('Users/lareine.at/Downloads/ECC lab/For Students/Functions/');
%% Section 1
%##################################
im = imread('NY.gif'); figure(); imshow(im,[]);
msg = im2bit(im); 

%% Section 2
%##################################
imHeight = size(im,1); imRe = bit2im(msg,imHeight);
figure(2); imshow(imRe);

%% Section 3
%##################################
[data, err] = bsc(msg, 1e-4); 
imNoise = bit2im(data,imHeight);
figure(3); imshow(imNoise);

%% Section 4
%##################################
CI = imCompress(im);
figure (4); imshow(imDecompress(CI.data , CI.height , CI.dict ) ,[]);
whos CI;

%% Section 5
%##################################
p2 = 1e-4;
msg2 = CI.data;
msg2Noise = bsc (msg2,p2);
figure (5); imshow(imDecompress(msg2Noise,CI.height,CI.dict),[]);

%% Section 6
%##################################
m = 4; n = (2^m) -1; 
bchNumErr = bchnumerr(n);

%% Section 7
%##################################
im = imread('NY.gif');
msg = im2bit(im); 

CI = imCompress(im);
msg_zip = CI.data;
length = numel(msg_zip);

%encoding
m = 7; n = (2^m) -1; k = 106 ;  
bchEncoder = comm.BCHEncoder(n,k);
num_of_zeros = mod(length,k);
vec_zeros = zeros(1,k-num_of_zeros);
msg = [msg_zip;vec_zeros'];
mat = reshape (msg,k,[]);
col = size(mat,2);
im = imread('NY.gif');

CI = imCompress(im);
msg_zip = CI.data;
length = numel(msg_zip);

%encoding
m = 8; n = 2^m -1; k = 215 ;  
bchEncoder = comm.BCHEncoder(n,k);
num_of_zeros = mod(length,k);
vec_zeros = zeros(1,k-num_of_zeros);
msg = [msg_zip;vec_zeros'];
mat = reshape (msg,k,[]);
col = size(mat,2);


for i=1:col
    enc_mat(:,i) = bchEncoder ( mat(:,i) );
end

%noising
p = 10^-4;
msg_noise = bsc (enc_mat,p);

%decoding
bchDecoder = comm.BCHDecoder(n,k);
for i=1:col
    dec_mat(:,i) = bchDecoder ( enc_mat(:,i) );
end

dec_vec = dec_mat(:);
src_msg = dec_vec(1:length);
figure (7); imshow(imDecompress(src_msg,CI.height,CI.dict),[]);
