H = [
    1 1 1 1 0 1 1 0 0 0;
    0 0 1 1 1 1 1 1 0 0;
    0 1 0 1 0 1 0 1 1 1;
    1 0 1 0 1 0 0 1 1 1;
    1 1 0 0 1 0 1 0 1 1];
plotTanner(H);
%%
G=G2H(H); [k,n] = size(G); u = randi([0 1],1,k); rng(2,'twister');
t=2; erasureLocations = [ones(1,t) zeros(1,n-t)];
erasureLocations = erasureLocations(randperm(n));
y = mod(u*G,2); y(erasureLocations==1) = 2; %2 is erasure
%%
[cDecPeeling,successPeeling] = PeelingDecoder(H,y,'PlotTanner',true);
%% 
FigList = flip(findobj(allchild(0), 'flat', 'Type', 'figure'));
for Fig = 1:numel(FigList)
	saveas(FigList(Fig), sprintf('Peeling_Example_%d.jpg',Fig));
end
%%
[cDecML,successML] = BECMLDecoder(G,y);
%%
t=3; erasureLocations = [ones(1,t) zeros(1,n-t)];
erasureLocations = erasureLocations(randperm(n));
y = mod(u*G,2); y(erasureLocations==1) = 2; %2 is erasure
%%
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
%%
CNDegree = 6; VNDegree = 3; blockLength = 6*1e4;
H = regLDPCpar(CNDegree,VNDegree,blockLength);
%%
[m,n] = size(H); p = 0.4;
erasureLocations = rand(1,n)<p; y = 2* erasureLocations;
[cDecPeeling,successPeeling,fracErasedBits] =...
    PeelingDecoder(H,y,'PlotTanner',false);
%%