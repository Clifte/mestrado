addpath(genpath('../util/'))
clear all; clear;clc
warning('off','all')

%%
pTeste = 0.25;
%Número de iterações para o cálculo da acurácia
nIt = 10;
%%
%Carregando dados
x = (0:0.1:2*pi)';
y = (sin(x) + sin(2*x));

%Normalizando X.
[m n] =size(x);
mx = mean(x);
sx = std(x);
nx = (x - repmat(mx,m,1)) ./ repmat(sx,m,1);


acMedia = 0;

for i=1:nIt

    [ xd yd xt yt ] = preparaDados( nx, y, pTeste);
    
    [Wo Wh] = treinaMLP(xd,yd,-1,4,0.05,0.01,10000);

    yc = mlpAvalia(xt , -1 , Wo , Wh) ;

    [v yci] = max(yc');
    [v ydi] = max(yt');
    % cm = cm + confusionmat(int32(yci),int32(ydi));

    acuracia = sum( yci == ydi)/length(ydi)
    acMedia = acMedia + acuracia;
end
acMedia = acMedia/nIt;
acMedia
