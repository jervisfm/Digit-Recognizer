
function r = binarize(A)

    r = size(A,1);
    c = size(A,2); 
    
    for i=1:r
        for j = 1:c
            
            if(A(i,j) > 0.1)
                A(i,j) = 1;
            else
                A(i,j) = 0; 
            end
            
        end
    end
    
    r=A;

end
