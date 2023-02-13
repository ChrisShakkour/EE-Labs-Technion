function bitStream = im2bit(im)
%IM2BIT converts grayscale-uint8 image into a bit stream

imcol = im(:); bitStream = zeros(length(imcol),8);
for ii = 1:length(imcol)
    bitStream(ii,:) = de2bi(imcol(ii),8,'left-msb'); 
end
bitStream = bitStream'; bitStream = bitStream(:);
end

