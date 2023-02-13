binFileLength = 6*1e3;
binFile = randi([0 1],1,binFileLength);
%%
while (i<= numel(binFile))
	if (...) 
		binFileEnc = [binFileEnc ...];
	else 
		binFileEnc = [binFileEnc ...];
	end
end
%%
trialN =40*1e1; numTrials =1e4; p = 0.01;
codeErrorCount = zeros(1,numTrials); bscErrorCount = codeErrorCount;
for t = 1: numTrials
    trialU = randi([0 1],trialN,1);
    trialC = ... ENCODE trialU WITH CONSTRAINED ENCODER
    trialY = ConstChannel(trialC); trialY = bsc(trialY,p);
    bscErrorCount(t)= sum(trialY ~= trialCRe);
    trialUDDec = ... DECODE trialUDDec WITH CONSTRAINED DECODER
    codeErrorCount(t)= sum(sum(trialU ~= trialUDDec));
end
TrialPWorstCase = max(codeErrorCount)/trialN;
figure(); hist(codeErrorCount,trialN); figure(); hist(bscErrorCount,trialN);
%%
bchEnc = comm.BCHEncoder(nBCH,kBCH); bchDec = comm.BCHDecoder(nBCH,kBCH);
