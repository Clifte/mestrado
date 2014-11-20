addpath(genpath('../util/'))
clear all; clear;clc
warning('off','all')
close all;

%% Par�metros da rede
pTeste = 0.25;
%N�mero de itera��es para o c�lculo da acur�cia
nIt = 20;
%%
gridnH = 3:3:100;

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
fprintf('Aplica��o: ELM\n');
fprintf('Quantidade de padr�es de treinamento: %2.2f. \n', (1-pTeste) * m);
fprintf('Quantidade de padr�es de teste: %2.2f. \n', pTeste * m);
fprintf('Quantidade de classes: %d. \n', nClasses);
fprintf('Quantidade de atributos: %d. \n', n);
fprintf('--------------------------------------------------\n\n');
fprintf('Aguarde...\n\n');

acuracias = [];
for nhIndex=1:length(gridnH)
    nh = gridnH(nhIndex);
    
    acMedia = 0;
    for i=1:nIt

        [ xd yd xt yt ] = preparaDados( nx, y, pTeste);

        [Wh Wm]=treinaELM(xd,yd,nh);
        yc = avaliaElm(xt,Wh,Wm);

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

     [Wh Wm]=treinaELM(xd,yd,gridnH(nh));
     yc = avaliaElm(xt,Wh,Wm);

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
filename = ['saida/ELM_confusion_'    base   '.csv'];
saveconfusionMat(filename, cm, labels);
fprintf('Avalia��o conclu�da.');
exportEps(base);