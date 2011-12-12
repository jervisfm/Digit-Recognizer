

function r = darken(A)
%convert from white background to black background

    rows = size(A,1);
    cols = size(A,2);

    for i = 1:rows
        for j = 1:cols
            if(A(i,j) == 1)
                A(i,j) = 0;
            else
                A(i,j) = 1; %prev was : 1 - A(i,j). right now we're binarizing img. 
            end
        end
    end
    
    r = A; 
end

