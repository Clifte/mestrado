close all;
clc;
%Carregando imagem
image = imread('../bd/eu.JPG');

subplot(2,2,1)
imshow(image)
xlabel('a', 'FontSize', 15)

%Separando canais HSV
hsv_image = rgb2hsv(image) ;
h = hsv_image(:,:,1);
s = hsv_image(:,:,2);
v = hsv_image(:,:,3);

%Filtrando tons da pele
h = h<0.1 & h>0;
s = s> 0.4 & s < 0.8;
skinMask = double(s & h);

%Canal H filtrado
subplot(2,2,2)
imshow(h)
xlabel('b', 'FontSize', 15)

%Canal S filtrado combinado com H filtrado
subplot(2,2,3)
imshow(skinMask)
xlabel('c', 'FontSize', 15)

%Imagem resultante
res = []
res(:,:,1) = double(image(:,:,1)) .* skinMask;
res(:,:,2) = double(image(:,:,2)) .* skinMask;
res(:,:,3) = double(image(:,:,3)) .* skinMask;

subplot(2,2,4)
imshow(mat2gray(res))
xlabel('d', 'FontSize', 15)