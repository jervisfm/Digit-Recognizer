%{
% Jervis Muindi
% 9th December 2011
% Biometrics Final Project
%}
function [ test_images, test_labels] = loadHndDATA(img_dir)
% Loads handwritten test images. 



if(nargin == 0) %if imgimgdir is undefined.
    img_dir = './img/' %assume by default that's it's in folder called img if not defined
    disp('asdas');
    
end


% Expected File Structure in ImgDir :
% ==================================
% In the imgdir there should be png images labelled from 1 to 200
% inclusive. These images contain scanned handwritten digits in a black
% pen. The sizes of the images vary so they'll need to be rescaled. 
% The modulo of the filename number with 10 gives the "actual" label of
% the image. E.g. if the file is 197.png, then it represents digit 7. 

% Create an array with numbers 0 through 199. 
arr_length = 200; % we've 200 test samples. 
for i = 1:arr_length
    
    im_name = int2str(i); 
    im_name = strcat(im_name, '.png');
    
    im_path = strcat(img_dir,im_name); 
    
    img = imread(im_path, '.png');  % read image
    img = rgb2gray(img);  % convert to grayscale. 
    img = imresize(img, [28 28]);  % resize to 28 x 28
    img = double(img); % convert from int to doubles.
    img = img / max(img(:)); % normalize values to have maximum of 1. 
    img = darken(img);  %binarize image and convert to a black background.
    
    %do extraction and make it fill up entire 28x28
    %img = extract(img);
    %img = imresize(img, [28 28]);
    
    test_images{i} = img; 
    test_labels(i) = mod(i,10); 

end



end






