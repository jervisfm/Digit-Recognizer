function  testk(k)
%K-nearest neighbor classifier
%  Call with values of k to test. Defaults to test size of 2000 for speed reasons. Can be edited to run with size 10,000.

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
    
    minIdxVec = zeros(1,k);
    minDistVec = zeros(1,k) + Inf;
    
%     minIdx = 0;
%     minDist = Inf; 
    
    for j = 1:sizeTrain
        
        av = train_data{j};
        av = av(:); 
        diff = tv - av; 
        dist = norm(diff,2); 
        
        % get the nearest neighbor that is furthest away and its index
        [minDist, minDistIdx] = max(minDistVec);
        
        if(dist < minDist)
            minDistVec(minDistIdx) = dist;
            %disp(j);
            minIdxVec(minDistIdx) = j;
        end
        %disp('running');
        %disp(dist);
        
    end
    %error('s');
    
    %save result; 
    
    minIdx = mode(minIdxVec);
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




