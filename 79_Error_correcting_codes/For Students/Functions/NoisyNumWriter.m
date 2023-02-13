function strOut = NoisyNumWriter(strIn)
% NoisyNumWriter randomizes a number if it is less
% than 4 numbers away from numIn to.
check = strIn<'9' & strIn > '0';
dim = numel(size(check));
for dd=1:dim
   check =  all(check);
end
if( check == 0)
    error('strIn is out-of-range');
end
strOut = strIn;
for i =1:numel(strIn)
    in = str2double(strIn(i));
    if (rand < 0.5)
        strOut(i) = strIn(i); %do nothing
    else
        strOut(i)= num2str(randi([max(in-3,1) min(in+3,8)]));
    end
end

end