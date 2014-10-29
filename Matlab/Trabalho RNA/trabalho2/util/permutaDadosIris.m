function [x y ] = permutaDadosIris(x,y)
    indP = [  randperm(50)          randperm(50) + 50         randperm(50) + 100];
    x = x(indP,:);
    y = y(indP,:);
end