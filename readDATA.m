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
colSize = fread(file,1,'int32'); % number of columsn


% Lesson learnt
% 1) giving a matrix size when using matlab fread, what you get is a image
% matrix that has been tranposed. To undo, this operation, we simply
% tranpose it once AND then it is the same format and it would have been if
% we had read in the data manually one byte at a time.
%
% 2)the other  choice is of course to read in the image pixel
% values of the 28x28 image, one at a time, to an array. 
% 
% 3) there is NO difference in matlab between uint8 and ubit8 are interpretted.  
%

%{
    %  read in a single digit
c = 1;
a = [];
for s = 1:784
   ss = fread(file, 1 , 'ubit8') ;  % ubit8 read in correctly.WORKS. need to parse manually though .
   %ss = uint8(ss);
   a = [a; ss];
   fprintf('%d) %x\n', c, ss); 
   %fprintf('%x\n', ss); 
   c = c + 1;
   
end

c = 1;
for i = 1:28
    for j = 1:28
        x(i,j) = a(c);
        c = c+1;
    end
end

x

error('aaaaa');
%}



%{
%read in a whole image with matlab array. 
for s = 1:1
   ss = fread(file, [rowSize colSize] , 'ubit8') ; 
   [rr,cc] = size(ss);
   
   
   ss'
   %ss = ss';
   
   error('xxxxxx');
   
   c = 0;
   for ii = 1:rr
       for jj = 1:cc
           t = ss(ii,jj);
           %t = ss(jj,ii);
           fprintf('%x\n',t);
            c = c + 1;
       end
   end
   disp('');
   disp(c);
   error('sssssssxxxx');
end
%}




%error('early sttop...');

X = [];
for i = 1: imagesNo
    %train_data{i} = uint8(fread(file, [rowSize colSize], 'uchar')); 
    
    %x = train_data{1}  % WRONG METHOD .. prints 5 like symbol all the time
    y = fread(file, [rowSize colSize], 'uint8') ; % Looks OKay, BUT was confirmed NOT to match training labels
    %y = fread(file, [rowSize colSize], 'ubit8') ;
    
    y'
    %error('rrrrrrrrrrrrrrr');
   
    

    yd = double(y);
    
    yd = yd / 255 ;
    
    X = [X ; yd]; 
    
    if(i == 10)
        
        disp(X); 

        
        break;
        
        
    end
end
    close all;
    figure(1);
    X'
    imshow(X');
    
    error('tttttttt');
    
    size(xd);
    
    xr = X;
    xr(1:end,:) = xr(end:-1:1,:); % mirror the image. 
    xr = imrotate(xr,-90);
    
    %xr = imresize(xr, 4); %dont resize
    imshow(xr);
    size(xr);
    %imwrite.  save to file
    
 %error('s');
 
    fclose(file); 
    
path = '.\MNIST\train-labels.idx1-ubyte';
file = fopen(path, 'r', 'b'); %b is for big-endian. 

    magicNumber = fread(file,1,'int32'); 
if(magicNumber ~= 2049)
    disp('Error: Cannot find magic number of 2051. Please check to make sure that file is in IDX format');
    return; % stop processsing
end


itemsNo = fread(file,1,'int32'); % Number of Labelled Items Samples 

%disp(colSize);




    for j = 1:itemsNo
       train_labels{j} = fread(file, 1, 'ubit8');
       
       rr = train_labels{j};
       
       fprintf('%d) We have %d\n',j,rr);
       if(j == 1)
           break;
       end
    end
    





