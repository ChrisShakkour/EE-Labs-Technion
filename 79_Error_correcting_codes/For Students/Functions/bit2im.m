function im = bit2im(bitStream,height)
%BIT2IM converts a bit stream into a gryscale-uint8 image
if(mod(numel(bitStream),8*height) ~= 0)
    error('Number of elelements in bit stream must be divided by 8*height');
end
bitStream = reshape(bitStream,8,[]);
bitStream = bitStream';
im = uint8(zeros(size(bitStream,1),1));
for ii = 1:length(bitStream)
    im(ii) = uint8(bi2de(bitStream(ii,:),'left-msb')); 
end
im = reshape(im,height,[]);
end

