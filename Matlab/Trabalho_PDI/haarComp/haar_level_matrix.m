function[X] = haar_level_matrix(n,level)

if level == 1
    for col = 1:n/2
        X((col-1)*2 +1,col) = 1/sqrt(2);
        X((col-1)*2 +2,col) = 1/sqrt(2);    
    end

    for col = n/2+1:n
        X((col-1)*2 +1 - n,col) = 1/sqrt(2);
        X((col-1)*2 +2 - n ,col) = -1/sqrt(2);    
    end
else
    ac = n/(2.^(level-1));
    X = haar_level_matrix(ac,1);
    for i = ac+1:n
        X(i,i) = 1;
    end
end
