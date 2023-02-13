function [cDec,success,fracErasedVNs] = PeelingDecoder(H,y,flagName1,flagVal)
% parse flags
if (nargin<4)
    plotTannerFlag = false;% by defualt dont plot
elseif (strcmp(flagName1,'PlotTanner'))
    plotTannerFlag = flagVal;
else
    error('Unkknown flag name');
end
cDec = y; fracErasedVNs = sum(cDec==2)/numel(cDec);
[m,n] = size(H);
CNs = zeros(m,1); %store XORed values
VNs = 1:n; %store VN label
%% Remove known VNs from graph
KnownVNs = find(cDec~=2);
numDecodedVNs = 0;
HPeeling = H;
for i = 1:numel(KnownVNs)
    VN = KnownVNs(i);
    ConnecedNCs = find(HPeeling(:,VN-numDecodedVNs));
    CNs(ConnecedNCs) = mod(CNs(ConnecedNCs)+cDec(VN),2);
    VNs = VNs(VNs~=VN);
    HPeeling(:,VN-numDecodedVNs) = [];
    if(plotTannerFlag)
        plotTanner(HPeeling,CNs,VNs);
    end
    numDecodedVNs = numDecodedVNs +1;
end
%% Search for degree-1 CNs
erasureIndex = find(cDec==2);
deg1CNs = find(sum(HPeeling,2)==1);
while (numel(deg1CNs)>0)
    for j = 1:numel(deg1CNs)
        CN = deg1CNs(j);col = find(HPeeling(CN,:));
        if(isempty(col))
            continue;
        end
        decVN = erasureIndex(col); %should be only 1
        cDec(decVN) = CNs(CN); erasureIndex = find(cDec==2);
        fracErasedVNs = [fracErasedVNs numel(erasureIndex)/numel(cDec)];
        ConnecedNCs = find(HPeeling(:,col));
        CNs(ConnecedNCs) = mod(CNs(ConnecedNCs)+cDec(decVN),2);
        VNs = VNs(VNs~=VNs(col));
        HPeeling(:,col) = [];
        if(plotTannerFlag)
            plotTanner(HPeeling,CNs,VNs);
        end
        if (isempty(erasureIndex))
            break;
        end
    end
    deg1CNs = find(sum(HPeeling,2)==1);
end
success = isempty(erasureIndex);
end

