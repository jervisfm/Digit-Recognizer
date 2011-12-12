% Jervis Muindi
% Biometrics Final Project
% 11th December 2011

% Does classification on test data set. 
% By applying nearest neighbor directly
% on extracted features. 
function   approach1()
% Does a test for classifying the handwritten images. 

disp('reading data');
% assume, we have loaded
[train_data, train_labels ] = readDATA();

[test_data, test_labels] = loadHndDATA();

sizeTrain = size(train_data,2); 
sizeTest = size(test_data,2); 
sizeTest = 50;

%Do a quick nearest neighbor test classification. 
errors = 0; 
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
    if( test_labels(i) ~= result(i) )
        errors = errors + 1;
        
    end
    
    tot = i;
    curr_acc = (tot - errors) / tot; 
        
    if( test_labels(i) ~= result(i) )
        
        fprintf('Curr Accuracy: %f | %d,%d.\n', curr_acc, test_labels(i),result(i) );
        figure;
        im = [test_data{i} train_data{minIdx} ];
        imshow(im);
        continue;
    end
        
    fprintf('Curr Accuracy: %f.\n', curr_acc);

end



end











%{
K NEaREST NEIGHTBOR

function   testhnd()
% Does a test for classifying the handwritten images. 

disp('reading data');
% assume, we have loaded
[train_data, train_labels ] = readDATA();

[test_data, test_labels] = loadHndDATA();

sizeTrain = size(train_data,2); 
%sizeTrain = 10000;
sizeTest = size(test_data,2); 
sizeTest = 200;
%Do a quick nearest neighbor test classification. 
errors = 0; 



for i = 1:sizeTest
    
    fprintf('test %d - ', i); 
    tv = test_data{i}; 
    tv = tv(:); 
    
    
    minIdx = 0;
    minDist = Inf; 
    
    arr(1) = 0;
    arr(2) = 0;
    arr(3) = 0; 
    for j = 1:sizeTrain
        
        av = train_data{j};
        av = av(:); 
        diff = tv - av; 
        dist = norm(diff,2); 
        
        if(dist < minDist)
            minDist = dist;
            %disp(j);
            minIdx = j;
            
            prev_first = arr(1); 
            prev_sec = arr(2); 
            
            arr(1) = minIdx; 
            arr(2) = prev_first;
            arr(3) = prev_sec;
            
        end
        %disp('running');
        %disp(dist);
        
    end
    
    num = [train_labels{arr(1)};train_labels{arr(2)} ;train_labels{arr(3)}];
    indices = zeros(10,1); 
    
    for ii = 1:3
        indices(num(ii)+1) = indices(num(ii)+1) + 1; 
    end
    
    [x,number] = max(indices);
    
    %error('s');
    
    %save result; 
    result(i) = number - 1; 
    
    %result(i) = train_labels{minIdx}; 
    
    
    %do accuracy checking in line
    if( test_labels(i) ~= result(i) )
        errors = errors + 1;
        
    end
    tot = i; 
        curr_acc = (tot - errors) / tot; 
    
    if( test_labels(i) ~= result(i) )
        
        fprintf('Curr Accuracy: %f | %d,%d.\n', curr_acc, test_labels(i),result(i) );
        figure;
        continue;
    end
    fprintf('Curr Accuracy: %f.\n', curr_acc );

end



end

%}
