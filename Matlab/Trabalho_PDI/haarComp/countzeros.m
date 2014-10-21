function[zcount] = countzeros(I)

sz = size(I);

zcount = 0;
for i = 1:sz(1)
    for j = 1:sz(2)
        if I(i,j) == 0
            zcount = zcount + 1;
        end
    end
end
