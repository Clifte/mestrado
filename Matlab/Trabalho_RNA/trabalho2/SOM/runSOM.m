% Limpeza da tela e variáveis da memória.
addpath(genpath('../util/'))
clear all; clear;clc;close all;
warning('off','all')

%%
%Número de neurônios
q = 30;
%Taxa de aprendizagem
alpha = 0.8;

% Tamanho vizinhança
nn = 5;
%Número de épocas
epochs = 10;
%Particionamento para testes
pTeste = 0.25;
%%
cores = linspace(1,100,10);
%Carregando dados
base = 'vertebra'
[ x , y ] = carregaDatabase(base);
[m n] = size(x);
[nsamples nClasses] = size(y);
%%
%Normalizando X.
maxx = max(x);
maxx = repmat(maxx,[m 1]);

minx = min(x);
minx = repmat(minx,[m 1]);

nx = x - minx;
d = maxx - minx;
nx = nx ./d;

%%
% Definição dos raios
sigmas = linspace(1.2,0.001,epochs);

% Definição da taxa de aprendizado;
eta = linspace(alpha, 0.01, m * q * epochs);


fprintf('--------------------------------------------------\n');
fprintf('Modelo utilizado: SOM. \n');
fprintf('Quantidade de padrões de treinamento: %d. \n', (1-pTeste) * m);
fprintf('Quantidade de padrões de teste: %d. \n', pTeste * m);
fprintf('Quantidade de classes: %d. \n', nClasses);
fprintf('Quantidade de atributos: %d. \n', n);
fprintf('--------------------------------------------------\n\n');

%n repeticoes
repet = 1;
for r = 1:repet
    
    % Randomizar e particiona dados base de dados.
    [xd yd xt yt] = preparaDados(nx,y,pTeste);
    [v yt] = max(yt');
    %****************Treinando************************
    [w] = trainSOM(xd, q, nn, epochs, eta, sigmas);
    
    %**************** Rotulação dos neurônios************************
    [v yd] = max(yd');
    [l] = labelNeuron(xd,yd, w, nn);
    
    % =============================================================================
    %                           Validação da rede
    % =============================================================================
    
    
    r = avaliaSOM(w, l, xt);
    
    figure;
    acuracia = sum(r==yt)/length(yt)
    title('resultado')
    scatter(xt(:,1),xt(:,2),[],cores(r),'v','filled')
    hold on
    scatter(xt(:,1),xt(:,2),[],cores(yt),'s')
end



exportEps(base);



