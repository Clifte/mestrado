%{
Sa�da (0) � a entrada da rede
Sa�da (Size - 1) � a sa�da da rede

%}
function [yj] = mlpAvalia(xii,Wo,Wh)    
    yj = tanh(xii*Wh);
    yj = tanh(yj * Wo);
end