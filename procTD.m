% Jervis Muindi
% Biometrics Final Project
% 11th December 2011

function  r = procTD( images )
% Process the traing data (image cell array) by bouding digits to bounding box. 
% this is for trainig data.


    length = size(images,2); 
    
    %process all img samples.
    disp('Processing images in Training Set...'); 
    for i = 1:length
        
        if(mod(i,1000) == 0)
            fprintf('Processed %d of 60000 training samples\n',i);
        end
        
        img_sample = images{i}; 
        img_sample = binarize(img_sample);
        img_sample = extract(img_sample); % bound it
        img_sample = imresize(img_sample, [28 28]); % resize 
        img_sample = binarize(img_sample); % re-binarize
        
        images{i} = img_sample; 
    
    end
    
    r = images; 

end

