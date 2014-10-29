addpath(genpath('../util/'))
clear all; clear;clc
warning('off','all')

%%
pTeste = 0.25;
%%
%Carregando dados
[ x , y ] = carregaDatabase('iris');

%Normalizando X.
[m n] =size(x);
mx = mean(x);
sx = std(x);
nx = (x - repmat(mx,m,1)) ./ repmat(sx,m,1);


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


[Wo Wh] = treinaMLP(xd,yd,10,0.05)