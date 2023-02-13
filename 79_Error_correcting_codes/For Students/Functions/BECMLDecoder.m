function [cDec,success] = BECMLDecoder(G,y)
[k,~] = size(G);
% generate all information words
U = zeros(2^k,k);
for i = 1:2^k
    U(i,:) = de2bi(i-1,k);
end
% generate codebook
C = mod(U*G,2);
% pass on recieved word and compare to codebook
knownIndexes = find(y~=2);
candidateCodewords = (1:2^k).'; 
for i = 1:numel(knownIndexes)
    index = knownIndexes(i);
    candidateCodewords = intersect(candidateCodewords,find(C(:,index)==y(index)));
    if(isempty(candidateCodewords)) %no matching codeword
        break;
    end
end
if(numel(candidateCodewords)==1) 
    success = true;
    cDec = C(candidateCodewords,:);
else %choose a candidate
    success = false;
    cDec = C(candidateCodewords(1),:);
end


end

