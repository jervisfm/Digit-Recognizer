
%extracts just the outline of the number. find find the topleft pixel and
% the bottom right pixel. 
function r = extract(A)
    r = size(A,1);
    c = size(A,2); 

    x = [];
    y = [];
    for i=1:r
       for j=1:c
            if(A(i,j) == 1)
                x = [x; i];
                y = [y; j];
            end
       end
    end
    
    minx = min(x);
    maxx = max(x);
    miny = min(y);
    maxy = max(y);
    
    r = A(minx:maxx,miny:maxy);
    
end

