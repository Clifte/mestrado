 clear all; clear;clc
 
%Carregando dados
[ x , y ] = carregaDados( 4 , '../database/iris/bezdekIris.data' );
xLabelNames = [ 'sLen'; 'sWid'; 'pLen'; 'pWid'];

%Normalizando X.
[m n] =size(x);
mx = mean(x);
sx = std(x);
nx = (x - repmat(mx,m,1)) ./ repmat(sx,m,1);


acMedia = 0;
cm =  zeros(3,3);
for i=1:50
    
    %Embaralhando DataSet
    [nx , y ] = permutaDadosIris(nx,y);

    %Particionando dados
    [xt yt xd yd] = particionaDadosIris(nx,y,0.1);

    [W Mc,Sigma] = treinaRBF(xd,yd);

    %Avalia resultado do treinamento com amostras de teste
    yc = avaliaRBF(xt,Mc,Sigma,W);

    [v yci] = max(yc');
    [v ydi] = max(yt');
    cm = cm + confusionmat(yci,ydi);
    
    acuracia = sum( yci == ydi)/length(ydi);
    acMedia = acMedia + acuracia;
end
acuracia
cm

