function [ signals, PC, V ] = pca( data )
% Perform PCA. 
% Data is the data matrix having dimensions in the columns and each image vector in the rows
% data - of size M by N
% PC - the principal components
% V - M by 1 of variances
% proj - the projected data
% 


% Create the mean vector. This contains the means of each dimension
% of the data matrix (the cols)

[M,N] = size(data); 
mn = mean(data,2); 
%mn = mn'; %covnert to column vector

% subtract the mean of each dimension from the data matrix
disp('subtracting means..');
size(mn)
data = data - repmat(mn,1,N); 

%calculate the convariance matrix. 
size(data)
disp('computing conv');

covariance = 1 / (N-1) * (data * data') ; 

disp('finding eig vals');
%find the eigen vectors and eigen values
[PC, V] = eig(covariance); 

%extract diagonal of matrix as vector which has the eigen values. 
V = diag(V); 

%sort the eigen values in decreasing order
[sorted, rindices] = sort(V, 'descend'); 


V = sorted; 
disp(' e v');
V
rindices = rindices(1:10, :);
%size(rindices)

%PC = PC(:, rindices); 

disp('doing projections');
%project the original data set. 
signals = PC' * data; 

%{
disp('orig data');
size(data)
disp('proj data');
size(signals)

error('xxxxxxx');
%}



end

%{
function [ signals, PC, V ] = pca( data )
% Perform PCA. 
% Data is the data matrix having dimensions in the columns and each image vector in the rows
% data - of size M by N
% PC - the principal components
% V - M by 1 of variances
% proj - the projected data
% 


% Create the mean vector. This contains the means of each dimension
% of the data matrix (the cols)

[M,N] = size(data); 
mn = mean(data,2); 

% subtract the mean of each dimension from the data matrix
disp('subtracting means..');

data = data - repmat(mn,1,N); 

%calculate the convariance matrix. 
size(data)
disp('computing conv');

covariance = 1 / (N-1) * (data * data') ; 

disp('finding eig vals');
%find the eigen vectors and eigen values
[PC, V] = eig(covariance); 

%extract diagonal of matrix as vector which has the eigen values. 
V = diag(V); 

%sort the eigen values in decreasing order
[sorted, rindices] = sort(V, 'descend'); 


V = sorted; 

%rindices = rindices(1:20, :);
%size(rindices)

PC = PC(:, rindices); 

disp('doing projections');
%project the original data set. 
signals = PC' * data; 


disp('orig data');
size(data)
disp('proj data');
size(signals)

error('xxxxxxx');




end


%}