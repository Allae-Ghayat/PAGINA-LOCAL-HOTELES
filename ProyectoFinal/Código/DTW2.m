% Dynamic Time Warping (DTW)
function distancia = DTW2(p,t)

    n = length(p);
    m = length(t);
    DTW = zeros(n+1,m+1);
    
    DTW(2:end,1) = inf;
    DTW(1,2:end) = inf;
    DTW(1,1) = 0;
       
    for i=2:n+1
        for j=2:m+1
            if((i-1) <= size(p,2) && (j-1) <= size(t,2))
                dist = pdist2(p(:,i-1)',t(:,j-1)','euclidean');
                DTW(i,j) = dist + min(DTW(i-1,j), min(DTW(i,j-1), DTW(i-1,j-1)));
            end
        end
    end
    distancia = DTW(n+1,m+1);
end