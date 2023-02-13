function plotTanner(H,CNs,VNs)
if nargin<3
    VNs = 1:size(H,2);
end

if nargin<2
    CNs = zeros(1,size(H,1));
end

[m,n] = size(H); 
HH = [zeros(m,m), H;
         H', zeros(n,n)];     
g = graph(HH);
% Plot
figure(); Tanner = plot(g,'ob'); hold on;
% Make it pretty
Tanner.XData(1:m) = 1;
Tanner.XData((m+1):end) = 2;
Tanner.YData(1:m) = linspace(1,0,m);
Tanner.YData((m+1):end) = linspace(1,0,n);
Tanner.MarkerSize = 6;
Tanner.EdgeColor = [0 0 0];
Tanner.NodeLabel=[zeros(1,m) VNs];
for i = 1:m
    Tanner.NodeLabel{i}='';
end
%add CNs different color
gCNs = graph(zeros(m));
hCNs = plot(gCNs,'sr');
hCNs.XData = ones(1,m); hCNs.YData = linspace(1,0,m);
hCNs.MarkerSize = 10; hCNs.NodeLabel = CNs;
end

