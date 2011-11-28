% Jervis Muindi
% 28th November 2011
% Code to read in MNIST Binary data files

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
colSize = fread(file,1,'int32') % number of columsn

for i = 1: imagesNo
    train_data{i} = uint8(fread(file, [rowSize colSize], 'uchar')); 
    
    x = train_data{1}
    y = fread(file, [rowSize colSize], 'uint8')
    
    if( x == y) 
        disp('they are equal');
    else
        disp('NOT EQUAL');
    end
    
    xd = double(x);
    yd = double(y);
    
    xd = xd / max(xd(:)) ;
    close all;
    figure(1);
    imshow(xd);
    
    if(i == 2)
        error('stop');
    end
end

