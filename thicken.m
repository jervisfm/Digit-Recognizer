
%thickens number outline
function r = thicken(A)

    %essentially binarize image. 
    rows = size(A,1);
    cols = size(A,2);
    
    A = binarize(A);
    
    
    %then we add a 1-px to outline to thicken it. 
    
    thickness = 3;
    
    for i = 1:rows
        for j = 1:cols
            if(A(i,j) == 0) % at a zero pixel
                %check if border pixel ahead to the east. 
                if( j+thickness <= cols &&  A(i,j+thickness) == 1) % check east
                    
                    for x = 1:thickness
                       A(i,j+x-1) = 1;
                    end
                    %A(i,j) = 1;
                    
                end
                
                if( i+thickness <= rows &&  A(i+thickness,j) == 1) % check south
                    
                    for x = 1:thickness
                        A(i+x-1,j) = 1;
                    end
                    %A(i,j) = 1;
                    
                end
              
                
            end
        end
    end
    
    
    
    r = A; 
end
