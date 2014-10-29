%%
%N�mero de de neur�nios da camada de entrada � definida pela quantidade de
%elementos da primeira hidenLayer
%%
function [Wo Wh] =treinaMLP(x,y,n,eta)

%Xm = N�mero de amostras
%Xn = N�mero de caracter�sticas
[xm xn] = size(x);
[ym yn] = size(y);


Wo = rand(n,yn);
Wh = rand(xn,n);



for i=1:xm
    xii = x(i,:);
    yii = y(i,:);

    
    %Calculando sa�da da camada oculta
    yhc = tanh(xii*Wh);
    
    %Calculando total sa�da da rede
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