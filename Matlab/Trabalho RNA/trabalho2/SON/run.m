addpath(genpath('../util/'))
clear all; clear;clc
warning('off','all')


%N�mero de itera��es para o c�lculo da acur�cia
nIt = 50;
%Percentual de amostras para teste
pTeste = 0.2;


 %%
 
%Carregando dados
[ x , y ] = carregaDatabase('iris');
[m n] = size(x);

%Normalizando X.
maxx = max(x);
maxx = repmat(maxx,[m 1]);

minx = min(x);
minx = repmat(minx,[m 1]);

nx = x - minx;
d = maxx - minx;
nx = nx ./d;


%%

net = som(nx(:,1:2) , 25);
























