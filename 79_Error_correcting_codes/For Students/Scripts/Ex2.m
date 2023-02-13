emojis = ' <:-)8-D;-O :-X'; msg= str2bit(emojis); msgLength = length(msg);
%%
nVec =9:4:33; numErr = zeros(1,length(nVec));
for jj =1: length(nVec)
    n= nVec(jj);
    ... encode msg + simulate BSC(0.25) + Majority Decoding
end
