%{
Sa�da (0) � a entrada da rede
Sa�da (Size - 1) � a sa�da da rede

%}
function [yc] = mlpAvalia(xii,bias,Wo,Wh)    

        [m n] = size(xii);
        [hm hn] = size(Wh);

        %Calculando sa�da da camada oculta
        yhc = [bias*ones(m,1) xii] * Wh;
        yhc = 1 ./ (1+exp(-yhc));

        %Adicionando Bias
        yhc = [bias*ones(m,1)  yhc];

        %Calculando total sa�da da rede
        yc = yhc * Wo;
        yc = 1./(1+exp(-yc));
end