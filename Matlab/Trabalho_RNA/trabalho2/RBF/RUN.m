addpath(genpath('../util/'))
clear all; clear;clc
warning('off','all')

%%
%Carregando dados
base = 'derme';

[ x , y , labels] = carregaDatabase(base);
[m nClasses] = size(y);
[m n] =size(x);

%%
%Grid search para o valor do sigma e o número de NH
gridS = (0.1:0.25:10);
gridnH = 5:1:12;

%Número de iterações para o cálculo da acurácia
nIt = 5;
%Percentual de amostras para teste
pTeste = 0.2;


%%

%Normalizando X.
[m n] =size(x);
mx = mean(x);
sx = std(x);
nx = (x - repmat(mx,m,1)) ./ repmat(sx,m,1);

%Matriz confusão
ss=1;
medias = zeros(1,length(gridS) + length(gridnH));
gSearchAcc = zeros (length(gridnH),length(gridS));



%%
fprintf('--------------------------------------------------\n');
fprintf('Aplicação: RBF\n');
fprintf('Grid Search:. \n');
fprintf('       Faixa de sigma:<%d,%d>\n',min(gridS),max(gridS));
fprintf('       Faixa de número de neurônios:<%d,%d>\n',min(gridnH),max(gridnH));
fprintf('Quantidade de padrões de treinamento: %d. \n', (1-pTeste) * m);
fprintf('Quantidade de padrões de teste: %d. \n', pTeste * m);
fprintf('Quantidade de classes: %d. \n', nClasses);
fprintf('Quantidade de atributos: %d. \n', n);
fprintf('--------------------------------------------------\n\n');
fprintf('Aguarde...\n\n');
%% Realizando o Grid Search

for sIndex=1:length(gridS)
    s = gridS(sIndex);

    for nhIndex=1:length(gridnH)
        nh = gridnH(nhIndex);
        
        acMedia = 0;
        for i=1:nIt

            %traz os dados embaralhados e particionados
            [xd yd xt yt] = preparaDados(nx,y,pTeste);

             %Treina uma rede RBF 
            [W Mc,Sigma] = treinaRBF(xd,yd,s,nh);

            %Avalia resultado do treinamento com amostras de teste
            yc = avaliaRBF(xt,Mc,Sigma,W);

            [v yci] = max(yc');
            [v ydi] = max(yt');

            acuracia = sum( yci == ydi)/length(ydi);
            acMedia = acMedia + acuracia;
        end

        acMedia = acMedia/nIt;
        medias(ss) = acMedia;
        gSearchAcc(nhIndex,sIndex) = acMedia;
        
        ss = ss + 1;
        subplot(1,2,1)
        plot(medias);
        
        subplot(1,2,2)
        colormap('hot');
        imagesc(gSearchAcc);
        drawnow;
        
        %fprintf('grid search s x nH(%d , %d) = %f\n', s,nh,acMedia);
    end
end

[nhIndex, sIndex] = find(ismember(gSearchAcc, max(gSearchAcc(:))));
nhIndex = nhIndex(1);
sIndex = sIndex(1);
nh = gridnH(nhIndex);
s = gridS(sIndex);

fprintf('Valores ótimos encontrados para sigma e quantidade de neurônios: %d , %d. \n', s, nh);


 
%% Avaliando desempenho
 
 fprintf('Avaliando desempenho final.\n');
 acuracia = 0;
 acMedia = 0;
 cm = zeros(nClasses,nClasses);
for i=1:nIt

    [xd yd xt yt] = preparaDados(nx,y,pTeste);

     %Treina uma rede RBF
    [W Mc,Sigma] = treinaRBF(xd,yd,s,nh);

    %Avalia resultado do treinamento com amostras de teste
    yc = avaliaRBF(xt,Mc,Sigma,W);

    [v yci] = max(yc');
    [v ydi] = max(yt');
    cm = cm + confusionmat(int32(yci),int32(ydi));

    acuracia = sum( yci == ydi)/length(ydi);
    acMedia = acMedia + acuracia;
end
        
 acMedia = acMedia/nIt;  

 cm
 acMedia
 
 %%Gravando CM
 filename = ['saida/RBF_confusion_'    base   '.csv'];
 saveconfusionMat(filename, cm, labels);
 fprintf('Avaliação concluída.');
 