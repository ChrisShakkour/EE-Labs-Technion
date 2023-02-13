clc
clear
close all

addpath('Users/lareine.at/Downloads/ECC lab/For Students/Functions/');
%% Section 1
%##################################
binFileLength = 6*1e3;
binFile = randi([0 1],1,binFileLength);
%ChannelOut=ConstChannel(binFile);

%% Section 2
%##################################
binFileEnc= []; i=1;
while (i<= numel(binFile))
	binFileEnc = [binFileEnc binFile(i) 0];
    i = i+1;
end

%% Section 3
%##################################
ChannelOut=ConstChannel(binFileEnc);
binFileDec= []; i=1;
while (i<= numel(binFile))
	binFileDec = [binFileDec binFileEnc(2*i-1)];
    i = i+1;
end
Xored = xor(binFileDec, binFile);
Errors = sum(Xored);

%% Section 4
%##################################
strFile=num2str(binFile(:));
DecIn = {'000', '001', '010', '011', '100', '101', '110', '111'};
DecOut = {'00000', '10000', '01000', '00100', '00010', '10100', '01010' ,'10010'}; % new coding scheme
mapDec = containers.Map(DecIn ,DecOut);
binFileEnc = []; i=1;
while (i<= numel(strFile))
    binFileEnc = [binFileEnc mapDec(strFile(i:i+2)')];
    i = i+3;
end

%% Section 5
%##################################
binFileEnc = []; i=1;
while (i<= numel(binFile))
	if (binFile(i)) 
		binFileEnc = [binFileEnc 1 0];
	else 
		binFileEnc = [binFileEnc 0];
    end
    i=i+1;
end
