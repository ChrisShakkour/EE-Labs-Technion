clc
clear
close all

load('For Students/Data/Variables.mat');
addpath('For Students/Functions/');
%% Section 1
%##################################
n = 7; Codebook = {
    [1,0,1,1,0,0,1],...% 00
    [1,1,0,0,1,1,0],...% 01
    [1,1,1,0,1,1,0],...% 10
    [0,0,1,1,1,0,1]}; % 11
M = numel(Codebook);

msg = [0 1]; msgEnc = Codebook{bi2de(msg,'left-msb')+1};

msgNoisy = msgEnc; msgNoisy(3)= 1-msgNoisy(3);
dBest = n;
for mm = 1:M
    if(n*pdist2(Codebook{mm},msgNoisy,'hamming')< dBest)
        mBest = mm; dBest = n*pdist2(Codebook{mm},msgNoisy,'hamming');
    end
end
msgDec = de2bi(mBest-1,2,'left-msb')

%% Section 2
%##################################
dmin = n;
for i =1:(M-1)
    for j=(i+1): M
        if(n*pdist2(Codebook{i},Codebook{j},'hamming')<dmin)
            dmin = n*pdist2(Codebook{i},Codebook{j},'hamming');
        end
    end
end

%% Section 3
%##################################
n = 7; Codebook = {
    [0,1,0,1,0,1,0],...% 00
    [0,0,0,0,0,0,0],...% 01
    [1,1,1,1,1,1,1],...% 10
    [1,0,1,0,1,0,1]};  % 11
M = numel(Codebook);

msg = [0 1]
msgEnc = Codebook{bi2de(msg,'left-msb')+1};

msgNoisy = msgEnc; msgNoisy(3)= 1-msgNoisy(3);
dBest = n;
for mm = 1:M
    if(n*pdist2(Codebook{mm},msgNoisy,'hamming')< dBest)
        mBest = mm; dBest = n*pdist2(Codebook{mm},msgNoisy,'hamming');
    end
end
msgDec = de2bi(mBest-1,2,'left-msb')

%% Section 4
%##################################
n_new = 15; Codebook_new = {
    [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],...% 01
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],...% 00
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],...% 11
    [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1]}   % 10
M = numel(Codebook_new);

%% Section 5
%##################################
msg = str2bit('EE:)'); msgSize = length(msg); 
n = 15; k = 5; bchEncoder = comm.BCHEncoder(n,k);
bchDecoder = comm.BCHDecoder(n,k);
msgPadSize = k*ceil(msgSize/k)-msgSize;%padding with zeros
%reshaoe for encoding by columns
msgPadReshape = reshape([msg zeros(1,msgPadSize)],k,[]);
msgEnc = zeros(n,size(msgPadReshape,2));
for j = 1: size(msgPadReshape,2)
    msgEnc(:,j)= bchEncoder(msgPadReshape(:,j));
end

%% Section 6
%##################################
msgEnc_b = bsc(msgEnc, 0.05);
msgDec = bchDecoder(msgEnc_b(:));
msgDec_no_pads= msgDec(1:end-msgPadSize);
msgEnc_s = bit2str(msgDec_no_pads);
fprintf("%s\n",msgEnc_s);
