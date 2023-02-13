clc
clear
close all

addpath('Downloads/ECC lab/For Students/Functions/');
%% Section 1
%##################################
msg = randi([0 1],1,5000); msgLength = length(msg);
A = logspace(-1,2,100); AA = numel(A);
NumOfTrials = 1e2; sigma = sqrt(0.5);

BER_Uncoded = zeros(NumOfTrials,AA);
BER = zeros(1,AA); %initialisation
for aa=1:AA
    a = A(aa);
    bitStrModulated = BPSK(msg,a);
    for tt=1:NumOfTrials
        bitStrErr = AWGN(bitStrModulated,sigma);
        bitStrHard = double(bitStrErr<0);
        errors = xor(msg, bitStrHard);
        BER_Uncoded(tt,aa) = sum(errors(:)==1)./msgLength;
        BER(aa) = BER(aa) + BER_Uncoded(tt,aa);
    end
end
%... semilogy BER vs. Eb[dB]
figure(); 
semilogy(10*log10(A.^2),BER./NumOfTrials, 'b');
hold on;
xlabel('E_{b} [dB], as N_{0} is const');
ylabel('error ratio');

%% Section 2: Repetition - Hard Decision
%##################################
for n = [3 15]
    BER_Rep = zeros(NumOfTrials,AA);
    BER = zeros(1,AA);  %initialisation
    c = repmat(msg,n,1); 
    for aa = 1:AA
        a = A(aa);
        bitStrModulated = BPSK(c,a);
        fprintf("bpsk done %d\n",aa);
        for tt=1:NumOfTrials
           bitStrErr = AWGN(bitStrModulated,sigma);
           bitStrHard = double(bitStrErr<0);
           sum_sign_msg = sum(bitStrHard);
           dec_msg = double(sum_sign_msg>n/2);
           xored = xor(msg, dec_msg);
           BER_Uncoded(tt,aa) = sum(xored(:)==1)./length(msg);
           BER(aa) = BER(aa) + BER_Uncoded(tt,aa);
        end
    end
    semilogy(10*log10(n*A.^2),BER./NumOfTrials);
    hold on;
    xlabel('E_{b} [dB], as N_{0} is const');
    ylabel('error ratio');
end

%% Section 3: Repetition - Soft Decision
%##################################
%ErBitSoft = zeros(2,AA); %initialisation
for n = [3 15]
    BER_Rep = zeros(NumOfTrials,AA);
    BER = zeros(1,AA);  %initialisation
    c = repmat(msg,n,1); 
    for aa = 1:AA
        a = A(aa);
        bitStrModulated = BPSK(c,a);
        EbBitSoft((n>3)+1,aa)= n*a^2;
        fprintf("bpsk done %d\n",aa);
        for tt=1:NumOfTrials
           rest_msg = zeros(1,numel(msg));
           bitStrErr = AWGN(bitStrModulated,sigma);
           for i = 1:msgLength
              bitStrSoft(i) = sum(bitStrErr(((i-1)*n+1:i*n)))<0; 
           end
           %bitStrHard = double(bitStrErr<0);
           %sum_sign_msg = sum(bitStrHard);
           %dec_msg = double(sum_sign_msg>n/2);
           
           xored = xor(msg, bitStrSoft);
           BER_Uncoded(tt,aa) = sum(xored(:)==1)./(NumOfTrials*length(msg));
           BER(aa) = BER(aa) + BER_Uncoded(tt,aa);
        end
        nEr = sum(BER_Uncoded,1);
        avg_BER_soft((n>3)+1,aa)= nEr(aa);
    end
    semilogy(10*log10(EbBitSoft),avg_BER_soft((n>3)+1,:));
    hold on;
    xlabel('E_{b} [dB], as N_{0} is const');
    ylabel('error ratio');
end

%% Section 4: Repetition - BCH Decoder
%##################################
NumOfTrials= 1e1; n = 127;k = 99; R = k/n;
bchEnc = comm.BCHEncoder(n,k); bchDec = comm.BCHDecoder(n,k);
msgPadSize = k*ceil(msgLength/k) - msgLength;
uBlocks = reshape([msg zeros(1,msgPadSize)],k,[]);
codewordsSent = size(uBlocks,2);cBlocks = zeros(n,codewordsSent);
Eb_bch = zeros(1,AA); %initialisation
for j = 1:codewordsSent %encode by columns
    cBlocks(:,j) = bchEnc(uBlocks(:,j));
end
BER_BCH = zeros(NumOfTrials,AA); 
for aa = 1:AA 
    a = A(aa);
    Eb_bch(aa) = (a^2)./R;
    bitStrModulated_1 = BPSK(cBlocks,a);
    fprintf("bpsk done %d\n",aa);
    for tt=1:NumOfTrials
        bitStrErr_1 = AWGN(bitStrModulated_1,sigma);
        bitStrHard_1 = double(bitStrErr_1<0);
        cHardBCHDec = zeros(k,codewordsSent);
        for j = 1:codewordsSent
            cHardBCHDec(:,j) = bchDec(bitStrHard_1(:,j));
        end
        cHardBCHDec = cHardBCHDec(:).'; %rearange to a bit stream
        msgHardbchDec = cHardBCHDec(1:msgLength);% remove padding
        BER_BCH(tt,aa) = sum(sum(abs(bitStrHard_1-cBlocks)))...
            /(size(bitStrHard_1,2)*size(bitStrHard_1,1));
    end
end
avg_BER_bch = sum(BER_BCH,1)/NumOfTrials;
%figure(); 
semilogy(10*log10(A.^2),avg_BER_bch);
legend ('Exp 1', 'Exp 2, n = 3', 'Exp 2, n = 15',...
        'Exp 3, n = 3', 'Exp 3, n = 15','Exp 4');
hold on;
xlabel('E_{b} [dB], as N_{0} is const');
ylabel('error ratio');


