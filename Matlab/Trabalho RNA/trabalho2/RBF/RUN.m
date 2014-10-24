 clear all; clear;clc
 warning('off','all')
%%
%Grid search para o valor do sigma
grid = (0.0001:0.1:10);
grid = 8.7
%N�mero de itera��es para o c�lculo da acur�cia
nIt = 500;
 %%
 
%Carregando dados
[ x , y ] = carregaDados( 4 , '../database/iris/bezdekIris.data' );
xLabelNames = [ 'sLen'; 'sWid'; 'pLen'; 'pWid'];

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

        %Treina uma rede RBF com 10 neur�nios Ocultos
        [W Mc,Sigma] = treinaRBF(xd,yd,s,10);

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
    plot(grid,medias);
    drawnow;
end

[v l] = max(medias);
bestAc = v
bestS = grid(l)
