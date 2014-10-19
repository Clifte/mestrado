clear;
clc;
image = imread('../bd/tree.gif');
[m n] = size(image);
imshow(image);

%%
%Opera��o de rota��o
image30 = imrotate(image,30);
image60 = imrotate(image,60);
image90 = imrotate(image,90);


imwrite(image30,'image30.png');
imwrite(image60,'image60.png');
imwrite(image90,'image90.png');


%%
%Opera��o de redimensionamento
imageScale1 = imresize(image, 0.5);
imageScale2 = imresize(image, 1.5);
imageScale3 = imresize(image, 2);

imwrite(imageScale1,'imageScale1.png');
imwrite(imageScale2(1:m,1:n),'imageScale2.png');
imwrite(imageScale3(1:m,1:n),'imageScale3.png');


%%
%Opera��o de transla��o
imageT1 = imtranslate( image, [50,  0] );
imageT2 = imtranslate( image, [0 50] );
imageT3 = imtranslate( image, [50 50]);

imwrite(imageT1,'imageT1.png');
imwrite(imageT2,'imageT2.png');
imwrite(imageT3,'imageT3.png');
