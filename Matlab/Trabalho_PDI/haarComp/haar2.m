function H = haar2(N)

    for i=1:N/2
        j = i*2 -1;

        H(i,j) = 0.7071;
        H(i,j+1) = 0.7071;

        H(floor(i+N/2),j) = -0.7071;
        H(floor(i + N/2),j+1) = 0.7071;
    end
end