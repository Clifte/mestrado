close all;clear

%Carregando imagem
image = imread('../bd/walkbridge.tif');
image = image(:,:,1);

subplot(4,2,1);
imshow(image);
title('Original');

%Aplicando transformada de Fourier
spec = fft2(image);

%Exibindo Spectro de Fourier
 ;
subplot(4,2,2)
surf(fftshift(log(abs(spec))),'EdgeColor','None')
imwrite(mat2gray(fftshift(log(abs(spec)))),'espectroOriginal.png')
title('Espectro');


%% Passa Baixa

var = 3;
d = 20/length(spec(1,:));

%Calculando filtro gaussiano
filtro = gaussmf(-10:d:10,[var 0])'  *  gaussmf(-10:d:10,[var 0]);
filtro = filtro(   1:length(spec(1,:)), 1:length(spec(1,:)));
imwrite(mat2gray(filtro),'passaBaixa.png');
%filtro = double(filtro > 0.5);

 ;
subplot(4,2,3)
surf(filtro,'EdgeColor','None')
title('Filtro Passa Baixa');

%Filtrando
filtrada = filtro .* fftshift(spec);

 ;
subplot(4,2,5)
surf(log(abs(filtrada)),'EdgeColor','None')
imwrite(mat2gray(log(abs(filtrada))),'filtradaPBSpec.png');
title('Filtrada Baixa');

%Exibindo imagem resultante

espaco = uint8(ifft2(fftshift(filtrada)));
 
imwrite(espaco,'filtradaPB.png')
subplot(4,2,7)
imshow(espaco);
title('Resultado Passa Baixa');





%% Passa Alta

var = 3;
d = 20/length(spec(1,:));

%Calculando filtro gaussiano invertido
filtro = gaussmf(-10:d:10,[var 0])'  *  gaussmf(-10:d:10,[var 0]);
filtro = filtro(   1:length(spec(1,:)), 1:length(spec(1,:)));
filtro = 1 - filtro;
imwrite(mat2gray(filtro),'passaAlta.png');

%filtro = double(filtro < 0.5);

 ;
subplot(4,2,4)
surf(filtro,'EdgeColor','None')
title('Filtro Passa Alta');

%Filtrando
filtrada = filtro .* fftshift(spec);

 ;
imwrite(mat2gray(log(abs(filtrada+1))),'filtradaPASpec.png');
subplot(4,2,6)
surf(log(abs(filtrada)),'EdgeColor','None')
title('Filtrada Passa Alta');

%Exibindo imagem resultante

espaco = mat2gray(uint8(ifft2(fftshift(filtrada))));
 
imwrite(espaco,'filtradaPA.png')
subplot(4,2,8)
imshow(espaco);
title('Resultado Passa Alta');