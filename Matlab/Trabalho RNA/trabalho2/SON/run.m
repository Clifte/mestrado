addpath(genpath('../util/'))
clear all; clear;clc
warning('off','all')


%Número de iterações para o cálculo da acurácia
nIt = 50;
%Percentual de amostras para teste
pTeste = 0.2;


 %%
 
%Carregando dados
[ x , y ] = carregaDatabase('iris');

%Normalizando X.
[m n] =size(x);
mx = mean(x);
sx = std(x);
nx = (x - repmat(mx,m,1)) ./ repmat(sx,m,1);

%%

net = som(x(:,1:2) , 25);
























