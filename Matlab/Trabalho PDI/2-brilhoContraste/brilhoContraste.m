close all
image = imread('../bd/pirate.tif');
imshow(image)


imwrite(image * 2,'altoContraste.png');
imwrite(image * 0.5 + 50,'baixoContraste.png');
imwrite(image + 100,'altoBrilho.png');
imwrite(image -100,'baixoBrilho.png');
