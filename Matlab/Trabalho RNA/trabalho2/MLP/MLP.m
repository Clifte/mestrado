addpath(genpath('../util/'))
clear all; clear;clc
warning('off','all')

%%
pTeste = 0.25;
%Número de iterações para o cálculo da acurácia
nIt = 10;
%%
%Carregando dados
[ x , y ] = carregaDatabase('iris');

%Normalizando X.
[m n] =size(x);
mx = mean(x);
sx = std(x);
nx = (x - repmat(mx,m,1)) ./ repmat(sx,m,1);


acMedia = 0;

for i=1:nIt

    %Embaralhando DataSet
    indicePermut = randperm(m);
    xp = nx(indicePermut , :);
    yp = y(indicePermut , :);

    %Particionando dados
    %Dados de teste
    tp = m*pTeste;
    xt = xp(1:tp,:);
    yt = yp(1:tp,:);

    %Dados de treinamento
    xd = xp((tp+1):end,:);
    yd = yp((tp+1):end,:);


    [Wo Wh] = treinaMLP(xd,yd,-1,20,0.05,0.01,1000);

    yc = mlpAvalia(xt , -1 , Wo , Wh) ;

    [v yci] = max(yc');
    [v ydi] = max(yt');
    % cm = cm + confusionmat(int32(yci),int32(ydi));

    acuracia = sum( yci == ydi)/length(ydi)
    acMedia = acMedia + acuracia;
end
acMedia = acMedia/nIt;
acMedia
