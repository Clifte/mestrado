%%
%N�mero de de neur�nios da camada de entrada � definida pela quantidade de
%elementos da primeira hidenLayer
%%
function [Wo Wh] =treinaMLP(x,y,bias,nh,eta,erro,maxEpoca)

%Xm = N�mero de amostras
%Xn = N�mero de caracter�sticas
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


        %Calculando sa�da da camada oculta
        yhc = xii*Wh;
        yhc = 1./(1+exp(-yhc));

        %Adicionando Bias
        yhc = [bias  yhc];

        %Calculando total sa�da da rede
        yc = yhc * Wo;
        yc = 1./(1+exp(-yc));

        %Calculando o erro
        e = yii - yc;


        errM = errM + mean(e.^2);

        %atualizando pesos da sa�da
        dYc = yc.*(1-yc);
        gYc = dYc .* e;

        dWo = eta * (gYc)' * yhc;
        Wo = Wo + dWo';


        %atualizando pesos da camada oculta
        dYhc = yhc.*(1-yhc);

        gYhc = dYhc' .* (Wo *gYc');
        gYhc = gYhc(2:end);

        dWh = eta * gYhc * xii;
        Wh = Wh + dWh';
    end
    
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