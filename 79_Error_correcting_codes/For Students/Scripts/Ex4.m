msg = randi([0 1],1,5000); msgLength = length(msg);
A = logspace(-1,2,100); AA = numel(A);
NumOfTrials = 1e2; sigma = sqrt(0.5);
%% uncoded
BER_Uncoded = zeros(NumOfTrials,AA);
for aa=1:AA
    ... perform BPSK
    for tt=1:NumOfTrials
        ... simulate AWGN + Hard Decision
        BER_Uncoded(tt,aa) = ... calculate Bit Error Rate
    end
end
... semilogy BER vs. Eb[dB]
%% Repetition - Hard Decision

for n = [3 15]
    BER_Rep = zeros(NumOfTrials,AA); c = ...  encode msg
    for aa = 1:AA
        ... perform BPSK
        for tt=1:NumOfTrials
            ...  AWGN + Hard Decision + Majority Decoding
            BER_Rep(tt,aa) = ...  calculate Bit Error Rate
        end
    end
    ... plot BER vs. Eb[dB]
end
%% Repetition - Soft Decision
for n = [3 15]
    BER_Rep = zeros(NumOfTrials,AA); c = ...  encode msg
    for aa = 1:AA
        ... perform BPSK
        for tt=1:NumOfTrials
            ...  AWGN + soft Decision 
            BER_Rep(tt,aa) = ...  calculate Bit Error Rate
        end
    end
    ... semilogy BER vs. Eb[dB]
end
%% BCH
NumOfTrials= 1e1; n = 127;k = 99;
bchEnc = comm.BCHEncoder(n,k); bchDec = comm.BCHDecoder(n,k);
msgPadSize = k*ceil(msgLength/k) - msgLength; %padding zeros for encoding
uBlocks = reshape([msg zeros(1,msgPadSize)],k,[]);
codewordsSent = size(uBlocks,2);cBlocks = zeros(n,codewordsSent);
for j = 1:codewordsSent %encode by columns
    cBlocks(:,j) = bchEnc(uBlocks(:,j));
end
BER_BCH = zeros(NumOfTrials,AA); 
for aa = 1:AA 
    ... perform BPSK
    for tt=1:NumOfTrials
        ... simulate AWGN + Hard decision
        % bch decoder
        cHardBCHDec = zeros(k,codewordsSent);
        for j = 1:codewordsSent
            cHardBCHDec(:,j) = bchDec(... hard decidion column vector);
        end
        cHardBCHDec = cHardBCHDec(:).'; %rearange to a bit stream
        msgHardbchDec = cHardBCHDec(1:msgLength);%remove padding
        BER_BCH(tt,aa) = ... calculate Bit Error Rate
    end
end
...  semilogy BER vs. Eb[dB]