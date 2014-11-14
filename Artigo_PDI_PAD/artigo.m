%% limpeza
clc;
clear;
close all;
%%
AREA_TOP_THRESH = 2000;
AREA_BOT_THRESH = 500;
BOUND_MAX_PERI_THRESH = 400;
%% leitura da imagem
img = imread('digitos.png');
img = imread('digitosCap.jpg');
%im2=imread('tshape.png');

%% limiar adaptativo
binary = adaptivethreshold(img,11,0.03,0);
binary = ~binary;
%% elemento estruturante
ee = [0 1 0; 1 1 1; 0 1 0];

%% erosao
for i = 1:5
    im_erode = imerode(binary,ee);
end

%% dilatacao
for j = 1:5
    im_dilate = imerode(im_erode,ee);
end

%%
[L N] =  bwlabel(binary,8);
chars = regionprops(L);

%Exibindo caracteres encontrados e filtrando invalidos
imshow(img);
hold on;
toRemove = [];
for i=1:length(chars)
    fi = chars(i);
    bdbox = fi.BoundingBox;
    if( (fi.Area) > AREA_TOP_THRESH)
        rectangle('Position', fi.BoundingBox, 'EdgeColor', 'r');
        toRemove = [toRemove  i];
        continue;
    end
    
    if( (fi.Area) < AREA_BOT_THRESH)
        rectangle('Position', fi.BoundingBox, 'EdgeColor', 'r');
        toRemove = [toRemove  i];
        continue;
    end

    if( ( 2 * bdbox(3) + 2 * bdbox(4) ) > BOUND_MAX_PERI_THRESH)
        rectangle('Position', fi.BoundingBox, 'EdgeColor', 'r');
        toRemove = [toRemove  i];
        continue;
    end
    
    rectangle('Position', fi.BoundingBox, 'EdgeColor', 'b');
    
end


chars(toRemove)=[];

features = extrair(chars,binary);

%Ordenando por labels
[v i] =sort(features(:,end));
features = features(i,:);
csvwrite('features.csv',features);


figure;
plot(features)
legend('areaRelativa','aspecto','picoPVertical','picoPHorizontal','maxPVertical','maxPHorizontal','label')

%% mostra imagem
figure, imshow(img);
figure, imshow(binary);