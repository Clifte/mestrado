addpath(genpath('../util/'))
clear all; clear;clc
warning('off','all')

%%
pTeste = 0.1;
%N�mero de itera��es para o c�lculo da acur�cia
global mlpRegressao;
mlpRegressao = true;
nIt = 1;
erro = 0.001;
%%
%Carregando dados
x = (0:0.01:2 * pi)';
y = (sin(x) + sin(2*x));


%Normalizando X.
[m n] =size(x);
mx = mean(x);
sx = std(x);
nx = (x - repmat(mx,m,1)) ./ repmat(sx,m,1);


acMedia = 0;

for i=1:nIt

    [ xd yd xt yt ] = preparaDados( nx, y, pTeste);
    
    [Wo Wh] = treinaMLP(xd,yd,-1,5,0.1,erro,10000,'tangh','linear');

    yc = mlpAvalia(xt , -1 , Wo , Wh) ;

    acuracia = sum(abs(yc - yt))/length(yt)
    acMedia = acMedia + acuracia;
end
acMedia = acMedia/nIt;
erroMedio = acMedia
