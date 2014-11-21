addpath(genpath('../util/'))
clear all; clear;clc
warning('off','all')
close all;

%% Parâmetros da rede
pTeste = 0.15;
%Número de iterações para o cálculo da acurácia
nIt = 10;
%Número máximo de epocas
maxEpoc = 250;
%Erro esperado para critério de parada
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
fprintf('Aplicação: MLP\n');
fprintf('Quantidade de padrões de treinamento: %2.2f. \n', (1-pTeste) * m);
fprintf('Quantidade de padrões de teste: %2.2f. \n', pTeste * m);
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
    

    %Plotando acurácias
    subplot(1,2,1)
    plot(gridnH(1:(length(acuracias)-1)) , acuracias(2:end))
    title([ 'Grid Search  ' base ]);
    xlabel('Número de neurônios')
    ylabel('Acurácia')
    drawnow
end

[v nh] = max(acuracias);
fprintf('Valores ótimos encontrados para  a quantidade de neurônios: %d. \n', gridnH(nh));


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
 fprintf('Avaliação concluída.');
 
 %% Gravando CM
filename = ['saida/MLP_confusion_'    base   '.csv'];
%saveconfusionMat(filename, cm, labels);
fprintf('Avaliação concluída.');
%exportEps(base);