strIn = '46733';strOut = NoisyNumWriter(strIn);
%%
encoderIn =  {'1',  '2',  '3',  '4',  '5',  '6',  '7',  '8'  };
encoderOut = {'111','118','181','188','811','818','881','888'};
encoder = containers.Map(encoderIn,encoderOut);
%% 
strEnc = []; i=1;
while i<= numel(strIn)
   strEnc = [strEnc, encoder(strIn(i))]; i = i+1;
end
%%
qwerty ={
   '1','2','3','4','5','6','7','8','9','0',...%10 elements
   'q','w','e','r','t','y','u','i','o','p',...%10 elements
   'a','s','d','f','g','h','j','k','l',';'...%10 elements
   'z','x','c','v','b','n','m',',','.','/'...%10 elements
   ' '}; totalNumOfChars = numel(qwerty);
%%
strIn ='hello, my cellphone number is 555046205, thanks.'; 
strOut = NoisyTypeWriterChannel(strIn);
