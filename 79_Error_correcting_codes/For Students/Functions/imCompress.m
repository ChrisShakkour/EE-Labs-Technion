function CI = imCompress(im)
%IMCOMPRESS DCT-based compression
%   Inputs:
%       im: grayscale image (unit8) with sizes divisable by 8.
%   Outputs:
%       CI: Compressed Image struct:
%           code: compressed data in bits
%           dict: Huffman dictionary used for compression
%           height: height of original image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% apply DCT
imDCT = ...
    blockproc(im,[8 8],@(block_struct)dct2(block_struct.data));
% Get rid of small frequencies
th = 20; imDCT(abs(imDCT)<th) = 0;
% quantizer
Q = 2^6; [levels,values]=lloyds(double(imDCT(:)),Q);
imCDTQuant = round(imquantize(imDCT,levels,values));
values = unique(imCDTQuant(:).');
% Huffman coding
[Count,~] = ...
    histcounts(double(imCDTQuant(:)),[values values(end)+1]);
plevels = (Count)/sum(Count);
dict = huffmandict(values,plevels);
imHuffman = huffmanenco(imCDTQuant(:),dict);
% output
CI.data = imHuffman; CI.dict = dict; CI.height = size(im,1);
end

