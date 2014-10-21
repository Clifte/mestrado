clear all;
close all;

%%Carregando imagem
N = 256;
lowLevel = 2;
image = imread('../bd/lena_gray_256.tif');

%Pegando imagem quadrada
image = image(1:N,1:N);
figure;
imshow(image);
title 'Original'

%mask = ConstructHaarWaveletTransformationMatrix(N);
%Calculando decomposi��o n�vel 1
[dH dV dD dA] = haarDecomposition(image)
figure
exibeDecomposicao( dH, dV, dD, dA );


%Calculando decomposi��o n�vel 2
figure
[dH dV dD dA] = haarDecomposition(dA)
exibeDecomposicao( dH, dV, dD, dA );

%Calculando decomposi��o n�vel 3
figure
[dH dV dD dA] = haarDecomposition(dA)
exibeDecomposicao( dH, dV, dD, dA );