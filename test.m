function  test()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% 96 accuracy for test data. of size 2000. 

disp('reading data');
% assume, we have loaded
[train_data, train_labels, test_data, test_labels] = readDATA();


sizeTrain = size(train_data,2); 
sizeTest = size(test_data,2); 
sizeTest = 2000;
%Do a quick nearest neighbor test classification. 
errors = 0; 

%fprintf('size of train - %d',sizeTrain);

for i = 1:sizeTest
    
    fprintf('test %d - ', i); 
    tv = test_data{i}; 
    tv = tv(:); 
    
    
    minIdx = 0;
    minDist = Inf; 
    
    for j = 1:sizeTrain
        
        av = train_data{j};
        av = av(:); 
        diff = tv - av; 
        dist = norm(diff,2); 
        
        if(dist < minDist)
            minDist = dist;
            %disp(j);
            minIdx = j;
        end
        %disp('running');
        %disp(dist);
        
    end
    %error('s');
    
    %save result; 
    
    result(i) = train_labels{minIdx}; 
    
    
    %do accuracy checking in line
    if( test_labels{i} ~= result(i) )
        errors = errors + 1;
        
    end
    tot = i; 
        curr_acc = (tot - errors) / tot; 
        
    fprintf('Curr Accuracy: %f.\n', curr_acc);

end

%{
%compute accuracy
total = sizeTest;
errors = 0;
for ii = 1:sizeTest
    if( test_labels{i} ~= result(ii)  )
        errors = errors + 1;
    end 
end

%output accuracy.
acc = (total - errors) / total;
fprintf('Accuracy : %f', acc);
%}




