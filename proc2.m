% Jervis Muindi
% Biometrics Final Project
% 11th December 2011

function  r = proc2( image )
  %Process given image by bouding digits to bounding box. 
 % this also thickens the image. should be used for handwrittend
 % self gathered test images.

    
    %process  img sample.
    
    img_sample = image; 
    img_sample = binarize(img_sample);
    img_sample = extract(img_sample); % bound it
    img_sample = imresize(img_sample, [28 28]); % resize 
    img_sample = binarize(img_sample); % re-binarize
    img_sample = thicken(img_sample); % thicken
    
    r = img_sample; 

end

