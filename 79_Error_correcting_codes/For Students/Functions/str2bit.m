function b=str2bit(str)

CharArr=char(str);
CC=length(CharArr);
b=zeros(CC,8);
for c=1:CC
   b(c,:)=de2bi(uint8(CharArr(c)),8,'left-msb'); 
end
% reshape to stream
b = b'; b = b(:).';
end