%{
Saída (0) é a entrada da rede
Saída (Size - 1) é a saída da rede

%}
function [yj] = mlpAvalia(xii,Wo,Wh)    
    yj = tanh(xii*Wh);
    yj = tanh(yj * Wo);
end