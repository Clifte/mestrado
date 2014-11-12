addpath(genpath('../util/'))
clear all; clear;clc
warning('off','all')

%%
pTeste = 0.1;
%Número de iterações para o cálculo da acurácia
global mlpRegressao;
mlpRegressao = true;
nIt = 1;

%%
%Carregando dados
x = (0:0.001:2 * pi)';
y = (sin(x) + sin(2*x));


%Normalizando X.
[m n] =size(x);
mx = mean(x);
sx = std(x);
nx = (x - repmat(mx,m,1)) ./ repmat(sx,m,1);


acMedia = 0;

for i=1:nIt

    [ xd yd xt yt ] = preparaDados( nx, y, pTeste);
    
    [Wh Wm] = treinaELM(xd,yd,40);

    subplot(1,2,1);
    plot(xd,yd,'.r');hold on;
    plot(xd,avaliaElm(xd,Wh,Wm),'.b');

    yc = avaliaElm(xt,Wh,Wm);
    plot(xt,yc,'.y');   
    acuracia = sum(abs(yc - yt))/length(yt)
    acMedia = acMedia + acuracia;
end
acMedia = acMedia/nIt;
erroMedio = acMedia
