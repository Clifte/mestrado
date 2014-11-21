addpath(genpath('../util/'))
clear all; clear;clc
warning('off','all')
close all;

%% Par�metros da rede
pTeste = 0.15;
%N�mero de itera��es para o c�lculo da acur�cia
nIt = 10;
%N�mero m�ximo de epocas
maxEpoc = 250;
%Erro esperado para crit�rio de parada
erroEsperado=0.01;
%Taxa de aprendizado
taxaAprend=0.1;
%%
gridnH = 3:2:20;

%% Carregando dados
base = 'vertebra';
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

        [Wo Wh] = treinaMLP_R(xd,yd,-1,nh,taxaAprend,erroEsperado,maxEpoc);
        legend(labels)
        
        yc = mlpAvalia(xt , -1 , Wo , Wh) ;

        [v yci] = max(yc');
        [v ydi] = max(yt');

        acuracia = sum( yci == ydi)/length(ydi);
        acMedia = acMedia + acuracia;
    end
    acMedia = acMedia/nIt;
    acuracias = [acuracias acMedia];
    

    %Plotando acur�cias
    subplot(1,2,1)
    plot(gridnH(1:(length(acuracias)-1)) , acuracias(2:end))
    title([ 'Grid Search  ' base ]);
    xlabel('N�mero de neur�nios')
    ylabel('Acur�cia')
    drawnow
end

[v nh] = max(acuracias);
fprintf('Valores �timos encontrados para  a quantidade de neur�nios: %d. \n', gridnH(nh));


%% Avaliando desempenho
 
 fprintf('Avaliando desempenho final.\n');
 acuracia = 0;
 acMedia = 0;
 cm = zeros(nClasses,nClasses);
for i=1:nIt

    [xd yd xt yt] = preparaDados(nx,y,pTeste);

    [Wo Wh] = treinaMLP_R(xd,yd,-1,gridnH(nh),taxaAprend,erroEsperado,maxEpoc);
    legend(labels)

    yc = mlpAvalia(xt , -1 , Wo , Wh) ;

    [v yci] = max(yc');
    [v ydi] = max(yt');
    
    [c o] = confusionmat(int32(yci),int32(ydi));
    cm(o,o) = cm(o,o) + c;

    acuracia = sum( yci == ydi)/length(ydi);
    acMedia = acMedia + acuracia;
end
        
 acMedia = acMedia/nIt;  

 cm
 acMedia
 fprintf('Avalia��o conclu�da.');
 
 %% Gravando CM
filename = ['saida/MLP_confusion_'    base   '.csv'];
%saveconfusionMat(filename, cm, labels);
fprintf('Avalia��o conclu�da.');
%exportEps(base);