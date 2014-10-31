addpath(genpath('../util/'))
clear all; clear;clc
 warning('off','all')

 %%
%Grid search para o n�mero de neur�nios ocultos
grid = (10:10:250);

%N�mero de itera��es para o c�lculo da acur�cia
nIt = 1;
 %%
 
%Carregando dados
[ x , y ] = carregaDadosIris( 4 , '../database/iris/bezdekIris.data' );

%Normalizando X.
[m n] =size(x);
mx = mean(x);
sx = std(x);
nx = (x - repmat(mx,m,1)) ./ repmat(sx,m,1);

%Matriz confus�o
cm =  zeros(3,3);

ss=1;
medias = zeros(1,length(grid));
for s=grid
    s 
    acMedia = 0;
    for i=1:nIt
        %Embaralhando DataSet
        [nx , y ] = permutaDadosIris(nx,y);

        %Particionando dados
        [xt yt xd yd] = particionaDadosIris(nx,y,0.25);

        [Wh Wm]=treinaELM(xd,yd,s);
 
        yc = avaliaElm(xt,Wh,Wm);

        [v yci] = max(yc');
        [v ydi] = max(yt');
        cm = cm + confusionmat(int32(yci),int32(ydi));

        acuracia = sum( yci == ydi)/length(ydi);
        acMedia = acMedia + acuracia;
    end
    
    acMedia = acMedia/nIt;
    medias(ss) = acMedia;

    ss = ss + 1;
    plot(grid,medias);
    drawnow;
end

[v l] = max(medias);
bestAc = v
bestS = grid(l)
