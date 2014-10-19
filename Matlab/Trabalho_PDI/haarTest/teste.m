clear all;
close all;

%%Carregando imagem
N = 256;
lowLevel = 2;
image = imread('../bd/lena_gray_256.tif');
%image = image(:,:,3);
image = image(1:N,1:N);
figure;
imshow(image);
title 'Original'

%Contruindo mascara de Haar horizontal
mask = ConstructHaarWaveletTransformationMatrix(N);

figure
imshow(mask);

%Calculando imagem Horizontal  dwt2(f,wname);
resH = mask * double(image) * (mask');
l = 2^lowLevel;
resH(1:l,1:l) = 0;


figure
imshow(uint8(resH));
title 'resultado H';

%Calculando a inversa
recup = mat2gray(inv(mask)*resH*inv(mask'));

figure
imshow(recup);
title 'recuperada';

