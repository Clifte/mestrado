%%
%N�mero de de neur�nios da camada de entrada � definida pela quantidade de
%elementos da primeira hidenLayer
%%
function treinaMLP(x,y,n,hidenLayers)

%Xm = N�mero de amostras
%Xn = N�mero de caracter�sticas
[xm xn] = size(x);
[ym yn] = size(y);

[net] = criaRede(xn, yn, hidenLayers);


for i=1:xm
    xii = x(i,:);
    yii = y(i,:);

    [yc  saidasP ] = mlpAvalia(xii,net);

    mlpCorrige(net,n,xii,yii,saidasP);
    
    
    
end

end