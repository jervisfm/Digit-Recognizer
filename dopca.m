function [r,pc]  = dopca()
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here


 
% with 60,000 samples , its too much. don't have enough memory
% on hand to compute (need 24gb).
%
% so just look at 10,000 samples -> this needs 0.8Gb which we have.
%

[train_data, train_labels, test_data, test_labels] = readDATA(); 
%train_data = procTD(train_data);
[test_data, test_labels] = loadHndDATA();


length = size(train_data,2); 
length = 2000;
data = zeros(784,length); 


for i =1:length
    if(mod(i,1000) == 0)
    disp(i);
    end
    
    img = train_data{i}; 
    img = img(:); 
    data(:,i) =  img;
    
    
end

disp('doing pca...');

[r, pc] = pca(data); 
%[r, pc] = pca2(data'); 
disp('pca done');
disp('proj data');
size(r)
disp('principal comp')
size(pc)

%error('s');
disp('doiing testing of pca results...'); 

train_size = length;
train_data = r;
errors=0;

for i = 1:200
    
    
    tv = test_data{i};
    %tv = proc(tv);
    tv = tv(:);
    %tv = tv'
    ptv = pc' * tv;
    tv = ptv;
    
     minIdx = 0;
    minDist = Inf; 
    for k = 1:train_size
        j=k;
         av = train_data(j);
        av = av(:); 
        diff = tv - av; 
        dist = norm(diff,2); 
        
        if(dist < minDist)
            minDist = dist;
            %disp(j);
            minIdx = j;
        end
        
    end
        
    
    result(i) = train_labels{minIdx}; 
    
    
    %do accuracy checking in line
    if( test_labels(i) ~= result(i) )
        errors = errors + 1;
        
    end
    tot = i; 
        curr_acc = (tot - errors) / tot; 

        
    if( test_labels(i) ~= result(i) )
        
        fprintf('Curr Accuracy: %f | %d,%d.\n', curr_acc, test_labels(i),result(i) );
        %figure;
        %im = [test_data{i} train_data{minIdx} ];
        %imshow(im);
        continue;
    end
        
    fprintf('Curr Accuracy: %f.\n', curr_acc);
    
    
end






end


