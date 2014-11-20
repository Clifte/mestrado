addpath(genpath('../util/'))
clear all; clear;clc
warning('off','all')

%%
pTeste = 0.25;
%Número de iterações para o cálculo da acurácia
nIt = 50;
%%
%Carregando dados
base = 'vertebra';
[ x , y ,labels ] = carregaDatabase(base);
[m n] =size(x);
[m nClasses] =size(y);


%Normalizando X.
[m n] =size(x);
mx = mean(x);
sx = std(x);
nx = (x - repmat(mx,m,1)) ./ repmat(sx,m,1);

acMedia = 0;
%%
fprintf('--------------------------------------------------\n');
fprintf('Aplicação: OLAM\n');
fprintf('Quantidade de padrões de treinamento: %2.2f. \n', (1-pTeste) * m);
fprintf('Quantidade de padrões de teste: %2.2f. \n', pTeste * m);
fprintf('Quantidade de classes: %d. \n', nClasses);
fprintf('Quantidade de atributos: %d. \n', n);
fprintf('--------------------------------------------------\n\n');
fprintf('Aguarde...\n\n');


 cm = zeros(nClasses,nClasses);
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
    
    [c o] = confusionmat(int32(l),int32(sc));
    cm(o,o) = cm(o,o) + c;
end

acMedia = acMedia/nIt;
acMedia
cm

filename = ['saida/MLP_confusion_'    base   '.csv'];
saveconfusionMat(filename, cm, labels);