clc
clear
close all

addpath('Users/lareine.at/Downloads/ECC lab/For Students/Functions/');
%% Section 1
%##################################
strIn = '46733';strOut = NoisyNumWriter(strIn);

%% Section 2
%##################################
repEnc = repmat(strIn,7,1);
nstrOut = NoisyNumWriter(repEnc);
strOutDec = mode(nstrOut);

%% Section 3
%##################################
encoderIn =  {'1',  '2',  '3',  '4',  '5',  '6',  '7',  '8'  };
encoderOut = {'111','118','181','188','811','818','881','888'};
Enc = containers.Map(encoderIn,encoderOut);
strEnc = []; i=1;
while i<= numel(strIn)
   strEnc = [strEnc, Enc(strIn(i))]; i = i+1;
end

%% Section 4
%##################################
strNoised = NoisyNumWriter(strEnc);

%% Section 5
%##################################
DecIn = {'1', '2', '3', '4', '5', '6', '7', '8' };
DecOut = {'1','1','1','1','8','8','8','8'}; % new coding scheme
mapDec = containers.Map(DecIn ,DecOut);
strDec = []; i=1;
while i<= numel(strNoised)
    strDec = [strDec , mapDec(strNoised(i))]; 
    i = i+1;
end

%% Section 6
%##################################
Dec2In = {'111','118','181','188','811','818','881','888'};
Dec2Out = {'1', '2', '3', '4', '5', '6', '7', '8' }; % decoding suggestion
Dec2 = containers.Map(Dec2In ,Dec2Out );
strDec2 = []; i=1;
while i<= numel(strDec)
    strDec2 = [strDec2 , Dec2(strDec(i:i+2))];
    i = i+3;
end

%% Section 7
%##################################
qwerty ={
   '1','2','3','4','5','6','7','8','9','0',...%10 elements
   'q','w','e','r','t','y','u','i','o','p',...%10 elements
   'a','s','d','f','g','h','j','k','l',';'...%10 elements
   'z','x','c','v','b','n','m',',','.','/'...%10 elements
   ' '}; totalNumOfChars = numel(qwerty);
strIn ='hello, my cellphone number is 555046205, thanks.'; 
strOut = NoisyTypeWriterChannel(strIn);

%% Section 8
%##################################

%% Section 9
%##################################
encoderOut ={
   '1','4','7','0','q','r','u','p','a','f',...%10 elements
   'j',';','z','v','m1','m4','m7','m0','mq','mr',...%10 elements
   'mu','mp','ma','mf','mj','m;','mz','mv','/1','/4'...%10 elements
   '/7','/0','/q','/r','/u','/p','/a','/f','/j','/;'...%10 elements
   ' '};

%% Section 10
%##################################
Enc=containers.Map(qwerty,encoderOut);
strEnc = []; i=1;
while i<= numel(strIn)
    strEnc = [strEnc , Enc(strIn(i))];
    i = i+1;
end

%% Section 11
%##################################
strNoised = NoisyTypeWriterChannel(strEnc);

%% Section 12
%##################################

%% Section 13
%##################################
finDecIn = qwerty;
finDecOut = {'1','1','4','4','4','7','7','7','0','0', ...
                'q','q','r','r','r','u','u','u','p','p',...
                'a','a','f','f','f','j','j','j',';',';',...
                'z','z','v','v','v','m','m','m','/','/',...
                ' '};
% First step on denoising
correction = containers.Map(finDecIn ,finDecOut );
strCorrected = []; i=1;
while i<= numel(strNoised)
    strCorrected = [strCorrected , correction(strNoised(i))];
    i = i+1;
end

% Second step of remapping
finDecIn2 = encoderOut;
finDecOut2 = qwerty;
Dec = containers.Map(finDecIn2 ,finDecOut2 );
strDec2 = []; i=1;
while i<= numel(strCorrected)
    if (strCorrected(i) == 'm' || strCorrected(i) == '/')
        strDec2 = [strDec2 , Dec(strCorrected(i:i+1))];
        i = i+2;
    else
        strDec2 = [strDec2 , Dec(strCorrected(i))];
        i = i+1;
    end
end


%% Probablity matrix
%##################################
p=0.5;
q=1-p;
a=zeros(41,41);

a(1,:)=[p q zeros(1, 39)];
for i=2:1:38
    temp=zeros(1,41);
    temp(i:i+2) = [q/2 p q/2];
    a(i,:) = temp(:);
end
a(39,:)=[zeros(1, 38) q p 0];
a(40,:)=[zeros(1, 39) 1 0];