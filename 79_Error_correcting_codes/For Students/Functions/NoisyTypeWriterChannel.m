function strOut = NoisyTypeWriterChannel(strIn)
% NOISYTYPEWRITERCHANNEL randomizes a character which is neighbor to
% charIn the qwerty keyboard, and outputs it.
qwertyIn = {
    '1','2','3','4','5','6','7','8','9','0',... %10 elements
    'q','w','e','r','t','y','u','i','o','p',...%10 elements
    'a','s','d','f','g','h','j','k','l',';'...  %10 elements
    'z','x','c','v','b','n','m',',','.','/'...%10 elements
    ' '}; %whitespace
qwertyOut = cell(1,numel(qwertyIn));
numRowElems = [10,10,10,10];
for j = 1:(numel(numRowElems))
    startingElem = sum(numRowElems(1:j-1))+1;
    finishingElem = sum(numRowElems(1:j));
    for  i = startingElem:finishingElem 
       qwertyOut{i} = unique({
           qwertyIn{max(i-1,startingElem)},...
           qwertyIn{i},...
           qwertyIn{min(i+1,finishingElem)}});
    end
end
qwertyOut{end} = {' '}; %whitespace is error free
qwertyMap = containers.Map(qwertyIn,qwertyOut,'UniformValues',false);

strOut = strIn;
for i =1:numel(strIn)
    out = qwertyMap(strIn(i));
    if (rand < 0.5)
        strOut(i) = strIn(i); %do nothing
    else
        strOut(i) = out{randi([1 numel(out)])};
    end
end

end

