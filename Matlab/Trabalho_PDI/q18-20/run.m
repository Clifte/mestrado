clear all;
close all;
clc;
%Carregando imagem
A = imread('../bd/lena_gray_256.tif');
A2 = imread('../bd/pirate.png');
%Elemento estruturante
B = [ 0 1 0
        1 1 1
        0 1 0
     ]
%Calculando gradiente morfologico
G = imdilate(A,B) - imerode(A,B);
subaxis(2,2,1, 'Spacing', 0.08, 'Padding', 0, 'MB', 0.1, 'MT', 0.01);
imshow(A)
subaxis(2,2,2, 'Spacing', 0.08, 'Padding', 0, 'MB', 0.1, 'MT', 0.01);
imshow(G) 
 
%Calculando gradiente morfologico
G2 = imdilate(A2,B) - imerode(A2,B);
subaxis(2,2,3, 'Spacing', 0.08, 'Padding', 0, 'MB', 0.1, 'MT', 0.01);
imshow(A2)
subaxis(2,2,4, 'Spacing', 0.08, 'Padding', 0, 'MB', 0.1, 'MT', 0.01);
imshow(G2)

