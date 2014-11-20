addpath(genpath('../util/'))
clear all; clear;clc
warning('off','all')

%% Par�metros da rede
pTeste = 0.15;
%N�mero de itera��es para o c�lculo da acur�cia
nIt = 20;
%N�mero m�ximo de epocas
maxEpoc = 200;
%Erro esperado para crit�rio de parada
erroEsperado=0.01;
%Taxa de aprendizado
taxaAprend=0.1;
%%
gridnH = 3:2:20;

%% Carregando dados
base = 'derme';
[ x , y , labels] = carregaDatabase(base);
[m n] =size(x);
[m nClasses] =size(y);
%% Normalizando Dados
[m n] =size(x);
mx = mean(x);
sx = std(x);
nx = (x - repmat(mx,m,1)) ./ repmat(sx,m,1);

%% Mensagens...
fprintf('--------------------------------------------------\n');
fprintf('Aplica��o: MLP\n');
fprintf('Quantidade de padr�es de treinamento: %2.2f. \n', (1-pTeste) * m);
fprintf('Quantidade de padr�es de teste: %2.2f. \n', pTeste * m);
fprintf('Quantidade de classes: %d. \n', nClasses);
fprintf('Quantidade de atributos: %d. \n', n);
fprintf('--------------------------------------------------\n\n');
fprintf('Aguarde...\n\n');

acuracias = 0;
for nhIndex=1:length(gridnH)
    nh = gridnH(nhIndex);
    
    acMedia = 0;
    for i=1:nIt

        [ xd yd xt yt ] = preparaDados( nx, y, pTeste);

        [Wo Wh] = treinaMLP(xd,yd,-1,nh,taxaAprend,erroEsperado,maxEpoc);

        yc = mlpAvalia(xt , -1 , Wo , Wh) ;

        [v yci] = max(yc');
        [v ydi] = max(yt');

        acuracia = sum( yci == ydi)/length(ydi);
        acMedia = acMedia + acuracia;
    end
    acMedia = acMedia/nIt;
    acMedia
    acuracias = [acuracias acMedia];
end
subplot(1,2,1)
plot(acuracias)

return
 cm
 acMedia
 
 %%Gravando CM
 filename = ['saida/MLP_confusion_'    base   '.csv'];
 saveconfusionMat(filename, cm, labels);
 fprintf('Avalia��o conclu�da.');
