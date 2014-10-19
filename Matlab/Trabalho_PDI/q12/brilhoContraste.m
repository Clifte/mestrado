close all;clear;
%Carregando e exibindo Imagem Original
image = imread('../bd/pirate.tif');
figure
subplot(1,2,1);
imshow(image);
subplot(1,2,2);
imhist(image);

figure;
res = ajustaContraste(image,2);
subplot(3,4,1);
imshow(res);
xlabel('a', 'FontSize', 15)
subplot(3,4,2);
imhist(res);
imwrite(res,'altoContraste.png');


res = ajustaContraste(image,0.5);
subplot(3,4,3);
imshow(res);
xlabel('b', 'FontSize', 15)
subplot(3,4,4);
imhist(res);
title('Baixo contraste: 0.5')
imwrite(res,'baixoContraste.png');



res = ajustaBrilho(image,25);
subplot(3,4,5);
imshow(res);
xlabel('c', 'FontSize', 15)
subplot(3,4,6);
imhist(res);
title('Alto Brilho: 100')
imwrite(res,'altoBrilho.png');


res = ajustaBrilho(image,-25);
subplot(3,4,7);
imshow(res);
xlabel('d', 'FontSize', 15)
subplot(3,4,8);
imhist(res);
title('Baixo Brilho: -100')
imwrite(res,'baixoBrilho.png');

res = ajustaGama(image,2);
subplot(3,4,9);
imshow(res);
xlabel('e', 'FontSize', 15)
subplot(3,4,10);
imhist(res);
title('Alto Gama: 2')
imwrite(res,'altoGama.png');

res = ajustaGama(image,0.5);
subplot(3,4,11);
imshow(res);
xlabel('f', 'FontSize', 15)
subplot(3,4,12);
imhist(res);
title('Baixo Gama: 0.5')
imwrite(res,'baixoGama.png');