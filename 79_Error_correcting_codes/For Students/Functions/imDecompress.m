function imDec = imDecompress(imCompressed,imHeight,dict)
%IMDECOMPRESS Summary of this function goes here
%   Inputs:
%       IMCOMPRESSED - compressed image
%       imHeight - height of original image
%       dict - Huffman dictionary used for compression
%   Output:
%       imDec - Decompressed image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Huffman decode
imDeHuf = huffmandeco(imCompressed,dict);
%pad zeros to make length divisable bu height
imDeHuf = [imDeHuf ;zeros(mod(-length(imDeHuf),imHeight),1)];
imDeHuf = reshape(imDeHuf,imHeight,[]);
%inverse DCT
imDec = ...
    uint8(blockproc(imDeHuf,[8 8],@(block_struct)idct2(block_struct.data)));
end

