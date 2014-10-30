%{
Saída (0) é a entrada da rede
Saída (Size - 1) é a saída da rede

%}
function [yc] = mlpAvalia(xii,bias,Wo,Wh)    

        [m n] = size(xii);
        [hm hn] = size(Wh);

        %Calculando saída da camada oculta
        yhc = [bias*ones(m,1) xii] * Wh;
        yhc = 1 ./ (1+exp(-yhc));

        %Adicionando Bias
        yhc = [bias*ones(m,1)  yhc];

        %Calculando total saída da rede
        yc = yhc * Wo;
        yc = 1./(1+exp(-yc));
end