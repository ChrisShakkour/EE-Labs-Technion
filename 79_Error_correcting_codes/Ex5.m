clc
clear
close all

addpath('Users/lareine.at/Downloads/ECC lab/For Students/Functions/');
%% Section 1
%##################################
H = [
    1 1 1 1 0 1 1 0 0 0;
    0 0 1 1 1 1 1 1 0 0;
    0 1 0 1 0 1 0 1 1 1;
    1 0 1 0 1 0 0 1 1 1;
    1 1 0 0 1 0 1 0 1 1];
plotTanner(H);
%% Section 2
%##################################
G=G2H(H); [k,n] = size(G); u = randi([0 1],1,k); rng(2,'twister');
t=2; erasureLocations = [ones(1,t) zeros(1,n-t)];
erasureLocations = erasureLocations(randperm(n));
y = mod(u*G,2); y(erasureLocations==1) = 2; %2 is erasure
%% Section 3
%##################################
[cDecPeeling,successPeeling] = PeelingDecoder(H,y,'PlotTanner',true);
FigList = flip(findobj(allchild(0), 'flat', 'Type', 'figure'));
for Fig = 1:numel(FigList)
	saveas(FigList(Fig), sprintf('Users/lareine.at/Downloads/ECC lab/Exp5_graphs/Peeling_Example_%d.jpg',Fig));
end
%% Section 4
%##################################
[cDecML,successML] = BECMLDecoder(G,y);
%% Section 5
%##################################
t=3; erasureLocations = [ones(1,t) zeros(1,n-t)];
erasureLocations = erasureLocations(randperm(n));
y = mod(u*G,2); y(erasureLocations==1) = 2; %2 is erasure
[cDecPeeling,successPeeling] = PeelingDecoder(H,y,'PlotTanner',true);
FigList = flip(findobj(allchild(0), 'flat', 'Type', 'figure'));
for Fig = 1:numel(FigList)
	saveas(FigList(Fig), sprintf('Users/lareine.at/Downloads/ECC lab/Exp5_graphs/Peeling_Example_5%d.jpg',Fig));
end
[cDecML,successML] = BECMLDecoder(G,y);

numTrials = 5*1e3; p = 0.4; blockLength = ceil(logspace(1,5,4));
fracErasures = zeros(numTrials,numel(blockLength));
for i = 1: numel(blockLength)
    erasureLocations = rand(numTrials,blockLength(i))<p;
    fracErasures(:,i)= sum(erasureLocations,2)/blockLength(i);
end
figure();
for i = 1: numel(blockLength)
    subplot(2,2,i); hist(fracErasures(:,i),blockLength(i))
end
%% Section 6
%##################################
CNDegree = 6; VNDegree = 3; blockLength = 6*1e4;
H = regLDPCpar(CNDegree,VNDegree,blockLength);
notzeros=find(H~=0);
whos H;
HFull = full(H);
whos HFull;
%% Section 7
%##################################
[m,n] = size(H); p = 0.4;
erasureLocations = rand(1,n)<p; y = 2* erasureLocations;
[cDecPeeling,successPeeling,fracErasedBits] =...
    PeelingDecoder(H,y,'PlotTanner',false);
