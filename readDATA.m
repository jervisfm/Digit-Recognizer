% Jervis Muindi
% 28th November 2011
% MATLAB Code to read in MNIST Binary data files
% obtained from http://yann.lecun.com/exdb/mnist/

%Function return values: 
% train_data -> cell array that has the training image matrices
% train_labels -> cell array that has the actual values of the train data
% images
% test_data -> test data image matrix
% test_labels -> test data image matrix labels
function [train_data, train_labels, test_data, test_labels] = readDATA()

path = '.\MNIST\train-images.idx3-ubyte';

%Note: Big endian means that a number is represented in a way such that
% the most significant bit is first. This is typical/consistent with how 
% we value magnitude of normal numbers. E.g. in 10 in big-endian, the MSB is 1. 
file = fopen(path, 'r', 'b'); %b is for big-endian. 

%{
Format of train image files is as follows :
[offset] [type]          [value]          [description] 
0000     32 bit integer  0x00000803(2051) magic number 
0004     32 bit integer  60000            number of images 
0008     32 bit integer  28               number of rows 
0012     32 bit integer  28               number of columns 
0016     unsigned byte   ??               pixel 
0017     unsigned byte   ??               pixel 
........ 
xxxx     unsigned byte   ??               pixel
%}

magicNumber = fread(file,1,'int32'); 
if(magicNumber ~= 2051)
    disp('Error: Cannot find magic number of 2051. Please check to make sure that file is in IDX format');
    return; % stop processsing
end

imagesNo = fread(file,1,'int32'); % Number of Image Samples
rowSize = fread(file,1,'int32'); %Number of Rows
colSize = fread(file,1,'int32'); % number of columns


% Lessons learnt
% 1) giving a matrix size as an argument when using matlab fread, what you get is a image
% matrix that has been tranposed. To undo this, we simply tranpose it once
% AND then it is the same format and it would have been if we had read 
% in the data manually one byte at a time.
%
% 2) the other choice is of course to read in the image pixel
% values of the 28x28 image, one byte at a time, to an array. 
% 
% 3) there is NO difference in matlab between how uint8 and ubit8 are
% interpretted in the context of this data.  


%Read in the actual training data. 
for i = 1: imagesNo
    img_sample = fread(file, [rowSize colSize], 'uint8') ;  % pixel values stored as a single unsigned byte
    img_sample =  img_sample'; % transpose it so that image matrix faithfully represents stored binary data. See lessons learnt section above. 
    
    %Convert the values to doubles and normalize the image matrix by the
    %maximum value. 
    img_sample = double(img_sample); 
    img_sample = img_sample / max(img_sample(:));
    
    train_data{i} = img_sample; 
end

fclose(file); %close file handle. 


%{
Format of training label binary file is as follows: 
[offset] [type]          [value]          [description] 
0000     32 bit integer  0x00000801(2049) magic number (MSB first) 
0004     32 bit integer  60000            number of items 
0008     unsigned byte   ??               label 
0009     unsigned byte   ??               label 
........ 
xxxx     unsigned byte   ??               label
The labels values are 0 to 9.
%}
%% Read in the Training Labels. 
path = '.\MNIST\train-labels.idx1-ubyte';
file = fopen(path, 'r', 'b'); %b is for big-endian. 

magicNumber = fread(file,1,'int32'); 
if(magicNumber ~= 2049)
    disp('Error: Cannot find magic number of 2049. Please check to make sure that file is in IDX format');
    return; % stop processsing
end

itemsNo = fread(file,1,'int32'); % Number of Labelled Items Samples 
for j = 1:itemsNo
   train_labels{j} = fread(file, 1, 'uint8');
end

fclose(file); 

%% Read in the Test Data
path = '.\MNIST\t10k-images.idx3-ubyte';
file = fopen(path, 'r', 'b'); %b is for big-endian. 

magicNumber = fread(file,1,'int32'); 
if(magicNumber ~= 2051)
    disp('Error: Cannot find magic number of 2051. Please check to make sure that file is in IDX format');
    return; % stop processsing
end

testImagesNo = fread(file,1,'int32'); % Number of Image Samples
rowSize = fread(file,1,'int32'); %Number of Rows
colSize = fread(file,1,'int32'); % number of columns

%read in the actual data
for i = 1: testImagesNo
    img = fread(file, [rowSize colSize], 'uint8') ;  % pixel values stored as a single unsigned byte
    img =  img'; % transpose it so that image matrix faithfully represents stored binary data. See lessons learnt section above. 
   
    %Convert the values to doubles and normalize the image matrix by the
    %maximum value. 
    img = double(img); 
    img = img / max(img(:));
    
    test_data{i} = img; 
end

fclose(file); 

%% Read in the Test Data Labels
path = '.\MNIST\t10k-labels.idx1-ubyte';
file = fopen(path, 'r', 'b'); %b is for big-endian. 

magicNumber = fread(file,1,'int32'); 
if(magicNumber ~= 2049)
    disp('Error: Cannot find magic number of 2049. Please check to make sure that file is in IDX format');
    return; % stop processsing
end

itemsNo = fread(file,1,'int32'); % Number of Labelled Items Samples 
for j = 1:itemsNo
   test_labels{j} = fread(file, 1, 'uint8');
end

disp('MNIST Data successully loaded');
