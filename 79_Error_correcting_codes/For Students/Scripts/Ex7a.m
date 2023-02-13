k = 16; n = 24;
rsEnc = comm.RSEncoder(n,k,'BitInput',false);
rsDec = comm.RSDecoder(n,k,'BitInput',false,...
'ErasuresInputPort',true);
u = randi([0 n],k,1); c = rsEnc(u);
%%
tErase = 2; erasureLocations = [ones(tErase,1); zeros(n-tErase,1)];
erasureLocations = erasureLocations(randperm(n));
y = c; y(erasureLocations==1)= 0;
m = rsDec(y,erasureLocations);
%%
[samples,Freq] = audioread('Stream.flac');
player = audioplayer(samples,Freq);
%%
packetByteSize = 32; samplesPerPacket = packetByteSize/8;
numPackets = numel(samples)/samplesPerPacket;
packets = cell(numPackets,1);
for i = 1:numPackets
    packets{i}= samples((i -1)*samplesPerPacket+1:i*samplesPerPacket);
end
p =0.25; packetErasureLocation = binornd(1,p,numPackets,1);
packetErasureIndices = find(packetErasureLocation);
packetsRecieved = packets;
for i = 1:numel(packetErasureIndices)
    packetsRecieved{packetErasureIndices(i)}= zeros(samplesPerPacket,1);
end
samplesReconstruct = zeros(numPackets*samplesPerPacket,1);
for i = 1:numPackets
    samplesReconstruct((i -1)*samplesPerPacket+1:i*samplesPerPacket)=...
        packetsRecieved{i};
end
%%
numInformationPackets = 5; numRedudantPackets = 2;
numCodewordPackets = numInformationPackets+numRedudantPackets;
k = packetByteSize*numInformationPackets;
n = packetByteSize*(numInformationPackets+numRedudantPackets);
rsEnc = comm.RSEncoder(n,k,'BitInput',false);
rsDec = comm.RSDecoder(n,k,'BitInput',false,...
   'ErasuresInputPort',true);
% encode
samplesInt = typecast(samples(:),'uint8');
msg = reshape(samplesInt,k,[]); msgEnc = uint8(zeros(n,size(msg,2)));
for j = 1:size(msg,2)
    msgEnc(:,j)= rsEnc(msg(:,j));
end
msgEnc = msgEnc(:);
%%
% pack
numEncPackets = numel(msgEnc)/packetByteSize;
packetsEnc = cell(numEncPackets,1);
for i = 1:numEncPackets
    packetsEnc{i}= msgEnc((i -1)*packetByteSize+1:i*packetByteSize);
end
% send
packetErasureLocation =...
    zeros(numCodewordPackets,numEncPackets/numCodewordPackets);
for j = 1:size(packetErasureLocation,2)
    erasures = [ones(numRedudantPackets,1);...
        zeros(numInformationPackets,1)];
    packetErasureLocation(:,j)= erasures(randperm(numCodewordPackets));
end
packetErasureLocation = packetErasureLocation(:);
packetErasureIndices = find(packetErasureLocation);
packetsRecieved = packetsEnc;
numTotalErasedPackets = numel(packetErasureIndices);
for i = 1:numTotalErasedPackets
    packetsRecieved{packetErasureIndices(i)}=...
        uint8(zeros(packetByteSize,1));
end
%%
% unpack
msgRecieved = uint8(zeros(numEncPackets*packetByteSize,1));
for i = 1:numEncPackets
    msgRecieved((i -1)*packetByteSize+1:i*packetByteSize)=...
        packetsRecieved{i};
end
msgRecieved = reshape(msgRecieved,n,[]);
% translate packet erasures into symbol erasures
erasedSymbolsLocation = repmat(packetErasureLocation',packetByteSize,1);
erasedSymbolsLocation = reshape(erasedSymbolsLocation,n,[]);
% decode
msgDecoded = uint8(zeros(k,size(msgRecieved,2)));
for j = 1:size(msgRecieved,2)
    msgDecoded(:,j)= rsDec(msgRecieved(:,j),erasedSymbolsLocation(:,j));
end
%%
samplesDecoded = msgDecoded(:);
samplesDecoded = reshape(samplesDecoded,8,[]).';
samplesReconstruct = zeros(numel(samplesDecoded)/8,1);
for i = 1:numel(samplesReconstruct)
    samplesReconstruct(i)= typecast(samplesDecoded(i,:),'double');
end
%%
burstLength = 10000; burstStart = randi([1 numEncPackets-1000]);
packetErasureLocation = zeros(numEncPackets,1);
packetErasureLocation(burstStart:(burstStart+burstLength))=1;
packetErasureIndices = find(packetErasureLocation);
packetsRecieved = packetsEnc;
numTotalErasedPackets = numel(packetErasureIndices);
for i = 1:numTotalErasedPackets
    packetsRecieved{packetErasureIndices(i)}=...
        uint8(zeros(packetByteSize,1));
end
%%
packetsEncInter = packetsEnc;
packetsEncInter = reshape(packetsEncInter,numCodewordPackets,[]);
packetsEncInter = packetsEncInter.';
packetsEncInter = packetsEncInter(:);
%%