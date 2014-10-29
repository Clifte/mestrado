%%
%Número de de neurônios da camada de entrada é definida pela quantidade de
%elementos da primeira hidenLayer
%%
function [Wo Wh] =treinaMLP(x,y,n,eta)

%Xm = Número de amostras
%Xn = Número de características
[xm xn] = size(x);
[ym yn] = size(y);


Wo = rand(n,yn);
Wh = rand(xn,n);



for i=1:xm
    xii = x(i,:);
    yii = y(i,:);

    
    %Calculando saída da camada oculta
    yhc = tanh(xii*Wh);
    
    %Calculando total saída da rede
    yc = tanh(yhc * Wo);
    
    %Calculando o erro
    e = yii - yc;
   
    
    
    dYh = sech(yhc)  .* sech(yhc);
    dWo = eta * dYh * e * yhc;
    
    Wo = Wo + dWo;
    
    
    dY = sech(xii)  .* sech(xii);
    eh = e*dYh*Wo;
    dWh = Wh + eta * dYh * eh * xii;
    
    Wh = Wh + dWh;
end

end