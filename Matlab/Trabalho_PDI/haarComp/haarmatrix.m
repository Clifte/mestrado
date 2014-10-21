function[X] = haarmatrix(n)

lmax = 0;

for i=1:n
    if mod(n,2^i) == n
        lmax = i-1;
        break;
    end
end

X = 1;

for i=1:lmax
    X = X*haar_level_matrix(n,i);
end