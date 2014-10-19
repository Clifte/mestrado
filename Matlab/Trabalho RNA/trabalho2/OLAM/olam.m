 clear all; clear;clc
 
%Carregando dados
[ x , y ] = carregaDados( 4 , '../database/iris/bezdekIris.data' );
xLabelNames = [ 'sLen'; 'sWid'; 'pLen'; 'pWid'];

%Normalizando X.
[m n] =size(x);
mx = mean(x);
sx = std(x);
nx = (x - repmat(mx,m,1)) ./ repmat(sx,m,1);

%Embaralhando DataSet
[nx , y ] = permutaDadosIris(nx,y);

%Particionando dados
 [xt yt xd yd] = particionaDadosIris(nx,y,0.2);

%Calculando Pesos  W = Y * X^-1
in = pinv(xd);
W = in * yd;

%%Calculando Acuracia
yc =  xt* W;
[v sc] = max(yc');
[v l] = max(yt');
acuracia = sum( l == sc)/length(l)


%Mostrando resultados
mostraRegiaoDecisao(W,15,-3:0.1:3);
mostraResultado( xt, yt, xLabelNames,50,'Resultado');