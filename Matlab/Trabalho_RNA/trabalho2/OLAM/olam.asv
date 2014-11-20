addpath(genpath('../util/'))
clear all; clear;clc
warning('off','all')

%%
pTeste = 0.25;
%Número de iterações para o cálculo da acurácia
nIt = 50;
%%
%Carregando dados
[ x , y ] = carregaDatabase('iris');

%Normalizando X.
[m n] =size(x);
mx = mean(x);
sx = std(x);
nx = (x - repmat(mx,m,1)) ./ repmat(sx,m,1);

acMedia = 0;
%%

for i=1:nIt

    [ xd yd xt yt ] = preparaDados( nx, y, pTeste);
    %Calculando Pesos  W = Y * X^-1
    in = pinv(xd);
    W = in * yd;

    %%Calculando Acuracia
    yc =  xt * W;
    [v sc] = max(yc');
    [v l] = max(yt');
    acuracia = sum( l == sc)/length(l);
    acMedia = acMedia + acuracia;
end

acMedia = acMedia/nIt;
acMedia



