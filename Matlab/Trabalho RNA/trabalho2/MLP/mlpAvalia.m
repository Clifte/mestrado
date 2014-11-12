%{
Saída (0) é a entrada da rede
Saída (Size - 1) é a saída da rede

%}
function [yc] = mlpAvalia(xii,bias,Wo,Wh,f1,f2)
        if nargin < 5
            f1 = 'tangh';
        end
        
        if nargin < 6
           f2 = f1;
        end

        [m n] = size(xii);
        [hm hn] = size(Wh);
        
        %Calculando saída da camada oculta
        yhc = [bias * ones(m,1) xii] * Wh;
        
        [ yhc , dYhc] = function_ativ(yhc,f1);
        
        %Adicionando Bias
        yhc = [bias*ones(m,1)  yhc];

        %Calculando total saída da rede
        yc = yhc * Wo;
        [ yc , dYc] = function_ativ(yc,f2);
end