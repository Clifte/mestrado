addpath(genpath('../util/'))
clear all; clear;clc
warning('off','all')

%%
%Grid search para o valor do sigma e o número de NH
gridS = (0.0001:0.5:10);
gridnH = 5:2:20;
%grid = 8.7;
%Número de iterações para o cálculo da acurácia
nIt = 50;
%Percentual de amostras para teste
pTeste = 0.2;

 %%
%Carregando dados
[ x , y ] = carregaDatabase('derme');

%Normalizando X.
[m n] =size(x);
mx = mean(x);
sx = std(x);
nx = (x - repmat(mx,m,1)) ./ repmat(sx,m,1);

%Matriz confusão
cm =  zeros(3,3);

ss=1;
medias = zeros(1,length(gridS) + length(gridnH));

for nh=gridnH
    for s=gridS
        acMedia = 0;
        for i=1:nIt

            [xd yd xt yt] = preparaDados(nx,y,pTeste);

             %Treina uma rede RBF com 10 neurônios Ocultos
            [W Mc,Sigma] = treinaRBF(xd,yd,s,nh);

            %Avalia resultado do treinamento com amostras de teste
            yc = avaliaRBF(xt,Mc,Sigma,W);

            [v yci] = max(yc');
            [v ydi] = max(yt');
           % cm = cm + confusionmat(int32(yci),int32(ydi));

            acuracia = sum( yci == ydi)/length(ydi);
            acMedia = acMedia + acuracia;
        end

        acMedia = acMedia/nIt;
        medias(ss) = acMedia;

        ss = ss + 1;
        plot(medias);
        drawnow;
        fprintf('grid search s x nH(%d , %d) = %f\n', s,nh,acMedia);
    end
end
[v l] = max(medias);


fprintf('grid search s x nH(%d , %d) = %f\n',...
                        gridS(1+ mod(l,length(gridS)) ) ,...
                        gridnH(1 + floor(l/length(gridS))), ...
                        v);


