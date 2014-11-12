%%
%Número de de neurônios da camada de entrada é definida pela quantidade de
%elementos da primeira hidenLayer
%%
function [Wo Wh] =treinaMLP(x,y,bias,nh,eta,erro,maxEpoca)

%Xm = Número de amostras
%Xn = Número de características
[xm xn] = size(x);
[ym yn] = size(y);

%Adicionando mais um para o bias
Wo = rand(nh+1,yn);
Wh = rand(xn+1, nh);
errM = zeros(1,yn);


for epc=1:maxEpoca
    errM = zeros(1,yn);
    for i=1:xm
        xii = [bias  x(i,:)] ;
        yii = y(i,:);


        %Calculando saída da camada oculta
        yhc = xii*Wh;
        [ yhc , dYhc] = function_ativ(yhc,'logistica');
       
        %Adicionando Bias
        yhc = [bias  yhc];
                
        %Calculando total saída da rede
        yc = yhc * Wo;
        [ yc , dYc] = function_ativ(yc,'linear');

        
        %Calculando o erro
        e = yii - yc;

        errM = errM + mean(e.^2);

        %atualizando pesos da saída
        gYc = dYc .* e;
        dWo = eta * (gYc)' * yhc;
        Wo = Wo + dWo';


        %atualizando pesos da camada oculta
        gYhc = dYhc' .* (Wo(2:end,:) * gYc');

        dWh = eta * gYhc * xii;
        Wh = Wh + dWh';
    end
    
    
%     plot(x,y,'.r');
%     hold
%     plot(x, mlpAvalia(x , -1 , Wo , Wh),'.b');
%     drawnow;
%     hold
    
    errM = errM / xm;
    errMarr(epc,:) = errM;
    
    if(errM<erro)
        break
    else
        plot(errMarr);
        drawnow;
    end
end

end