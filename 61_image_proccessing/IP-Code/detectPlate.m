function finalMask = detectPlate(plateImage)
%DETECTPLATE Detects license plate(s) in an image and returns a binary mask of the location(s)
%
% plateImage - The input image for plate detection
% finalMask  - The resulting binary mask for the plate(s)
%
%%%%%% Write your code here:

hsv = rgb2hsv(plateImage); 

% Split to channels
red = plateImage(:,:,1);
green = plateImage(:,:,2);
blue = plateImage(:,:,3);
hue = hsv(:,:,1);  
sat = hsv(:,:,2); 
val = hsv(:,:,3);

posthsvimage = (hue>0.10)&(hue<0.22)&(sat>0.5);
%subplot(1,3,1); imshow(posthsvimage); title('0<Hue<0.05 or 0.95<Hue<1');

SE6 = strel('disk',10,4);             
dialated = imdilate(posthsvimage,SE6);
%subplot(1,3,2); imshow(dialated); title('0<Hue<0.05 or 0.95<Hue<1');

newImage = bwpropfilt(dialated,'Area',1);
%subplot(1,3,3); imshow(newImage); title('0<Hue<0.05 or 0.95<Hue<1');

SE7 = strel('line',10,5);             
dialated2 = imdilate(newImage,SE7);
%subplot(1,3,2); imshow(dialated2); title('0<Hue<0.05 or 0.95<Hue<1');

finalMask = dialated2;
end