function str=bit2str(b)
b = reshape(b,8,[]).';
str=char(bi2de(b,2,'left-msb'));
str=str';
end