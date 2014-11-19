% Limpeza da tela e vari�veis da mem�ria.
addpath(genpath('../util/'))
clear all; clear;clc
warning('off','all')

%%
%N�mero de neur�nios
q = 60;
%Taxa de aprendizagem
alpha = 0.8;

% Tamanho vizinhan�a
nn = 10;
%N�mero de �pocas
epochs = 10;
%Particionamento para testes
pTeste = 0.25;
%%

%Carregando dados
[ x , y ] = carregaDatabase('iris');
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


% Defini��o dos raios
sigmas = linspace(1.2,0.001,epochs);

% Defini��o da taxa de aprendizado;
eta = linspace(alpha, 0.01, m * q * epochs);


% Impress�o de cabe�alho.
fprintf('--------------------------------------------------\n');
fprintf('Modelo utilizado: SOM. \n');
fprintf('Quantidade de padr�es de treinamento: %d. \n', (1-pTeste) * m);
fprintf('Quantidade de padr�es de teste: %d. \n', pTeste * m);
fprintf('Quantidade de classes: %d. \n', nClasses);
fprintf('Quantidade de atributos: %d. \n', n);
fprintf('--------------------------------------------------\n\n');

%n repeticoes
repet = 5;
for r = 1:repet
    
    % Randomizar e particiona dados base de dados.
    [xd yd xt yt] = preparaDados(nx,y,pTeste);
    
    %****************Treinando************************
    [w] = trainSOM(xd(:,[1 2]), q, nn, epochs, eta, sigmas);
    
    %**************** Rotula��o dos neur�nios************************
    [v yd] = max(yd');
    [l] = labelNeuron(xd(:,[1 2]),yd, w,nn);
    
    % =============================================================================
    %                           Valida��o da rede
    % =============================================================================
    
    
    %[accuracy(r), numRight(r)] = evaluateSOM(vt, att, m);
    %fprintf('Acur�cia: %d / %d, %.1f%%. \n\n', numRight, size(vt,1), accuracy);
    return
end

fprintf('--------------------------------------------------\n');
fprintf('Resultado ap�s %d Realiza��es da taxa de acerto: \n', r);
fprintf('M�dia:  %.2f%%. \n', mean(accuracy));
fprintf('M�ximo: %.2f%%. \n', max(accuracy));
fprintf('M�nimo: %.2f%%. \n', min(accuracy));
fprintf('Vari�ncia: %.2f. \n', var(accuracy));
fprintf('--------------------------------------------------\n');